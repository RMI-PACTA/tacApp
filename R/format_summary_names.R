#' @examples
#' x <- c("real", "virtual")
#' nms <- c(
#'   "total_change",
#'   paste0("percent_", x),
#'   paste0(x, "_change")
#' )
#'
#' nms
#' format_summary_names(nms)
#' @noRd
format_summary_names <- function(nms) {
  nms <- gsub("_", " ", nms)
  nms <- tools::toTitleCase(nms)
  # styler: off
  nms <- case_when(
    grepl("Percent", nms) ~ add_unit(nms, "%"),
    grepl("Change", nms)  ~ add_unit(nms, "GW"),
    TRUE                  ~ nms
  )
  # styler: on
  nms <- gsub("Change ", "", nms)
  nms <- gsub("Percent ", "", nms)
  nms
}

#' @examples
#' x <- c("foo", "bar")
#' add_unit(x, "%")
#' add_unit(x, "GW")
#' @noRd
add_unit <- function(x, unit) {
  sprintf("%s (%s)", x, unit)
}
