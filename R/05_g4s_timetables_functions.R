# Timetables functions ---------------------------

## Timetables
#' Get timetables.
#'
#' Returns details of the timetables and their associated periods for the
#' chosen academic year.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_timetables(2020)
#' @export
gfs_timetables <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request timetables for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_timetables)

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

## Calendar
#' Get calendar.
#'
#' Returns details of when the school is open, closed or open for staff
#' training only in the chosen academic year.
#' * Use `gfs_timetables()` to resolve date, week, and period details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_calendar(2020)
#' @export
gfs_calendar <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request calendar for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_timetables, "/calendar")

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

## Classes
#' Get classes.
#'
#' Returns details of all timetabled classes in the chosen academic year.
#' * Use `gfs_timetables()` to resolve date, week, and period details.
#' * Use `gfs_teaching_teachers()` to resolve teacher details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_classes(2020)
#' @export
gfs_classes <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request classes for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_timetables, "/classes")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse and loop paginations
  temp01 <- .gfs_query_while()

  return(temp01)
}

## Student classes
#' Get student classes.
#'
#' Returns details of which students are linked to which timetabled classes in
#' the chosen academic year.
#' * Use `gfs_classes()` to resolve class details.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_student_classes(2020)
#' @export
gfs_student_classes <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request students assigned to classes for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_timetables, "/student-classes")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse and loop paginations
  temp01 <- .gfs_query_while()

  return(temp01)
}
