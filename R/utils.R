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

data_raw_path <- function(...) {
  here("data-raw", ...)
}

has_useful_categories <- function(data) {
  any(unique(data$category) %in% useful_categories())
}

useful_categories <- function() {
  c(real_categories(), virtual_categories())
}

real_categories <- function() {
  c("add", "remove", "ramp_up", "ramp_down")
}

virtual_categories <- function() {
  c("buy", "sell")
}

categories_order <- function() {
  c(
    "before",
    "add",
    "buy",
    "ramp_up",
    "remove",
    "sell",
    "ramp_down",
    "untraceable",
    "unidentifiable",
    "too_late",
    "after"
  )
}
