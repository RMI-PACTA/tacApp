# outputs the same

    Code
      out
    Output
      # A tibble: 10 x 7
         technology    id category     type    start   end   value
         <chr>      <dbl> <chr>        <chr>   <dbl> <dbl>   <dbl>
       1 hydro          1 before       total     0   103.  103.   
       2 hydro          2 add          real    103.  115.   11.7  
       3 hydro          3 buy          virtual 115.  115.    0.286
       4 hydro          4 ramp up      real    115.  115.    0.124
       5 hydro          5 remove       real    115.  103.  -12.7  
       6 hydro          6 sell         virtual 103.   96.4  -6.41 
       7 hydro          7 ramp down    real     96.4  96.2  -0.214
       8 hydro          8 unidentified unknown  96.2  97.2   0.984
       9 hydro          9 too late     unknown  97.2  98.1   0.961
      10 hydro         10 after        total    98.1   0    98.1  

