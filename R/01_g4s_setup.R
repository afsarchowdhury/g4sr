# API documentation ---------------------------
#https://www.go4schools.com/Documentation/V1/APIDocumentation.html

# Set up ---------------------------
#' Run set up for gfs functions.
#'
#' Use this function to store your API key for use with gfs functions.
#' Authentication is required for all requests.  See your school's
#' administrator for an API key.
#' @param api_key API key as string.
#' @examples
#' gfs_setup("a96650481f0245eea396726f85ac7049")
#' @export
gfs_setup <- function(api_key) {
  if (missing(api_key))
    api_key <- readline("Please enter your API key without quotes: ")
  .api_headers <- paste0("Bearer ", api_key)
  assign(".api_headers", .api_headers, envir = .GlobalEnv)
}

# Paths ---------------------------
.path_base <- "https://api.go4schools.com/customer/v1/"
.path_base02 <- "https://api.go4schools.com/customer/v1/academic-years/"
.path_contacts_parental <- "contacts/parental"
.path_school <- "school"
.path_student <- "/students"
.path_teaching <- "/teaching"
.path_timetables <- "/timetables"
.path_users <- "users"
.path_behaviour <- "/behaviour"
.path_attendance <- "/attendance"
.path_attainment <- "/attainment"
.path_assessment <- "/assessment"

# Query functions ---------------------------
.gfs_query <- function() {
  .result <<- httr::GET(
    url = .path,
    httr::add_headers(.headers = c("Authorization" = .api_headers))
  )
}
