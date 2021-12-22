private_path <- function(...) {
  system.file("extdata", "private", ..., package = "tacAppPrivateData")
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

#' @examples
#' x <- c("percent_real", "percent_blah")
#' rm_prefix(x, "percent_")
#' @noRd
rm_prefix <- function(x, prefix) {
  gsub("percent_", "", x)
}

#' @examples
#' add_unit(c("foo", "bar"), "%")
#' add_unit(c("foo", "bar"), "GW")
#' @noRd
add_unit <- function(x, unit) {
  sprintf("%s (%s)", x, unit)
}

select_tech_and_id <- function(data) {
  select(data, .data$technology, matches("_company_"))
}

rename_summary <- function(data) {
  nms <- names(data)
  nms <- gsub("_", " ", nms)
  nms <- tools::toTitleCase(nms)
  nms <- case_when(
    grepl("Percent", nms) ~ add_unit(nms, "%"),
    TRUE ~ add_unit(nms, "GW")
  )

  names(data) <- nms
  data
}
