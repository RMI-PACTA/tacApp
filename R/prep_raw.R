#' @examples
#' prep_raw(valid, valid[8, ])
#' @noRd
prep_raw <- function(data, selected = data[8, ]) {
  sector <- as.character(selected$sector)
  technology <- as.character(selected$technology)

  out <- data %>%
    filter(.data$sector == .env$sector) %>%
    filter(.data$technology == .env$technology) %>%
    filter(.data$company_id == selected$company_id)

  out %>%
    prepare_data_waterfall(
      technology_filter = technology,
      portfolio_ids = unique(data$company_id),
      column_comp_id = "company_id",
      categories_order = categories_order()
    )
}
