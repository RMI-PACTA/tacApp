#' @examples
#' data <- prep_raw(valid, valid[8, ])
#' summarize_change(data)
#' @noRd
summarize_change <- function(data) {
  real_change <- sum_categories(data, real_categories())
  virtual_change <- sum_categories(data, virtual_categories())
  total_change <- sum_categories(data, useful_categories())
  real_percent <- abs(100 * real_change / total_change)
  virtual_percent <- abs(100 * virtual_change / total_change)

  tibble::tibble(
    total_change, real_change, real_percent, virtual_change, virtual_percent
  )
}

sum_categories <- function(data, categories) {
  data %>%
    filter(.data$category %in% categories) %>%
    pull(.data$value) %>%
    sum(na.rm = TRUE)
}

category_value <- function(data, category) {
  filter(data, .data$category == .env$category)$value
}

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
  # TODO: pass sector and technology to provide appropriate units
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

round_percent_columns <- function(data) {
  mutate(data, across(matches("percent"), ~ as.integer(round(.x))))
}
