# This script is very slow but for a good reason: To improve the experience of
# those who use the tacApp. This process helps expose not all the raw data but
# only that which leads to valid results. Without this the user would often get
# invalid results. Be patient. On my laptop this script completed in about 3h.
library(dplyr, warn.conflicts = FALSE)
library(progress)
library(devtools)
library(here)
library(fs)
load_all()

write_valid_rowids <- function(data, file) {
  abort_if_exists(file)

  rowids <- data$rowid
  valid <- integer(length(rowids))

  pb <- progress_bar$new(total = length(rowids))
  for (i in seq_along(rowids)) {
    pb$tick()

    result <- suppressWarnings(prep_raw(data, slice(data, i)))
    if (any(result$category %in% useful_categories())) {
      valid[i] <- rowids[i]
      write(valid[i], file = file, append = TRUE)
    }
  }

  invisible(data)
}

abort_if_exists <- function(file) {
  if (fs::file_exists(file)) {
    abort(c(
      glue("The file {file} must not exist."),
      i = "Do you need to remove it?",
      i = glue("fs::file_delete('{file}')")
    ))
  }
  invisible(file)
}

file <- here("data-raw", "valid_rowids.txt")
write_valid_rowids(tacAppPrivateData::full, file)
valid_rowids <- as.integer(readLines(file))
use_data(valid_rowids, overwrite = TRUE)
