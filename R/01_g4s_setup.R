# API documentation ---------------------------
#https://www.go4schools.com/Documentation/V1/APIDocumentation.html

# Set up ---------------------------
#' Run set up for gfs functions.
#'
#' Use this function to store your API key for use with gfs functions.
#' Authentication is required for all requests.  See your school's
#' administrator for an API key.
#' @param api_key API key as string.
#' @examples
#' gfs_setup("a96650481f0245eea396726f85ac7049")
#' @export
gfs_setup <- function(api_key) {
  if (missing(api_key))
    api_key <- readline("Please enter your API key without quotes: ")
  .api_headers <- paste0("Bearer ", api_key)
  assign(".api_headers", .api_headers, envir = .GlobalEnv)
}

# Paths ---------------------------
.path_base <- "https://api.go4schools.com/customer/v1/"
.path_base02 <- "https://api.go4schools.com/customer/v1/academic-years/"
.path_contacts_parental <- "contacts/parental"
.path_school <- "school"
.path_student <- "/students"
.path_teaching <- "/teaching"
.path_timetables <- "/timetables"
.path_users <- "users"
.path_behaviour <- "/behaviour"
.path_attendance <- "/attendance"
.path_attainment <- "/attainment"
.path_assessment <- "/assessment"
.path_reports <- "/attainment/reports"

# Messages ---------------------------
message_pagination <- paste0("Process pagination")
message_cursor <- paste0("Cursor at student ID:")

# .gfs_query_message <- function() {
#   if (.result$status_code > 200) {
#     stop(crayon::red("Status code", .result$status_code,
#                      "\nSee https://www.go4schools.com/Documentation/V1/APIDocumentation.html#errors"),
#          call. = FALSE)
#   } else {
#     message(cat(crayon::green("Status code:", .result$status_code)))
#   }
# }

.gfs_query_message <- function() {
  if (.result$status_code == 400) {
    stop(crayon::red("Status code", .result$status_code,
                     "\nBad request.",
                     "\nSee https://www.go4schools.com/Documentation/V1/APIDocumentation.html#errors"),
         call. = FALSE)
  } else if (.result$status_code == 401) {
    stop(crayon::red("Status code", .result$status_code,
                     "\nUnauthorised. Your API key is not valid for this request.",
                     "\nSee https://www.go4schools.com/Documentation/V1/APIDocumentation.html#errors"),
         call. = FALSE)
  } else if (.result$status_code == 403) {
    stop(crayon::red("Status code", .result$status_code,
                     "\nForbidden. Your data officer has disabled this module or embargoed it.",
                     "\nSee https://www.go4schools.com/Documentation/V1/APIDocumentation.html#errors"),
         call. = FALSE)
  } else if (.result$status_code == 404) {
    stop(crayon::red("Status code", .result$status_code,
                     "\nNot found. Check with your school if the resource exists.",
                     "\nSee https://www.go4schools.com/Documentation/V1/APIDocumentation.html#errors"),
         call. = FALSE)
  } else if (.result$status_code == 429) {
    stop(crayon::red("Status code", .result$status_code,
                     "\nToo many requests.",
                     "\nSee https://www.go4schools.com/Documentation/V1/APIDocumentation.html#errors"),
         call. = FALSE)
  } else if (.result$status_code == 500) {
    stop(crayon::red("Status code", .result$status_code,
                     "\nInternal server error. Try again later.",
                     "\nSee https://www.go4schools.com/Documentation/V1/APIDocumentation.html#errors"),
         call. = FALSE)
  } else {
    message(cat(crayon::green("Status code:", .result$status_code)))
  }
}

# Query functions ---------------------------
.gfs_query <- function() {
  .result <<- httr::GET(
    url = .path,
    httr::add_headers(.headers = c("Authorization" = .api_headers))
  )
}

.gfs_query_pagination <- function() {
  nextPage <- .response$cursor
  message(cat(crayon::silver(message_cursor, nextPage)))
  .result_pagination <<- httr::GET(
    url = paste0(.path, "?cursor=", nextPage),
    httr::add_headers(.headers = c("Authorization" = .api_headers))
  )
}

# While function
.gfs_query_while <- function() {
  ## Parse returned data
  .response <<- httr::content(.result, as = "text", encoding = "UTF-8")
  .response <<- jsonlite::fromJSON(.response, flatten = TRUE)
  temp01 <- as.data.frame(.response[[1]])

  ## Start fix for NULL actions and additional student information
  last_col <- colnames(temp01)[ncol(temp01)]
  if (is.list(temp01[ncol(temp01)])) {
    temp01 <- dplyr::filter(temp01, length(!!last_col) > 0)
  }

  temp01 <- tidyr::unnest(temp01, cols = c(ncol(temp01)), names_repair = "universal", keep_empty = TRUE)
  if ("student_ids" %in% colnames(temp01)) {
    temp01 <- tidyr::unnest(temp01, cols = c(student_ids), names_repair = "universal", keep_empty = TRUE)
  }

  last_col <- colnames(temp01)[ncol(temp01)]
  if (ncol(temp01) > 0) {
    if (!!last_col %in% colnames(temp01)) {
      temp01 <- dplyr::mutate(temp01, !!last_col := ifelse(get(last_col) == "NULL", NA, get(last_col)))
      temp01 <- dplyr::mutate(temp01, dplyr::across(dplyr::everything(), as.character))
    }
  }
  ## End fix for NULL actions and additional student information

  ## Loop through the remaining paginations
  message(cat(crayon::silver(message_pagination)))
  while(.response$has_more == TRUE) {
    resp <- .gfs_query_pagination()
    .response <<- httr::content(resp, as = "text", encoding = "UTF-8")
    .response <<- jsonlite::fromJSON(.response, flatten = TRUE)
    temp02 <- as.data.frame(.response[[1]])

    ## Start fix for NULL actions and additional student information
    last_col <- colnames(temp02)[ncol(temp02)]
    if (is.list(temp02[ncol(temp02)])) {
      temp02 <- dplyr::filter(temp02, length(!!last_col) > 0)
    }

    temp02 <- tidyr::unnest(temp02, cols = c(ncol(temp02)), names_repair = "universal", keep_empty = TRUE)
    if ("student_ids" %in% colnames(temp02)) {
      temp02 <- tidyr::unnest(temp02, cols = c(student_ids), names_repair = "universal", keep_empty = TRUE)
    }
    temp02 <- dplyr::mutate(temp02, dplyr::across(dplyr::everything(), as.character))

    if (nrow(temp02) > 0) {
      if ("students_and_attribute_values" %in% colnames(temp02)) {
        temp02 <- dplyr::mutate(
          temp02,
          students_and_attribute_values = ifelse(students_and_attribute_values == "NULL", NA, students_and_attribute_values)
        )
        temp02 <- dplyr::mutate(temp02, dplyr::across(dplyr::everything(), as.character))
        temp02 <- dplyr::filter(temp02, !is.na(students_and_attribute_values))
      }
    }
    ## End fix for NULL actions and additional student information

    if (nrow(temp02) == 0) {
      temp01 <- temp01
    } else {
      temp01 <- dplyr::add_row(temp01, temp02)
      temp01[temp01 == "NULL"] <- NA
    }
  }
  return(temp01)
}
