% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/07_g4s_behaviour_functions.R
\name{gfs_behaviour_events}
\alias{gfs_behaviour_events}
\title{Get events.}
\usage{
gfs_behaviour_events(academicYear, goDate)
}
\arguments{
\item{academicYear}{academic year as integer.}

\item{goDate}{date as string in the form yyyy-mm-dd.}
}
\description{
Returns lists of events for a particular date within an
academic year.
\itemize{
\item Use \code{gfs_behaviour_event_types()} to resolve event characteristics.
\item Use \code{gfs_student_details()} to resolve student personal details.
}
}
\examples{
gfs_behaviour_events(2020, "2020-03-19")
}
