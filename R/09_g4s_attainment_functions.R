# Attainment functions ---------------------------

## Grade types
#' Get grade types.
#'
#' Returns details of the available types of headline grades.
#' @param academicYear academic year as integer.
#' @param yearGroup year group as string.
#' @examples
#' gfs_attainment_grade_types(2020, "11")
#' @export
gfs_attainment_grade_types <- function(academicYear, yearGroup) {
  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_attainment, "/grade-types/year-group/", yearGroup)

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  message(paste0("Status code: ", .result$status_code))

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  return(temp01)
}

## Grade
#' Get grades.
#'
#' Returns details of the headline grades for students.
#' * Use `gfs_attainment_grade_types()` to resolve grade names.
#' * Use `gfs_student_details()` to resolve student personal details.
#' * Use `gfs_teaching_subjects()` to resolve subject details.
#' @param academicYear academic year as integer.
#' @param yearGroup year group as string.
#' @examples
#' gfs_attainment_grades(2020, "11")
#' @export
gfs_attainment_grades <- function(academicYear, yearGroup) {
  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_attainment, "/grades/year-group/", yearGroup)

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  message(paste0("Status code: ", .result$status_code))

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  temp01 <- as.data.frame(temp01[1])
  return(temp01)
}

## Exam results
#' Get exam results.
#'
#' Returns details of the exam results achieved by students.
#' * Use `gfs_student_details()` to resolve student personal details.
#' * Use `gfs_teaching_subjects()` to resolve subject details.
#' @param academicYear academic year as integer.
#' @param yearGroup year group as string.
#' @examples
#' gfs_attainment_exam_results(2020, "11")
#' @export
gfs_attainment_exam_results <- function(academicYear, yearGroup) {
  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_attainment, "/exam-results/year-group/", yearGroup)

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  message(paste0("Status code: ", .result$status_code))

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  return(temp01)
}
