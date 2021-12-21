# path <- private_path("tac-tracking-asset-level-changes.csv")
# data <- read_csv(path, show_col_types = FALSE)
# out <- prep_raw(data, company_id = 6736)
# summarize_change(out)
summarize_change <- function(data) {
  split(data, data$technology) %>%
    lapply(summarize1change) %>%
    enframe(name = "technology") %>%
    tidyr::unnest(.data$value)
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

  percent_real <- 100 * real_change / total_change

  percent_virtual <- 100 * virtual_change / total_change

  tibble::tibble(
    total_change, real_change, virtual_change, percent_real, percent_virtual
  )
}

category_value <- function(data, category) {
  filter(data, .data$category == .env$category)$value
}
