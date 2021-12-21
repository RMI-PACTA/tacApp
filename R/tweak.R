tweak <- function(data) {
  data %>%
    dplyr::relocate(.data$technology, company_types()) %>%
    lump_technology() %>%
    dplyr::mutate(
      technology = factor(.data$technology),
      target_company_id = as.integer(.data$target_company_id),
      subsidiary_company_id = as.integer(.data$subsidiary_company_id)
    )
}
