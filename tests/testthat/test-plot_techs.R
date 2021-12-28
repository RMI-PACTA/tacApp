test_that("has the expected aspect ratio", {
  # styler: off
  data <- tibble::tribble(
    ~technology, ~id,  ~category,     ~type,  ~start,    ~end,   ~value,
        "oil",   1,   "before",   "total",       0, 0.02374,  0.02374,
        "oil",   2,   "remove",    "real", 0.02374, 0.02214,  -0.0016,
        "oil",   3,     "sell", "virtual", 0.02214, 0.01738, -0.00476,
        "oil",   4, "too late", "unknown", 0.01738, 0.01898,   0.0016,
        "oil",   5,    "after",   "total", 0.01898,       0,  0.01898
  )
  # styler: on
  p <- plot_techs(data, aspect.ratio = 2 / 1)
  expect_equal(p$theme$aspect.ratio, 2 / 1)
})

test_that("the visuals remain the same", {
  data <- prep_raw(full(), full()[40,])
  p <- plot_techs(data)
  vdiffr::expect_doppelganger("with tech data x-labels reamain the same", p)
})

test_that("with no data for technology the visuals remain the same", {
  data <- suppressWarnings(prep_raw(full(), full()[1,]))
  p <- plot_techs(data)
  vdiffr::expect_doppelganger("with no tech data x-labels reamain the same", p)
})
