% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/03_g4s_student_functions.R
\name{gfs_student_sensitive}
\alias{gfs_student_sensitive}
\title{Get sensitive attributes.}
\usage{
gfs_student_sensitive(academicYear)
}
\arguments{
\item{academicYear}{academic year as integer.}
}
\description{
Returns the following attributes for students for the chosen academic year:
FSM, FSMEver6, EAL, disadvantaged, ethnicity, ethnicity code, ever in care,
looked after, pupil premium indicator, service child, traveller type.
\itemize{
\item Use \code{gfs_student_details()} to resolve student personal details.
}
}
\examples{
gfs_student_sensitive(2020)
}
