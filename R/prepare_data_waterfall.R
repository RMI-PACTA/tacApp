prepare_data_waterfall <- function(data,
                                   technology_filter,
                                   portfolio_ids,
                                   column_comp_id,
                                   column_before,
                                   column_after,
                                   column_weights = NULL,
                                   categories_order = NULL) {
  # categories_order <- categories_order %||%
  #   c(
  #     "before", "add", "buy", "ramp up", "remove", "sell", "ramp down",
  #     "untraceable", "unidentified", "after"
  #   )
  categories_order <- categories_order %||%
    c(
      "before", "add", "buy", "ramp_up", "remove", "sell", "ramp_down",
      "too_late", "untraceable", "unidentifiable", "after"
    )

  if (!is.null(column_weights)) {
    data[column_before] <- data[column_before] * data[column_weights]
    data[column_after] <- data[column_after] * data[column_weights]
  }

  data_portfolio <- data %>%
    filter(.data$technology == .env$technology_filter) %>%
    filter(.data[[column_comp_id]] %in% portfolio_ids) %>%
    arrange(factor(.data$category, levels = categories_order)) %>%
    filter(.data$category != "continue") %>%
    mutate(id = seq_along(.data$value) + 1) %>%
    mutate(
      type =
        factor(
          .data$type,
          levels = c("total", "real", "virtual", "unknown")
        )
    ) %>%
    select(.data$category, .data$value, .data$id, .data$type)

  data_portfolio <- data_portfolio %>%
    arrange(factor(.data$category, levels = categories_order)) %>%
    mutate(value = .data$value / 10^3)

  data_portfolio$end <- cumsum(data_portfolio$value)
  data_portfolio$end <- c(head(data_portfolio$end, -1), 0)

  data_portfolio$start <- c(0, head(data_portfolio$end, -1))
  data_portfolio <- data_portfolio[, c(3, 1, 4, 6, 5, 2)]

  data_portfolio
}
