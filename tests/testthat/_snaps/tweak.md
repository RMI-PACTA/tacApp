# outputs the expected snapshot

    Code
      tweak(full())
    Output
      # A tibble: 163,520 x 32
         technology   target_company_id subsidiary_company_id target_company_name     
         <fct>                    <int>                 <int> <chr>                   
       1 hydro                   429218                429218 <NA>                    
       2 wind_onshore             78791                 18256 <NA>                    
       3 hydro                   429218                429218 <NA>                    
       4 solar_pv                429218                429218 <NA>                    
       5 wind_onshore             42244                 42244 Sandy Cove Energy Ltd.  
       6 solar_pv                   919                194971 African Energy Resource~
       7 wind_onshore             78791                 18256 <NA>                    
       8 hydro                   429218                429218 <NA>                    
       9 wind_onshore            429218                429218 <NA>                    
      10 solar_pv                   919                194971 African Energy Resource~
      # ... with 163,510 more rows, and 28 more variables:
      #   subsidiary_company_name <chr>, SBTI <dbl>, CA100 <dbl>, market_cap <dbl>,
      #   company_status <chr>, state_owned_entity_type <lgl>, shares_weight <dbl>,
      #   source_id <dbl>, asset_name <chr>, start_year <dbl>, dual <dbl>,
      #   status_x <chr>, asset_location <chr>, comp_cap_2018q4 <dbl>,
      #   comp_cap_2018_actual <dbl>, comp_cap_2018_plan <dbl>, status_y <chr>,
      #   comp_cap_2020q3 <dbl>, comp_cap_2020_actual <dbl>, source_id_cnt <dbl>, ...

