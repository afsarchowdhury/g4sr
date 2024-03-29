# Report functions ---------------------------

## Reports
#' Get reports.
#'
#' Returns details of available progress reports in the chosen academic year,
#' including the grades and attributes associated with each set of reports.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_reports(2021)
#' @export
gfs_reports <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request reports for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_reports)

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  #temp01 <- dplyr::mutate(temp01, dplyr::across(dplyr::everything(), as.character))
  temp01 <- dplyr::mutate(temp01, dplyr::across(dplyr::where(is.integer), .fns = as.character))
  return(temp01)
}

## Report attributes
#' Get report attributes.
#'
#' Returns attributes for students in chosen academic year and report.
#' * Use `gfs_reports` to resolve name and points value for an attribute choice
#' for the student.
#' * Use `gfs_teaching_subjects()` to resolve subject details.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @param reportID report ID as integer.
#' @examples
#' gfs_reports_attributes(2021, 57102)
#' @export
gfs_reports_attributes <- function(academicYear, reportID) {
  ## Message
  message(cat(crayon::silver("Request report attributes for", academicYear, "report ID", reportID)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_reports, "/", reportID, "/attributes")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  temp01 <- tidyr::unnest(temp01, cols = c(ncol(temp01)), names_repair = "universal")
  temp01 <- dplyr::mutate(temp01, dplyr::across(dplyr::everything(), as.character))
  return(temp01)
}

## Report grades
#' Get report grades
#'
#' Returns grades for students in chosen academic year and report.
#' * Use `gfs_reports` to resolve name and points value for an attribute choice
#' for the student.
#' * Use `gfs_teaching_subjects()` to resolve subject details.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @param reportID report ID as integer.
#' @examples
#' gfs_reports_grades(2021, 57102)
#' @export
gfs_reports_grades <- function(academicYear, reportID) {
  ## Message
  message(cat(crayon::silver("Request report grades for", academicYear, "report ID", reportID)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_reports, "/", reportID, "/grades")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  temp01 <- tidyr::unnest(temp01, cols = c(ncol(temp01)), names_repair = "universal")
  temp01 <- dplyr::mutate(temp01, dplyr::across(dplyr::everything(), as.character))
  return(temp01)
}

## Report comments
#' Get report comments
#'
#' Returns comments for students in chosen academic year and report.
#' * Use `gfs_reports` to resolve name and points value for an attribute choice
#' for the student.
#' * Use `gfs_teaching_subjects()` to resolve subject details.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @param reportID report ID as integer.
#' @examples
#' gfs_reports_comments(2021, 57102)
#' @export
gfs_reports_comments <- function(academicYear, reportID) {
  ## Message
  message(cat(crayon::silver("Request report comments for", academicYear, "report ID", reportID)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_reports, "/", reportID, "/comments")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse and loop paginations
  temp01 <- .gfs_query_while()

  return(temp01)
}
