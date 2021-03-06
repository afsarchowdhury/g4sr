% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/03_g4s_student_functions.R
\name{gfs_student_general}
\alias{gfs_student_general}
\title{Get general attributes.}
\usage{
gfs_student_general(academicYear)
}
\arguments{
\item{academicYear}{academic year as integer.}
}
\description{
Returns general student attributes for the chosen academic year.  This will
include all custom attributes and also system attributes not returned by
other endpoints.
\itemize{
\item Use \code{gfs_student_details()} to resolve student personal details.
}
}
\examples{
gfs_student_general(2020)
}
