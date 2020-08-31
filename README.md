
<!-- README.md is generated from README.Rmd. Please edit that file -->

# g4sr

<!-- badges: start -->

<!-- badges: end -->

`g4sr` is an API wrapper for Go4Schools. It allows you to manage school
data. Authentication is required for all requests. See your school’s
administrator for an API key.

## Note

I am in no way affiliated with
[Go4Schools](https://www.go4schools.com/). I am an end user of their
[API](https://www.go4schools.com/Documentation/V1/APIDocumentation.html)
who happens to use [R](https://www.r-project.org/) quite a lot.

There are a few API calls that are yet to be included.

## Installation

A [CRAN](https://cran.r-project.org/) version is unavailable at this
time. You can install the development version from
[GitHub](https://github.com/) by typing the following:

``` r
# install.packages("devtools")
devtools::install_github("afsarchowdhury/g4sr")
```

## Setup

Run `gfs_setup()` and enter your API key in the console. This is needed
before any of the functions can be used.

## Example

To return details of the school and the available academic years:

``` r
library(g4sr)
gfs_school()
```

To return the school calendar for the academic year 2020:

``` r
my_cal <- gfs_calendar(academicYear = 2020)
my_cal
```
