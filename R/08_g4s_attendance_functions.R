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
  ## Set path
  .path <<- paste0(.path_base02, academicYear, .path_attendance, "/codes")

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
