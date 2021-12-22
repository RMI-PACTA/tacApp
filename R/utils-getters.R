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

technologies <- function() {
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
