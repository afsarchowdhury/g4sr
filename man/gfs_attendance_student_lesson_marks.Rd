% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/08_g4s_attendance_functions.R
\name{gfs_attendance_student_lesson_marks}
\alias{gfs_attendance_student_lesson_marks}
\title{Get student lesson marks.}
\usage{
gfs_attendance_student_lesson_marks(academicYear, goDate)
}
\arguments{
\item{academicYear}{academic year as integer.}

\item{goDate}{date as string in the form yyyy-mm-dd.}
}
\description{
Returns lesson attendance details for a particular date.
\itemize{
\item Use \code{gfs_attendance_codes} to resolve attendance codes.
\item Use \code{gfs_student_details()} to resolve student personal details.
\item Use \code{gfs_classes()} to resolve timetabled classes.
}
}
\examples{
gfs_attendance_student_lesson_marks(2020, "2020-07-01")
}
