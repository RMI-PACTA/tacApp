# Avoid message: Loading required package: shiny
library(shiny)

test_that("the first row has useful categories", {
  first_row <- slice(useful, 1)
  name <- first_row$target_company_name
  tech <- as.character(first_row$technology)
  apply <- TRUE

  testServer(server, {
    session$setInputs(name = name, tech = tech, apply = apply)
    expect_true(has_useful_categories(result()))
  })
})

test_that("the first row has useful categories", {
  first_row <- slice(useful, 1)
  name <- first_row$target_company_name
  tech <- as.character(first_row$technology)
  apply <- TRUE

  testServer(server, {
    session$setInputs(name = name, tech = tech, apply = apply)
    expect_snapshot(result())
  })
})
