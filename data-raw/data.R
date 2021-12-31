valid_rowids <- "result" %>%
  data_raw_path() %>%
  dir_ls() %>%
  path_file() %>%
  path_ext_remove() %>%
  as.integer() %>%
  sort()

valid <- valid %>%
  filter(rowid %in% valid_rowids)

unique_rowids <- valid %>%
  select(rowid, target_company, subsidiary_company, technology) %>%
  distinct(target_company, subsidiary_company, technology, .keep_all = TRUE) %>%
  pull(rowid)

useful <- filter(valid, rowid %in% unique_rowids)
use_data(
  valid,
  valid_rowids,
  unique_rowids,
  useful,
  overwrite = TRUE
)
