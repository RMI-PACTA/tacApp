prepare_data_waterfall <- function(data,
                                   technology_filter,
                                   portfolio_ids,
                                   column_comp_id,
                                   column_before,
                                   column_after,
                                   column_weights = NULL,
                                   categories_order = NULL) {

  categories_order <- categories_order %||%
    c("before","add", "buy", "ramp up", "remove", "sell", "ramp down",
      "untraceable","unidentified","after")

  if (!is.null(column_weights)) {
    data[column_before] = data[column_before] * data[column_weights]
    data[column_after] = data[column_after] * data[column_weights]
  }

  region_filter_2 <- "Latin America and the Caribbean"
  company_type_filter <- 1

  data_portfolio <- data %>%
    filter(.data$dual == 1) %>% # for now we only look at not dual plants as we don't know how to deal with dual - Angelika
#    filter(.data$CA100 == company_type_filter) %>%
#    filter(.data$SBTI == company_type_filter) %>%
#    filter(.data$comp_region == region_filter_2) %>%
#     filter(.data$comp_sub_region == region_filter_2) %>%
#    filter(.data$company_status == company_type_filter) %>%
#    filter(.data$comp_size == company_type_filter) %>%
    filter(.data$technology == .env$technology_filter) %>%
    filter(.data[[column_comp_id]] %in% portfolio_ids) %>%
    mutate(val_change = !! sym(column_after) - !! sym(column_before)) %>%
    mutate(category =
             if_else(.data$category %in% c("untraceable","unidentified"),
                     "unidentified",
                     .data$category)) %>%
    group_by(.data$category) %>%
    summarise(
      value =
        sum(.data$val_change, na.rm = TRUE)
      ) %>%
    arrange(factor(.data$category, levels = categories_order)) %>%
    filter(.data$category != "continue") %>%
    mutate(id = seq_along(.data$value) + 1) %>%
    mutate(type = case_when(
      .data$category %in% c("add", "remove", "ramp up", "ramp down") ~ "real",
      .data$category %in% c("buy", "sell") ~ "virtual",
      .data$category %in% c("untraceable", "unidentified", "too late") ~ "unknown",
      TRUE ~ "unknown"
    )) %>%
    mutate(type =
             factor(
               .data$type,
                levels = c("real", "virtual", "unknown")
               )) %>%
    select(.data$category, .data$value, .data$id, .data$type)

  total_before <- data %>%
    filter(.data$dual == 1) %>% # for now we only look at not dual plants as we don't know how to deal with dual - Angelika
#    filter(.data$CA100 == company_type_filter) %>%
#    filter(.data$SBTI == company_type_filter) %>%
#    filter(.data$comp_region == region_filter_2) %>%
#    filter(.data$comp_sub_region == region_filter_2) %>%
#    filter(.data$company_status == company_type_filter) %>%
#    filter(.data$comp_size == company_type_filter) %>%
    filter(.data$technology == .env$technology_filter) %>%
    filter(.data[[column_comp_id]] %in% portfolio_ids) %>%
    summarise(
      category = "before",
      value = sum(!! sym(column_before), na.rm = TRUE),
      id = min(data_portfolio$id) - 1,
      type = "total"
    )

  total_after <- data %>%
    filter(.data$dual == 1) %>% # for now we only look at not dual plants as we don't know how to deal with dual - Angelika
#    filter(.data$CA100 == company_type_filter) %>%
#    filter(.data$SBTI == company_type_filter) %>%
#    filter(.data$comp_region == region_filter_2) %>%
#    filter(.data$comp_sub_region == region_filter_2) %>%
#    filter(.data$company_status == company_type_filter) %>%
#    filter(.data$comp_size == company_type_filter) %>%
    filter(.data$technology == .env$technology_filter) %>%
    filter(.data[[column_comp_id]] %in% portfolio_ids) %>%
    summarise(
      category = "after",
      value = sum(!! sym(column_after), na.rm = TRUE),
      id = max(data_portfolio$id) + 1,
      type = "total"
    )

  data_portfolio <- bind_rows(data_portfolio, total_before, total_after) %>%
    arrange(factor(.data$category, levels = categories_order)) %>%
    mutate(value = .data$value / 10^3)

  data_portfolio$end <- cumsum(data_portfolio$value)
  data_portfolio$end <- c(head(data_portfolio$end, -1), 0)

  data_portfolio$start <- c(0, head(data_portfolio$end, -1))
  data_portfolio <- data_portfolio[ , c(3, 1, 4, 6, 5, 2)]

  data_portfolio
}
