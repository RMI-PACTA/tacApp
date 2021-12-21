test_that("outputs the same", {
  skip_if_not_installed("tacAppPrivateData")

  path <- private_path("nuclear_coal.csv")
  data <- readr::read_csv(path, show_col_types = FALSE)

  out <- prep_techs(data, company_id = 6736, technology = "coal")
  expect_snapshot(out)
})

test_that("with invalid id errors gracefully", {
  skip_if_not_installed("tacAppPrivateData")

  path <- private_path("nuclear_coal.csv")
  data <- readr::read_csv(path, show_col_types = FALSE)

  expect_snapshot_error(prep_techs(data, company_id = 1, technology = "coal"))
})
