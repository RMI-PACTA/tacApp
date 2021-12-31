test_that("outputs the same", {
  out <- prep_raw(valid)
  expect_snapshot(out)
})
