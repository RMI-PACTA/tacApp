# outputs the expected snapshot

    Code
      tweak(data)
    Output
      # A tibble: 11,129 x 30
         technology target_company_id subsidiary_company_id  SBTI CA100  market_cap
         <fct>                  <int>                 <int> <dbl> <dbl>       <dbl>
       1 coal                    6736                377985    NA     1 29290700000
       2 coal                  175374                175374    NA    NA          NA
       3 coal                    6789                258796    NA    NA 23934000000
       4 coal                  429218                429218    NA    NA          NA
       5 coal                  383544                383544    NA    NA          NA
       6 coal                    5627                  5627    NA    NA 11404400000
       7 coal                    5457                405767    NA    NA  8865360000
       8 coal                    5457                405767    NA    NA  8865360000
       9 coal                    5627                  5627    NA    NA 11404400000
      10 coal                   82393                  9775    NA    NA          NA
      # ... with 11,119 more rows, and 24 more variables: company_status <chr>,
      #   state_owned_entity_type <lgl>, shares_weight <dbl>, source_id <dbl>,
      #   asset_name <chr>, start_year <dbl>, dual <dbl>, status_x <chr>,
      #   asset_location <chr>, comp_cap_2018q4 <dbl>, comp_cap_2018_actual <dbl>,
      #   comp_cap_2018_plan <dbl>, status_y <chr>, comp_cap_2020q3 <dbl>,
      #   comp_cap_2020_actual <dbl>, source_id_cnt <dbl>, category <chr>,
      #   asset_cap_2018q4 <dbl>, asset_cap_2020q3 <dbl>, region <chr>, ...

