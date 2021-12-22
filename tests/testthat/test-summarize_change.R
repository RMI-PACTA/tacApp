test_that("has the expected structure", {
  data <- prep_raw(full(), technology = "renewables", company_id = 919)
  out <- summarize_change(data)
  expect_snapshot(out)
})
