# Student functions ---------------------------

## Student details
#' Get students details.
#'
#' Returns the current personal details (DOB, gender, names) of the students
#' that were at school in the chosen academic year.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_student_details(2020)
#' @export
gfs_student_details <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request student details for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_student)

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  return(jsonlite::fromJSON(response, flatten = TRUE))
}

## Student general attributes
#' Get general attributes.
#'
#' Returns general student attributes for the chosen academic year.  This will
#' include all custom attributes and also system attributes not returned by
#' other endpoints.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_student_general(2020)
#' @export
gfs_student_general <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request student general attributes for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_student, "/attributes")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse and loop paginations
  temp01 <- .gfs_query_while()

  return(temp01)
}

## Student demographics
#' Get demographic attributes.
#'
#' Returns the following attributes for students for the chosen academic year:
#' country of birth, home language, first language, and nationality.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_student_demographics(2020)
#' @export
gfs_student_demographics <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request student demographic attributes for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_student, "/attributes/demographic")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse and loop paginations
  temp01 <- .gfs_query_while()

  return(temp01)
}

## Student SEND
#' Get SEND attributes.
#'
#' Returns the following attributes for students for the chosen academic year:
#' SEN code, SEN status, educational needs, gifted/talented, gifted/talented
#' subject.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_student_send(2020)
#' @export
gfs_student_send <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request student SEN attributes for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_student, "/attributes/send")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse and loop paginations
  temp01 <- .gfs_query_while()

  return(temp01)
}

## Student sensitive
#' Get sensitive attributes.
#'
#' Returns the following attributes for students for the chosen academic year:
#' FSM, FSMEver6, EAL, disadvantaged, ethnicity, ethnicity code, ever in care,
#' looked after, pupil premium indicator, service child, traveller type.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_student_sensitive(2020)
#' @export
gfs_student_sensitive <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request student sensitive attributes for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_student, "/attributes/sensitive")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse and loop paginations
  temp01 <- .gfs_query_while()

  return(temp01)
}

## Student education details
#' Get education details.
#'
#' Returns education details for students.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_student_edu_details(2020)
#' @export
gfs_student_edu_details <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request education details for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_student, "/education-details")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  .response <<- httr::content(.result)

  ## Create list to be filled by cursor paginations
  payload_list <- as.list(.response[[1]])

  ## Loop through the remaining paginations
  message(cat(crayon::silver("Process pagination")))
  while(.response$has_more == TRUE) {
    resp <- .gfs_query_pagination()
    .response <<- httr::content(resp)
    payload_list <- append(payload_list, .response[[1]])
  }

  ## Bind cursor paginations and return
  temp01 <- dplyr::bind_rows(payload_list)
  return(temp01)
}

## Student medical conditions
#' Get student medical conditions.
#'
#' Returns medical conditions for students.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_student_medical(2020)
#' @export
gfs_student_medical <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request student medical conditions for", academicYear)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_student, "/medical-conditions")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse and loop paginations
  temp01 <- .gfs_query_while()

  return(temp01)
}
