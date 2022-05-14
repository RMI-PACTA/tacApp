library(dplyr, warn.conflicts = FALSE)
library(tacApp)

# WARNING: Git ignores data/. You may recover it from the published app's bundle

if (!exists("valid_rowids", "package:tacApp")) {
  rlang::abort(c(
    "`valid_rowids` must exist.",
    i = "Do you need to run `source(here::here('data-raw/valid_rowids.R'))`?"
  ))
}

valid_rowids <- tacApp::valid_rowids

valid <-   tacAppPrivateData::full %>%
  filter(rowid %in% valid_rowids) %>%
  arrange(target_company_name, technology)

unique_rowids <- valid %>%
  select(rowid, target_company_name, technology) %>%
  distinct(target_company_name, technology, .keep_all = TRUE) %>%
  pull(rowid)

useful <- filter(valid, rowid %in% unique_rowids)

use_data(
  valid,
  valid_rowids,
  unique_rowids,
  useful,
  overwrite = TRUE
)