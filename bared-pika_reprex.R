#' ---
#' output: reprex::reprex_document
#' ---

devtools::load_all()

real_categories()

virtual_categories()

# styler: on
data <- tibble::tribble(
  ~technology, ~id, ~category,   ~type, ~start,  ~end, ~value,
  "renewables",   1,  "before", "total",      0, 0.001,  0.001,
  "renewables",   2,     "add",  "real",  0.001,     0, -0.001,
  "renewables",   3,   "after", "total",      0,     0,      0
)
# styler: off
plot_techs(data)

# With real and virtual, orange is virtual, green is real
# styler: on
data <- tibble::tribble(
   ~technology, ~id, ~category,     ~type,  ~start,    ~end,  ~value,
  "renewables",   1,  "before",   "total",       0, 0.24064, 0.24064,
  "renewables",   2,     "add",    "real", 0.24064, 0.60664,   0.366,
  "renewables",   3,     "buy", "virtual", 0.60664, 0.65664,    0.05,
  "renewables",   4,   "after",   "total", 0.65664,       0, 0.65664
  )
# styler: off
plot_techs(data)

# With only virtual, orange is virtual
# styler: on
data <- tibble::tribble(
   ~technology, ~id, ~category,     ~type, ~start,   ~end, ~value,
  "renewables",   1,  "before",   "total",      0, 0.0062, 0.0062,
  "renewables",   2,     "buy", "virtual", 0.0062, 0.0182,  0.012,
  "renewables",   3,   "after",   "total", 0.0182,      0, 0.0182
  )
# styler: off
plot_techs(data)

# FIXME: With only real, orange is real
# styler: on
data <- tibble::tribble(
   ~technology, ~id, ~category,   ~type, ~start,  ~end, ~value,
  "renewables",   1,  "before", "total",      0, 0.001,  0.001,
  "renewables",   2,  "remove",  "real",  0.001,     0, -0.001,
  "renewables",   3,   "after", "total",      0,     0,      0
  )
# styler: off
plot_techs(data)
