extdata_path <- function(..., package = "tacAppPrivateData") {
  system.file("extdata", ..., package = package)
}

#' Match resolution of RStudio's viewer panel
#'
#' "We recommend always setting res = 96 as that will make your Shiny plots
#' match what you see in RStudio as closely as possible." --
#' https://mastering-shiny.org/basic-ui.html#plots
#'
#' @examples
#' match_rstudio()
#' @noRd
match_rstudio <- function() {
  96
}

select_output_columns <- function(data) {
  select(
    data,
    .data$technology,
    .data$target_company,
    .data$subsidiary_company
  )
}

fake_row <- function() {
  tibble(
    target_company_id = 6759,
    subsidiary_company_id = 231401,
    target_company_name = "Iberdrola SA",
    subsidiary_company_name = "Anselmo Leon SA",
    technology = as.factor("oil")
  )
}
