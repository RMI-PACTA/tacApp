test_that("outputs the same", {
  is_set <- function(x) !Sys.getenv(x) == ""
  skip_if(is_set("R_CMD"))

  path <- private_path("nuclear_coal.csv")
  data <- readr::read_csv(path, show_col_types = FALSE)

  out <- prep_techs(data, company_id = 6736, technology = "coal")
  expect_snapshot(out)
})
