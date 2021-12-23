test_that("capitalizes non-special names", {
  type <- c("real", "virtual")
  x <- c(
    paste0("percent_", type),
    paste0(type, "_change")
  )

  expect_equal(format_summary_names(c("other", x))[[1]], "Other")
})

test_that("removes the prefix 'percent'", {
  type <- c("real", "virtual")
  x <- c(paste0("percent_", type), paste0(type, "_change"))

  detected <- any(grepl("percent", format_summary_names(x), ignore.case = TRUE))
  expect_false(detected)
})

test_that("removes the suffix 'change'", {
  type <- c("real", "virtual")
  x <- c(paste0("percent_", type), paste0(type, "_change"))

  detected <- any(grepl("change", format_summary_names(x), ignore.case = TRUE))
  expect_false(detected)
})
