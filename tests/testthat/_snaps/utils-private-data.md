# the structure of private data remains the same

    Code
      class(full())
    Output
      [1] "spec_tbl_df" "tbl_df"      "tbl"         "data.frame" 

---

    Code
      names(full())
    Output
       [1] "SBTI"                    "CA100"                  
       [3] "market_cap"              "company_status"         
       [5] "state_owned_entity_type" "target_company_id"      
       [7] "subsidiary_company_id"   "shares_weight"          
       [9] "source_id"               "asset_name"             
      [11] "start_year"              "technology"             
      [13] "dual"                    "status_x"               
      [15] "asset_location"          "comp_cap_2018q4"        
      [17] "comp_cap_2018_actual"    "comp_cap_2018_plan"     
      [19] "status_y"                "comp_cap_2020q3"        
      [21] "comp_cap_2020_actual"    "source_id_cnt"          
      [23] "category"                "asset_cap_2018q4"       
      [25] "asset_cap_2020q3"        "region"                 
      [27] "sub-region"              "comp_size"              
      [29] "comp_region"             "comp_sub_region"        

---

    Code
      dim(full())
    Output
      [1] 163520     30

---

    Code
      class(company_lookup())
    Output
      [1] "tbl_df"     "tbl"        "data.frame"

---

    Code
      names(company_lookup())
    Output
      [1] "company_id"   "company_name"

---

    Code
      dim(company_lookup())
    Output
      [1] 56523     2

