full <- function() {
  tacAppPrivateData::full %>%
    mutate(target_company = if_else(
      is.na(.data$target_company_name),
      as.character(.data$target_company_id),
      as.character(.data$target_company_name)
    )) %>%
    mutate(subsidiary_company = if_else(
      is.na(.data$subsidiary_company_name),
      as.character(.data$subsidiary_company_id),
      as.character(.data$subsidiary_company_name)
    ))
}
