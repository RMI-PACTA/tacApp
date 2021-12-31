#' @examples
#' prep_raw(valid, valid[8, ])
#' @noRd
prep_raw <- function(data, selected = data[8, ]) {
  technology <- as.character(selected$technology)

  out <- data %>%
    filter(.data$technology == .env$technology) %>%
    filter(.data$target_company_id == selected$target_company_id)

  if (nrow(out) == 0) {
    out <- out %>%
      filter(.data$subsidiary_company_id == selected$subsidiary_company_id)
  }

  out %>%
    filter(.data$dual == 1) %>%
    prepare_data_waterfall(
      technology_filter = technology,
      portfolio_ids = unique(data$subsidiary_company_id),
      column_comp_id = "subsidiary_company_id",
      # FIXME: This seems brittle
      column_before = "comp_cap_2018q4",
      column_after = "comp_cap_2020q3",
      categories_order = categories_order()
    ) %>%
    tibble::add_column(technology = .env$technology, .before = 1)
}
