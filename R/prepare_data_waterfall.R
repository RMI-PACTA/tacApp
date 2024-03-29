prepare_data_waterfall <- function(data,
                                   technology_filter,
                                   portfolio_ids,
                                   column_comp_id,
                                   categories_order = NULL) {
  categories_order <- categories_order %||%
    c(
      "before", "add", "buy", "ramp_up", "remove", "sell", "ramp_down",
      "too_late", "untraceable", "unidentifiable", "after"
    )

  data_portfolio <- data %>%
    filter(.data$technology == .env$technology_filter) %>%
    filter(.data[[column_comp_id]] %in% portfolio_ids) %>%
    arrange(factor(.data$category, levels = categories_order)) %>%
    filter(.data$category != "continue") %>%
    mutate(id = seq_along(.data$value)) %>%
    mutate(
      type =
        factor(
          .data$type,
          levels = c("total", "real", "virtual", "unknown")
        )
    ) %>%
    select(c("sector", "technology", "production_unit", "category", "value", "id", "type")) %>%
    rename(unit = "production_unit")

  data_portfolio <- data_portfolio %>%
    arrange(factor(.data$category, levels = categories_order)) %>%
    mutate(
      value = if_else(.data$sector == "Power", .data$value / 10^3, .data$value),
      unit = if_else(.data$sector == "Power", "GW", .data$unit)
    )

  data_portfolio$end <- cumsum(data_portfolio$value)
  data_portfolio$end <- c(head(data_portfolio$end, -1), 0)

  data_portfolio$start <- c(0, head(data_portfolio$end, -1))
  data_portfolio <- data_portfolio[, c("sector", "technology", "unit", "id", "category", "type", "start", "end", "value")]

  data_portfolio
}
