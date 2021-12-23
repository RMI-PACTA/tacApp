test_that("has the expected structure", {
  data <- prep_raw(full())
  out <- summarize_change(data)
  expect_snapshot(out)
})

test_that("outputs names with the word 'percent'", {
  data <- prep_raw(full())
  out <- summarize_change(data)
  expect_true(any(grepl("percent", names(out))))
})
