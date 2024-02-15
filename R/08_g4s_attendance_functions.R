# Attendance functions ---------------------------

## Attendance codes
#' Get attendance codes.
#'
#' Returns the Attendance codes and any aliases being used for the
#' academic year.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_attendance_codes(2020)
#' @export
gfs_attendance_codes <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request attendance codes for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_attendance, "/codes")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  #temp01 <- dplyr::mutate(temp01, dplyr::across(dplyr::everything(), as.character))
  return(temp01)
}

## Student session marks
#' Get student session marks.
#'
#' Returns session attendance details for a particular date.
#' * Use `gfs_attendance_codes` to resolve attendance codes.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @param goDate date as string in the form yyyy-mm-dd.
#' @examples
#' gfs_attendance_student_session_marks(2020, "2020-07-01")
#' @export
gfs_attendance_student_session_marks <- function(academicYear, goDate) {
  ## Message
  message(cat(crayon::silver("Request student session marks for", academicYear, "date", goDate)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_attendance, "/student-session-marks/date/", goDate)

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  temp01 <- dplyr::mutate(temp01, dplyr::across(dplyr::everything(), as.character))
  return(temp01)
}

## Student lesson marks
#' Get student lesson marks.
#'
#' Returns lesson attendance details for a particular date.
#' * Use `gfs_attendance_codes` to resolve attendance codes.
#' * Use `gfs_student_details()` to resolve student personal details.
#' * Use `gfs_classes()` to resolve timetabled classes.
#' @param academicYear academic year as integer.
#' @param goDate date as string in the form yyyy-mm-dd.
#' @examples
#' gfs_attendance_student_lesson_marks(2020, "2020-07-01")
#' @export
gfs_attendance_student_lesson_marks <- function(academicYear, goDate) {
  ## Message
  message(cat(crayon::silver("Request student lesson marks for", academicYear, "date", goDate)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_attendance, "/student-lesson-marks/date/", goDate)

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  temp01 <- dplyr::mutate(temp01, dplyr::across(dplyr::everything(), as.character))
  return(temp01)
}

## Student attendance summary
#' Get student attendance summary.
#'
#' Returns summary session data for all students for the academic
#' year up to (but not including) today.
#' * Use `gfs_attendance_codes` to resolve attendance codes.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_attendance_student_summary(2020)
#' @export
gfs_attendance_student_summary <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request student attendance summary for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_attendance, "/student-session-summary")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  temp01 <- dplyr::mutate(temp01, dplyr::across(dplyr::everything(), as.character))
  return(temp01)
}
