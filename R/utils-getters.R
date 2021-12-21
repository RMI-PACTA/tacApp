company_types <- function() {
  c("target_company_id", "subsidiary_company_id")
}

label_find_id <- function() {
  "Explore companies"
}

ext <-function() {
  c(".csv", ".zip")
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
  c(
    "coal",
    "hydro",
    "gas",
    "renewables",
    "oil",
    "nuclear"
  )
}
