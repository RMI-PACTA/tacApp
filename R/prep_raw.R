#' @examples
#' prep_raw(full())
#' @noRd
prep_raw <- function(data, row = fake_row()) {
  prep1tech <- function(data, technology) {
    data %>%
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
      fill_missing_categories()
  }

  technology <- as.character(row$technology)
  out <- filter(data, .data$technology == .env$technology)
  out <- filter(out, .data$target_company_id == row$target_company_id)
  if (nrow(out) == 0) {
    out <-
      filter(.data$subsidiary_company_id == row$subsidiary_company_id)
  }

  out <- lapply(technology, function(.x) {
      prep1tech(out, technology = .x)
    })

  names(out) <- technology
  out <- enframe(out, name = "technology")
  out <- unnest(out, .data$value)
  out
}

fill_missing_categories <- function(data) {
  categories <- tibble(category = c(real_categories(), virtual_categories()))
  data %>%
    # Fill missing categories
    dplyr::full_join(categories, by = "category") %>%
    mutate(
      type = case_when(
        category %in% real_categories()    ~ "real",
        category %in% virtual_categories() ~ "virtual",
        TRUE                               ~ type
      )
    ) %>%
    mutate(across(c(start, end, value), tidyr::replace_na, 0)) %>%
    # FIXME: Do we need `id`?
    select(-id) %>%
    tibble::rowid_to_column(var = "id")
}
