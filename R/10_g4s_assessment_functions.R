# Assessment functions ---------------------------

## Markbooks
#' Get markbooks.
#'
#' Returns the structure of markbooks in the chosen academic year, in terms of
#' the marksheets they contain, and the markslots within each marksheet.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_assessment_markbooks(2020)
#' @export
gfs_assessment_markbooks <- function(academicYear) {
  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_assessment, "/markbooks")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  message(paste0("Status code: ", .result$status_code))

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  temp01 <- tidyr::unnest(temp01, cols = c(ncol(temp01)), names_repair = "universal")
  temp01 <- tidyr::unnest(temp01, cols = c(ncol(temp01)), names_repair = "universal")
  return(temp01)
}

## Marksheets
#' Get marksheets.
#'
#' Returns details of the grades achieved by students for individual marksheets.
#' * Use `gfs_assessment_markbooks()` to resolve markbooks.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_assessment_marksheet_grades(2020)
#' @export
gfs_assessment_marksheets <- function(academicYear) {
  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_assessment, "/marksheet-grades")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  message(paste0("Status code: ", .result$status_code))

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  temp01 <- as.data.frame(temp01[1])
  temp01 <- tidyr::unnest(temp01, cols = c(ncol(temp01)), names_repair = "universal")
  return(temp01)
}

## Marks
#' Get marks.
#'
#' Returns details of the marks achieved by students for individual marks.
#' * Use `gfs_assessment_markbooks()` to resolve markbooks.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_assessment_marks(2020)
#' @export
gfs_assessment_marks <- function(academicYear) {
  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_assessment, "/marks")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  message(paste0("Status code: ", .result$status_code))

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  temp01 <- as.data.frame(temp01[1])
  temp01 <- tidyr::unnest(temp01, cols = c(ncol(temp01)), names_repair = "universal")
  return(temp01)
}
