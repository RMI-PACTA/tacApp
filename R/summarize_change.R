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

summarize1change <- function(.x) {
  total_change <- category_value(.x, "after") - category_value(.x, "before")

  real_change <- .x %>%
    filter(.data$category %in% c("add", "remove", "ramp up", "ramp down")) %>%
    pull(.data$value) %>%
    sum(na.rm = TRUE)

  virtual_change <- .x %>%
    filter(.data$category %in% c("buy", "sell")) %>%
    pull(.data$value) %>%
    sum(na.rm = TRUE)

  real_percent <- 100 * real_change / total_change

  virtual_percent <- 100 * virtual_change / total_change

  tibble::tibble(
    total_change,
    real_change,
    real_percent,
    virtual_change,
    virtual_percent
  )
}

category_value <- function(data, category) {
  filter(data, .data$category == .env$category)$value
}
