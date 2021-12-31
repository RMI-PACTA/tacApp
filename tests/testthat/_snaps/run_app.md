# the first selectable row produces the expected result

    Code
      result()
    Output
      # A tibble: 4 x 7
        technology    id category type    start   end value
        <chr>      <dbl> <chr>    <chr>   <dbl> <dbl> <dbl>
      1 renewables     1 before   total   0     0.241 0.241
      2 renewables     2 add      real    0.241 0.607 0.366
      3 renewables     3 buy      virtual 0.607 0.657 0.05 
      4 renewables     4 after    total   0.657 0     0.657

