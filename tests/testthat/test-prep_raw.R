test_that("outputs the same", {
  skip_if_not_installed("tacAppPrivateData")

  data <- full()
  row <- fake_row()
  out <- prep_raw(data, row)

  expect_snapshot(out)
})

# TODO: Handle warning
# row <- slice(data, 1)
