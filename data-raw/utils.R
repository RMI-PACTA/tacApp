library(progress)
library(fs)
library(rlang)

write_valid_rowids <- function(data, file) {
  warn_if_exists(file)

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

warn_if_exists <- function(file) {
  if (file_exists(file)) {
    warn(c(
      glue("The file {file} already exists and will be appended."),
      i = "Do you need to stop the process and remove it to start fresh?",
      i = glue("fs::file_delete('{file}')"),
      i = "Do you need to revert the file to it's latest commited sate?",
      i = "`git checkout data-raw/valid_rowids`"
    ))
  }
  invisible(file)
}

pick_todo <- function(data, file) {
  rowids <- integer(0)
  if (file_exists(file)) {
    rowids <- as.integer(readLines(file))
  }
  last <- 1L
  if (length(rowids) > 0L) {
    last <- tail(rowids, 1L)
  }

  filter(data, rowid > last)
}
