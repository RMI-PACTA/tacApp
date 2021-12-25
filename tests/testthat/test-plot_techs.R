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
  p <- plot_techs(data, aspect.ratio = 2 / 1, legend.position = "right")
  expect_equal(p$theme$aspect.ratio, 2 / 1)
})
