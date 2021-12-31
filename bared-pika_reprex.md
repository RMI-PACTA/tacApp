``` r
devtools::load_all()
#> ℹ Loading tacApp

real_categories()
#> [1] "add"       "remove"    "ramp up"   "ramp down"

virtual_categories()
#> [1] "buy"  "sell"

# styler: on
data <- tibble::tribble(
  ~technology, ~id, ~category,   ~type, ~start,  ~end, ~value,
  "renewables",   1,  "before", "total",      0, 0.001,  0.001,
  "renewables",   2,     "add",  "real",  0.001,     0, -0.001,
  "renewables",   3,   "after", "total",      0,     0,      0
)
# styler: off
plot_techs(data)
```

![](https://i.imgur.com/4HUbMnz.png)

``` r
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
```

![](https://i.imgur.com/Pbqe3zj.png)

``` r
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
```

![](https://i.imgur.com/LcRuFFM.png)

``` r
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
```

![](https://i.imgur.com/jNaCgLJ.png)

<sup>Created on 2021-12-31 by the [reprex package](https://reprex.tidyverse.org) (v2.0.1)</sup>
