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
      )
  }

  technology <- as.character(row$technology)
  out <- filter(data, .data$technology == .env$technology)
  out <-
    filter(out, .data$target_company_id == row$target_company_id)
  if (nrow(out) == 0) {
    out <-
      filter(.data$subsidiary_company_id == row$subsidiary_company_id)
  }

  out <-
    lapply(technology, function(.x) {
      prep1tech(out, technology = .x)
    })

  names(out) <- technology
  out <- enframe(out, name = "technology")
  out <- unnest(out, .data$value)
  out
}

abort_if_has_no_useful_category <- function(data) {
  useful_categories <- c(real_categories(), virtual_categories())
  has_useful_category <- any(unique(data$category) %in% useful_categories)
  if (!has_useful_category) {
    abort(c(
      "`data` must have at least one real or virtual category.",
      x = glue("Given categories: {toString(unique(data$category))}."),
      glue("Real categories: {toString(real_categories())}"),
      glue("Virtual categories: {toString(virtual_categories())}"),
      i = "Do you need to choose a different technology?"
    ),
    class = "has_no_useful_category"
    )
  }

  invisible(data)
}
