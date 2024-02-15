# Teaching functions ---------------------------

## Teaching departments
#' Get departments.
#'
#' Returns details of departments in the chosen academic year.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_teaching_departments(2020)
#' @export
gfs_teaching_departments <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request teaching departments for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_teaching, "/departments")

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

## Teaching subjects
#' Get subjects.
#'
#' Returns all subjects in the chosen academic year.
#' * Use `gfs_teaching_departments()` to resolve department details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_teaching_subjects(2020)
#' @export
gfs_teaching_subjects <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request teaching subjects for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_teaching, "/subjects")

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

## Teaching teachers
#' Get teachers.
#'
#' Returns details of the teachers in the chosen academic year.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_teaching_teachers(2020)
#' @export
gfs_teaching_teachers <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request teachers for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_teaching, "/teachers")

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

## Teaching groups
#' Get groups.
#'
#' Returns details of teaching groups for each subject in the chosen academic
#' year.
#' * Use `gfs_teaching_subjects()` to resolve subject details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_teaching_groups(2020)
#' @export
gfs_teaching_groups <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request teaching groups for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_teaching, "/groups")

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

## Teaching groups and students
#' Get groups and students.
#'
#' Returns details of the students in each teaching group in the chosen
#' academic year.
#' * Use `gfs_teaching_groups()` to resolve group details.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_teaching_groups_students(2020)
#' @export
gfs_teaching_groups_students <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request students in teaching groups for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_teaching, "/groups/students")

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

## Teaching groups and teachers
#' Get groups and teachers.
#'
#' Returns details of teachers assigned to each teaching group in the chosen
#' academic year.
#' * Use `gfs_teaching_groups()` to resolve group details.
#' * Use `gfs_teaching_teachers()` to resolve teacher details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_teaching_groups_teachers(2020)
#' @export
gfs_teaching_groups_teachers <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request teachers in teaching groups for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_teaching, "/groups/teachers")

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
