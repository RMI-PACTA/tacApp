library(readr)
library(purrr)
library(dplyr)
library(here)
library(glue)
library(vroom)
library(fs)
devtools::load_all()

data <- valid[1:30, ]

c("result") %>%
  data_raw_path() %>%
  map(dir_create)

for (i in data$rowid) {
  result <- prep_raw(data, slice(data, i))
  if (any(result$category %in% useful_categories())) {
    vroom_write(result, data_raw_path("result", glue("{i}.csv")))
  }
}
