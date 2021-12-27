# outputs the same

    Code
      out
    Output
      # A tibble: 9 x 7
        technology    id category  type     start    end    value
        <chr>      <int> <chr>     <chr>    <dbl>  <dbl>    <dbl>
      1 oil            1 before    total   0      0.0237  0.0237 
      2 oil            2 remove    real    0.0237 0.0221 -0.0016 
      3 oil            3 sell      virtual 0.0221 0.0174 -0.00476
      4 oil            4 too late  unknown 0.0174 0.0190  0.0016 
      5 oil            5 after     total   0.0190 0       0.0190 
      6 oil            6 add       real    0      0       0      
      7 oil            7 ramp up   real    0      0       0      
      8 oil            8 ramp down real    0      0       0      
      9 oil            9 buy       virtual 0      0       0      

