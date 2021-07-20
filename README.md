
<!-- README.md is generated from README.Rmd. Please edit that file -->

# g4sr

<!-- badges: start -->
<!-- badges: end -->

`g4sr` is an API wrapper for Go4Schools. It allows you to manage your
school’s data. Authentication is required for all requests. See your
school’s administrator for an API key. It should look something like
this:

`thisISyourAPIkeyITlooksLIKEaLONGstringOFlettersANDnumbers`

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
# Install devtools if needed
#install.packages("devtools")

# Install g4sr using devtools
devtools::install_github("afsarchowdhury/g4sr")
```

A [CRAN](https://cran.r-project.org/) version is unavailable at this
time.

## Setup for beginners

If you have never used `R` before, or you only ever use it once or twice
a year, the following is your best option:

``` r
# Load the g4sr package
library(g4sr)

# Run setup
gfs_setup()
```

You will be prompted to enter your API key in the console. This is
needed before any of the functions can be used.

## Setup for more advanced users

If you are a more advanced user, you may wish to store your API key so
that you don’t have to re-enter it every time you start a new session.
Best practice is to set the API key as an environment variable for your
system and then call it in `R` using `Sys.getenv()`. If you set the
parameter in `.Renviron`, it is permanently available to your `R`
sessions. Be aware: if you are using version control, you do not want to
commit the `.Renviron` file in your local directory. Either edit your
global `.Renviron` file, or make sure that `.Renviron` is added to your
`.gitignore` file.

Open the `.Renviron` file and add the following line:

``` r
G4SR_KEY=thisISyourAPIkeyITlooksLIKEaLONGstringOFlettersANDnumbers
```

Restart your `R` session and test to make sure the key has been added
using the command:

``` r
Sys.getenv("G4SR_KEY")
```

You should see your API key printed in the console. If this works, you
can do the following:

``` r
library(g4sr)
gfs_setup(api_key = Sys.getenv("G4SR_KEY"))
```

## Example 1

To return details of the school and the available academic years:

``` r
# Load g4sr if you have not already
library(g4sr)

# Setup g4sr using your chosen method
gfs_setup()

# Return list of available academic years
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

## Example 2

To return the school calendar for the academic year 2020:

``` r
my_cal <- gfs_calendar(academicYear = 2020)
#> [1] "Status code: 200"
head(my_cal)
#>   timetable_id week                 date day_type_code
#> 1        10202    1 2019-09-03T00:00:00Z          OPEN
#> 2           NA   NA 2019-09-02T00:00:00Z      TRAINING
#> 3           NA   NA 2019-09-08T00:00:00Z        CLOSED
#> 4        10202    1 2019-09-04T00:00:00Z          OPEN
#> 5           NA   NA 2019-09-07T00:00:00Z        CLOSED
#> 6        10202    2 2019-09-12T00:00:00Z          OPEN
```

## License

`g4sr` is released on a [GPLv3
license](https://www.gnu.org/licenses/gpl-3.0.en.html).
