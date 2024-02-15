# Users functions ---------------------------

## Parent users
#' Get parents.
#'
#' Returns details of parent user accounts.
#' @export
gfs_users_parent <- function() {
  ## Message
  message(cat(crayon::silver("Request parent details")))

  ## Set path
  .path <<- paste0(.path_base, .path_users, "/parents")

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

## Staff users
#' Get staff.
#'
#' Returns details of staff user accounts.
#' @export
gfs_users_staff <- function() {
  ## Message
  message(cat(crayon::silver("Request staff details")))

  ## Set path
  .path <<- paste0(.path_base, .path_users, "/staff")

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
