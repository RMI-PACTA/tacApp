# This script is very slow but for a good reason: To improve the experience of
# those who use the tacApp. This process helps expose not all the raw data but
# only that which leads to valid results. Without this the user would often get
# invalid results. Be patient. On my laptop this script completed in about 3h.
library(dplyr, warn.conflicts = FALSE)
library(devtools)
library(here)
load_all()

source(here("data-raw", "utils.R"))

file <- here("data-raw", "valid_rowids.txt")
todo <- pick_todo(tacAppPrivateData::full, file)

write_valid_rowids(todo, file)

valid_rowids <- as.integer(readLines(file))
use_data(valid_rowids, overwrite = TRUE)
