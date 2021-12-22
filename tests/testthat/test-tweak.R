test_that("outputs the expected snapshot", {
  skip_if_not_installed("tacAppPrivateData")
  expect_snapshot(tweak(full()))
})
