library(dplyr, warn.conflicts = FALSE)
devtools::load_all()

# WARNING: Git ignores data/

if (!exists("valid_rowids", "package:tacApp")) {
  rlang::abort(c(
    "`valid_rowids` must exist.",
    i = "Do you need to run `source(here::here('data-raw/valid_rowids.R'))`?"
  ))
}

valid <- tacAppPrivateData::full %>%
  filter(rowid %in% valid_rowids) %>%
  arrange(company_name, technology)

unique_rowids <- valid %>%
  select(rowid, company_name, technology) %>%
  distinct(company_name, technology, .keep_all = TRUE) %>%
  pull(rowid)

useful <- filter(valid, rowid %in% unique_rowids)

use_data(
  valid,
  valid_rowids,
  unique_rowids,
  useful,
  overwrite = TRUE
)
