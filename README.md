
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tacApp

<!-- badges: start -->
<!-- badges: end -->

The goal of tacApp is to help you analyze changes in the power sector
between two time periods. The public source code lives in an [R
package](%5Bhere%5D(https://github.com/2DegreesInvesting/tacApp)), and
the public application is available
[online](https://twodii.shinyapps.io/tacApp/).

## Usage

-   Go to <https://twodii.shinyapps.io/tacApp/>.
-   Select a parent company and a technology.
-   Click “Apply”.

## Output

-   A summary of the *real* and *virtual* change.
-   A breakdown of changes as a plot.
-   A breakdown of changes as a downloadable table.

A *real* change is an increase or decrease in the production capacity. A
*virtual* change is a change not in the production capacity but in the
ownership of the asset.

## Contributing

### Code organization

The app is organized in the same was as an R package. Learn more at
<https://mastering-shiny.org/scaling-packaging.html>.

### Data

The data is private and not hosted here. The ultimate source is [Asset
Resolution](https://asset-resolution.com/). The raw data is first
processed in the data-raw/ directory in the private repository at
<https://github.com/2DegreesInvesting/tacAppPrivateData>, then processed
further in the data-raw/ directory here. The file names and comments
should guide you.

``` r
file_names <- list.files("data-raw")
file_names
#> [1] "01_valid_rowids.R" "02_data.R"         "utils.R"          
#> [4] "valid_rowids.txt"

comments <- head(readLines("data-raw/01_valid_rowids.R"))
writeLines(comments)
#> # This script is very slow but for a good reason: To improve the experience of
#> # those who use the tacApp. This process helps expose not all the raw data but
#> # only that which leads to valid results. Without this the user would often get
#> # invalid results. Be patient. On my laptop this script completed in about 3h.
#> 
#> library(dplyr, warn.conflicts = FALSE)
```

### Deployment

> To deploy your application, you can either deploy the app from the IDE
> itself by clicking on the Publish button in the top right corner of
> the interface … or you can use the deployApp command from the
> rsconnect package.

``` r
library(rsconnect)
deployApp()
```

<https://docs.rstudio.com/shinyapps.io/getting-started.html#deploying-your-first-application>.

Learn more at
<https://mastering-shiny.org/scaling-packaging.html#deploying-your-app-package>.
