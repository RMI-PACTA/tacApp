test_that("has the expected structure", {
  data <- prep_raw(full())
  out <- summarize_change(data)
  expect_snapshot(out)
})
