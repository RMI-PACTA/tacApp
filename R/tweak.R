tweak <- function(data) {
  data %>%
    relocate(.data$technology, company_types()) %>%
    lump_technology() %>%
    mutate(
      technology = factor(.data$technology),
      target_company_id = as.integer(.data$target_company_id),
      subsidiary_company_id = as.integer(.data$subsidiary_company_id)
    )
}
