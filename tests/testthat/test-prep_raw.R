test_that("outputs the same", {
  skip_if_not_installed("tacAppPrivateData")

  data <- full()
  row <- fake_row()
  out <- prep_raw(data, row)

  expect_snapshot(out)
})

test_that("with missing techology data errors gracefully", {
  data <- full()
  row <- data[1, ]
  suppressWarnings(
    expect_snapshot_error(prep_raw(data, row), class = "has_no_useful_category")
  )
})
