test_that("outputs the expected snapshot", {
  skip_if_not_installed("tacAppPrivateData")

  path <- private_path("nuclear_coal.csv")
  data <- read_csv(path, show_col_types = FALSE)

  expect_snapshot(tweak(data))
})
