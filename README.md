---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



## Power company assessment

<!-- badges: start -->
<!-- badges: end -->


### Goal

The tacApp application helps you analyze changes in the power sector
between two time periods.

### Inputs and outputs

* You input a dataset, and select a technology and company.

* The application outputs a summary of the _real_ and _virtual_ change, and
shows a breakdown of changes as a plot and as a downloadable table.

A _real_ change is an increase or decrease in the production capacity. A
_virtual_ change is a change not in the production capacity but in the ownership
of the asset.

## Usage

Browse to <https://twodii.shinyapps.io/tacApp/> and follow the prompts.

## Devlelopment

1. Clone this repo.

```bash
git clone https://github.com/2DegreesInvesting/tacApp
cd tacApp
```

2. Load the code.

```r
devtools::load_all()
```

3. Run the app.

```r
run_app()
```
