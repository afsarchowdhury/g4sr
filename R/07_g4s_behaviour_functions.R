# Behaviour functions ---------------------------

## Follow-up actions
#' Get follow-up actions.
#'
#' Returns the current definitions for follow up behaviour actions for the
#' supplied academic year.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_behaviour_followup(2020)
#' @export
gfs_behaviour_followup <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request follow-up actions")))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_behaviour, "/actions/follow-up")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  return(temp01)
}

## Immediate actions
#' Get immediate actions.
#'
#' Returns the current definitions for immediate behaviour actions for the
#' supplied academic year.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_behaviour_immediate(2020)
#' @export
gfs_behaviour_immediate <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request immediate actions")))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_behaviour, "/actions/immediate")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  return(temp01)
}

## Classification
#' Get classifications.
#'
#' Returns the current behaviour classification groups for the
#' supplied academic year.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_behaviour_classification(2020)
#' @export
gfs_behaviour_classification <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request behaviour classifications")))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_behaviour, "/classification")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  temp01 <- temp01[, 1:3]
  return(temp01)
}

## Event types
#' Get event types.
#'
#' Returns the current definition of the behaviour types for the
#' supplied academic year.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_behaviour_event_types(2020)
#' @export
gfs_behaviour_event_types <- function(academicYear) {
  ## Message
  message(cat(crayon::silver("Request event types")))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_behaviour, "/event-types")

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  temp01 <- jsonlite::fromJSON(response, flatten = TRUE)
  return(temp01)
}

## Events
#' Get events.
#'
#' Returns lists of events for a particular date within an
#' academic year.
#' * Use `gfs_behaviour_event_types()` to resolve event characteristics.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @param goDate date as string in the form yyyy-mm-dd.
#' @examples
#' gfs_behaviour_events(2020, "2020-03-19")
#' @export
gfs_behaviour_events <- function(academicYear, goDate) {
  ## Message
  message(cat(crayon::silver("Request events for", goDate)))

  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_behaviour, "/events/date/", goDate)

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse and loop paginations
  temp01 <- .gfs_query_while()

  return(temp01)
}

## Events date range
#' Get events over a range of dates.
#'
#' Returns list of events over a range of dates within
#' an academic year.
#' * Use `gfs_behaviour_event_types()` to resolve event characteristics.
#' * Use `gfs_student_details()` to resolve student personal details.
#' @param academicYear academic year as integer.
#' @param goDateStart start date of range as string in the form yyyy-mm-dd.
#' @param goDateEnd end date of range as string in the form yyyy-mm-dd.
#' @examples
#' gfs_behaviour_events_range(2020, "2020-03-16", "2020-03-19")
#' @export
gfs_behaviour_events_range <- function(academicYear, goDateStart, goDateEnd) {

  ## Create date range sequence
  goDate <- seq(as.Date(goDateStart), as.Date(goDateEnd), 1)

  ## Iterate over date range
  temp01 <- lapply(1:length(goDate),
                   function(i) gfs_behaviour_events(academicYear = academicYear,
                                                    goDate = goDate[i]))

  ## Bind list
  temp01 <- data.table::rbindlist(temp01)
  return(temp01)
}
