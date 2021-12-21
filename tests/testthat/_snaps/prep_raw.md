# outputs the same

    Code
      out
    Output
      # A tibble: 8 x 7
        technology    id category     type    start   end  value
        <chr>      <dbl> <chr>        <chr>   <dbl> <dbl>  <dbl>
      1 coal           1 before       total     0    17.3 17.3  
      2 coal           2 buy          virtual  17.3  19.6  2.32 
      3 coal           3 ramp up      real     19.6  19.6  0.024
      4 coal           4 remove       real     19.6  15.0 -4.65 
      5 coal           5 sell         virtual  15.0  12.4 -2.55 
      6 coal           6 ramp down    real     12.4  12.2 -0.199
      7 coal           7 unidentified unknown  12.2  12.1 -0.179
      8 coal           8 after        total    12.1   0   12.1  

# with invalid id errors gracefully

    `target_company_id = 1` is invalid. Do you need to go back to the tab 'Explore companies'?

