#' @examples
#' prep_raw(valid, valid[8, ])
#' @noRd
prep_raw <- function(data, selected = data[8, ]) {
  technology <- as.character(selected$technology)

  out <- data %>%
    filter(.data$technology == .env$technology) %>%
    filter(.data$company_id == selected$company_id)

  out %>%
    filter(.data$dual == 1) %>%
    prepare_data_waterfall(
      technology_filter = technology,
      portfolio_ids = unique(data$company_id),
      column_comp_id = "company_id",
      column_before = column_before(),
      column_after = column_after(),
      categories_order = categories_order()
    ) %>%
    tibble::add_column(technology = .env$technology, .before = 1)
}

column_before <- function() {
  "comp_cap_2018_actual"
}

column_after <- function() {
  "comp_cap_2020_actual"
}
