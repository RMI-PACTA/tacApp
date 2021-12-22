company_types <- function() {
  c("target_company_id", "subsidiary_company_id")
}

label_find_id <- function() {
  "Explore"
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
  levels(full()$technology)
}

renewables <- function() {
  c(
    "biogas",
    "biomass",
    "geothermal",
    "solar_cpv",
    "solar_pv",
    "solar_thermal",
    "wind_offshore",
    "wind_onshore"
  )
}
