test_that("outputs the expected snapshot", {
  data <- prep_raw(valid)
  out <- summarize_change(data)
  expect_snapshot(out)
})

test_that("percent values are always positive", {
  data <- prep_raw(valid)
  out <- summarize_change(data)
  percents <- unlist(select(out, matches("percent")))
  expect_true(all(percents >= 0L))
})

test_that("total change is the sum of real and virtual categories", {
  data <- prep_raw(valid)
  out <- summarize_change(data)
  expect_equal(
    pull(out, total_change), pull(out, real_change) + pull(out, virtual_change)
  )
})

test_that("outputs names with the word 'percent'", {
  data <- prep_raw(valid)
  out <- summarize_change(data)
  expect_true(any(grepl("percent", names(out))))
})

test_that("helper capitalizes non-special names", {
  type <- c("real", "virtual")
  x <- c(
    paste0("percent_", type),
    paste0(type, "_change")
  )

  expect_equal(format_summary_names(c("other", x))[[1]], "Other")
})

test_that("helper removes the prefix 'percent'", {
  type <- c("real", "virtual")
  x <- c(paste0("percent_", type), paste0(type, "_change"))

  detected <- any(grepl("percent", format_summary_names(x), ignore.case = TRUE))
  expect_false(detected)
})

test_that("helper removes the suffix 'change'", {
  type <- c("real", "virtual")
  x <- c(paste0("percent_", type), paste0(type, "_change"))

  detected <- any(grepl("change", format_summary_names(x), ignore.case = TRUE))
  expect_false(detected)
})

test_that("helper rounds percents", {
  data <- prep_raw(valid)
  out <- summarize_change(data)
  out <- round_percent_columns(out)
  percents <- unlist(select(out, matches("percent")))
  expect_equal(percents, round(percents))
})
