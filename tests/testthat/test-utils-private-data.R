test_that("the structure of private data remains the same", {
  expect_snapshot(class(full()))
  expect_snapshot(names(full()))
  expect_snapshot(dim(full()))
})
