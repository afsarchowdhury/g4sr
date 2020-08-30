
<!-- README.md is generated from README.Rmd. Please edit that file -->

# g4sr

<!-- badges: start -->

<!-- badges: end -->

`g4sr` is an API wrapper for Go4Schools. It allows you to manage school
data. Authentication is required for all requests. See your school’s
administrator for an API key.

## Installation

You can install the development version of g4sr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("afsarchowdhury/g4sr")
```

## Setup

Run `gfs_setup()` and enter your API key. This is needed before any of
the functions can be used.

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
