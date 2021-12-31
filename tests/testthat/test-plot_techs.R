test_that("has the expected aspect ratio", {
  # styler: off
  data <- tribble(
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

test_that("with data only of type total and real (no virtual) real is green", {
  # styler: off
  data <- tribble(
     ~technology, ~id, ~category,   ~type, ~start,  ~end, ~value,
    "renewables",   1,  "before", "total",      0, 0.001,  0.001,
    "renewables",   2,  "remove",  "real",  0.001,     0, -0.001,
    "renewables",   3,   "after", "total",      0,     0,      0
    )
  # styler: on
  p <- plot_techs(data)
  vdiffr::expect_doppelganger("only real data", p)
})

test_that("with real and virtual data orange is virtual", {
  # styler: off
  data <- tribble(
     ~technology, ~id, ~category,     ~type,  ~start,    ~end,  ~value,
    "renewables",   1,  "before",   "total",       0, 0.24064, 0.24064,
    "renewables",   2,     "add",    "real", 0.24064, 0.60664,   0.366,
    "renewables",   3,     "buy", "virtual", 0.60664, 0.65664,    0.05,
    "renewables",   4,   "after",   "total", 0.65664,       0, 0.65664
    )
  # styler: on
  p <- plot_techs(data)
  vdiffr::expect_doppelganger("virtual and real data", p)
})

test_that("with only virtual data orange is virtual", {
  # styler: off
  data <- tribble(
     ~technology, ~id, ~category,     ~type, ~start,   ~end, ~value,
    "renewables",   1,  "before",   "total",      0, 0.0062, 0.0062,
    "renewables",   2,     "buy", "virtual", 0.0062, 0.0182,  0.012,
    "renewables",   3,   "after",   "total", 0.0182,      0, 0.0182
    )
  # styler: on
  p <- plot_techs(data)
  vdiffr::expect_doppelganger("only virtual data", p)
})
