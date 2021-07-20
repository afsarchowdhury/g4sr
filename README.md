
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
who happens to use [R](https://www.r-project.org/).

There are some API calls that are yet to be included. The only reason
for thier absence is that I have not needed to use them yet.

## Installation

Install the development version from [GitHub](https://github.com/) by
typing the following:

``` r
# install.packages("devtools")
devtools::install_github("afsarchowdhury/g4sr")
```

A [CRAN](https://cran.r-project.org/) version is unavailable at this
time.

## Setup

Run `gfs_setup()` and enter your API key in the console. This is needed
before any of the functions can be used.

## Example

To return details of the school and the available academic years:

``` r
library(g4sr)
gfs_school()
```

You should see a printout in the console, looking something like this:

``` r
[1] "Status code: 200"
$code
[1] "SCHOOLCODE"

$name
[1] "School Name"

$academic_years
 [1] 2021 2020 2019 2018 2017 2016 2015 2014 2013 2012

$current_academic_year
[1] 2021
```

Anything other than a status code 200 means there was an error along the
way. See
<https://www.go4schools.com/Documentation/V1/APIDocumentation.html#errors>
to identify the error.

To return the school calendar for the academic year 2020:

``` r
my_cal <- gfs_calendar(academicYear = 2020)
head(my_cal)

  timetable_id week                 date day_type_code
1        10202    1 2019-09-03T00:00:00Z          OPEN
2           NA   NA 2019-09-02T00:00:00Z      TRAINING
3           NA   NA 2019-09-08T00:00:00Z        CLOSED
4        10202    1 2019-09-04T00:00:00Z          OPEN
5           NA   NA 2019-09-07T00:00:00Z        CLOSED
6        10202    2 2019-09-12T00:00:00Z          OPEN
```

## License

`g4sr` is released on a [GPLv3
license](https://www.gnu.org/licenses/gpl-3.0.en.html).
