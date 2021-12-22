test_that("outputs the same", {
  skip_if_not_installed("tacAppPrivateData")

  data <- tweak(full())
  out <- prep_raw(data, company_id = 6736, technology = "coal")
  expect_snapshot(out)
})

test_that("with invalid id errors gracefully", {
  skip_if_not_installed("tacAppPrivateData")

  data <- tweak(full())
  expect_snapshot_error(prep_raw(data, company_id = 1, technology = "coal"))
})
