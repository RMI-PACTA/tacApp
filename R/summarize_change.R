#' @examples
#' data <- full()
#' out <- prep_raw(data, company_id = 919, technology = "renewables")
#' summarize_change(out)
#' @noRd
summarize_change <- function(data) {
  split(data, data$technology) %>%
    lapply(summarize1change) %>%
    enframe(name = "technology") %>%
    unnest(.data$value) %>%
    select(-.data$technology)
}

summarize1change <- function(data) {
  real_categories <- real_categories()
  real_change <- sum_categories(data, real_categories)
  virtual_categories <- virtual_categories()
  virtual_change <- sum_categories(data, virtual_categories)
  # FIXME: Missing categories filled with 0 result in 0/0 = NaN. What should we do?
  total_change <- sum_categories(data, c(real_categories, virtual_categories))
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

real_categories <- function() {
    c("add", "remove", "ramp up", "ramp down")
}

virtual_categories <- function() {
    c("buy", "sell")
}
