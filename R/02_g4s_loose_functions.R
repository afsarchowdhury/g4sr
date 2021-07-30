# Loose functions ---------------------------

## Parental contacts
#' Get parental contacts.
#'
#' Returns details of parental contacts for students.
#' @export
gfs_contacts_parental <- function() {
  ## Message
  message(cat(crayon::silver("Request parent contact details")))

  ## Set path
  .path <<- paste0(.path_base, .path_contacts_parental)

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  return(jsonlite::fromJSON(response, flatten = TRUE))
}

## School
#' Get school details.
#'
#' Returns details of the school and the available academic years.
#' @export
gfs_school <- function() {
  ## Message
  message(cat(crayon::silver("Request school details")))

  ## Set path
  .path <<- paste0(.path_base, .path_school)

  ## Store query
  .gfs_query()

  ## Check if the API returned an error. If the request fails the API will return a non-200 status code
  .gfs_query_message()

  ## Parse returned data as text
  response <- httr::content(.result, as = "text", encoding = "UTF-8")

  ## Parse the JSON content and and convert it to a data frame
  return(jsonlite::fromJSON(response, flatten = TRUE))
}
