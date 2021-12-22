test_that("getters have not changed", {
  getters <- list(
    company_types(),
    label_find_id(),
    renewables(),
    categories_order(),
    technologies()
  )
  expect_snapshot(getters)
})
