# This script is very slow but for a good reason: To improve the experience of
# those use use the tacApp. This process helps expose not all the raw data but
# only that which leads to valid results. Without this the user would often get
# invalid results. Be patient. It took about 2h to complete on my laptop.
library(dplyr, warn.conflicts = FALSE)
library(progress)
library(devtools)
load_all()

find_valid_rowids <- function(data) {
  valid <- integer(length(data$rowid))

  pb <- progress_bar$new(total = length(data$rowid))
  for (i in seq_along(data$rowid)) {
    pb$tick()

    result <- suppressWarnings(prep_raw(data, slice(data, i)))
    if (any(result$category %in% useful_categories())) {
      valid[i] <- data$rowid[i]
    }
  }

  valid[valid > 0]
}

valid_rowids <- find_valid_rowids(full())

use_data(valid_rowids, overwrite = TRUE)
