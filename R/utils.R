private_path <- function(...) {
  system.file("extdata", "private", ..., package = "plots.tac.clean")
}

#' Match resolution of RStudio's viewer panel
#'
#' "We recommend always setting res = 96 as that will make your Shiny plots
#' match what you see in RStudio as closely as possible." --
#' https://mastering-shiny.org/basic-ui.html#plots
#'
#' @examples
#' match_rs()
#' @noRd
match_rs <- function() {
  96
}
