library(shiny)

test_that("the first selectable row has useful categories", {
  testServer(server, {
    session$setInputs(row_selector_rows_selected = 1)
    expect_true(has_useful_categories(result()))
  })
})

test_that("the first selectable row produces the expected result", {
  testServer(server, {
    session$setInputs(row_selector_rows_selected = 1)
    expect_snapshot(result())
  })
})

test_that("shows the expected plot", {
  testServer(server, {
    session$setInputs(row_selector_rows_selected = 1)
    vdiffr::expect_doppelganger("reactive waterfall plot", plot())
  })
})
