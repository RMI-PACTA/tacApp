test_that("outputs the same", {
  skip_if_not_installed("tacAppPrivateData")

  data <- full()
  out <- prep_raw(data, slice(data, 1))
  expect_snapshot(out)
})
