test_that("getters have not changed", {
  getters <- list(
    renewables(),
    categories_order(),
    technologies()
  )
  expect_snapshot(getters)
})
