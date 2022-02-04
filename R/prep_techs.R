#' Wrap all code
#'
#' @param data A dataframe.
#' @param tech String. A technology.
#' @param company_type String. A company type.
#' @param company_id Number. A company id.
#'
#' @return A list with `data` and `plot` elements.
#'
#' @examples
#' \donttest{
#' data <- readr:read_csv("private/tac-tracking-asset-level-changes.csv")
#' prepare(data)
#' }
#' @noRd
prep_techs <- function(data,
                       technology,
                       company_id,
                       company_type = company_types()) {
  company_type <- match.arg(company_type)
  stopifnot(is.numeric(company_id))

  data$technology <- tolower(data$technology)
  data <- data[data$technology == technology, , drop = FALSE]
  abort_if_company_id_is_invalid(data, company_type, company_id)

  out <- lapply(technology, \(.x) prep1tech(
    data,
    company_id = company_id,
    technology = .x,
    company_type = company_type
  ))

  names(out) <- technology
  out <- tibble::enframe(out, name = "technology")
  out <- tidyr::unnest(out, .data$value)
  out
}

abort_if_company_id_is_invalid <- function(data, company_type, company_id) {
  valid_id <- sort(unique(data[[company_type]]))
  is_valid <- company_id %in% valid_id

  if (!is_valid) {
    stop(
      sprintf(
        "`%s = %s` is invalid. Do you need to go back to the tab '%s'?",
        company_type,
        company_id,
        label_find_id()
      ),
      call. = FALSE
    )
  }

  invisible(data)
}

prep1tech <- function(data,
                      company_id,
                      technology,
                      company_type) {
  data <- data %>% mutate(technology = tolower(technology))

  picked <- data %>%
    lump_technology() %>%
    filter(.data[[company_type]] == company_id) %>%
    filter(.data$dual == 1)

  out <- prepare_data_waterfall(
    picked,
    technology_filter = technology,
    portfolio_ids = unique(data$subsidiary_company_id),
    column_comp_id = "subsidiary_company_id",
    column_before = "comp_cap_2018q4",
    column_after = "comp_cap_2020q3",
    categories_order = categories_order()
  )

  out
}

lump_technology <- function(data) {
  data %>%
    mutate(technology = tolower(.data$technology)) %>%
    mutate(technology = case_when(
      .data$technology %in% renewables() ~ "renewables",
      TRUE ~ .data$technology
    ))
}

renewables <- function() {
  c(
    "solar pv",
    "solar thermal",
    "solar cpv",
    "wind onshore",
    "wind offshore",
    "biogas",
    "biomass",
    "geothermal"
  )
}

categories_order <- function() {
  c(
    "before",
    "add",
    "buy",
    "ramp up",
    "remove",
    "sell",
    "ramp down",
    "untraceable",
    "unidentified",
    "too late",
    "after"
  )
}

techs <- function() {
  c("coal", "hydro", "gas", "renewables", "oil", "nuclear")
}
