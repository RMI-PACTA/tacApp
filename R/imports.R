#' @import ggplot2
#' @import shiny
#' @importFrom DT renderDT DTOutput
#' @importFrom dplyr arrange case_when filter group_by filter if_else mutate
#' @importFrom dplyr select summarise mutate relocate pull bind_rows matches
#' @importFrom dplyr slice across distinct
#' @importFrom fs path_ext_remove path_file dir_ls
#' @importFrom glue glue
#' @importFrom here here
#' @importFrom r2dii.plot theme_2dii
#' @importFrom readr read_csv write_csv
#' @importFrom rlang %||% .data .env sym abort
#' @importFrom tibble enframe tibble add_column tribble
#' @importFrom tidyr unnest
#' @importFrom utils head
NULL

full <- function() {
  tacAppPrivateData::full
}

globalVariables(c(
  "valid",
  "useful",
  "category",
  "end",
  "id",
  "start",
  "type"
))
