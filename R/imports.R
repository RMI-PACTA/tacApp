#' @import ggplot2
#' @import shiny
#' @importFrom dplyr arrange case_when filter group_by filter if_else mutate
#' @importFrom dplyr select summarise mutate relocate pull bind_rows
#' @importFrom DT renderDT DTOutput
#' @importFrom readr read_csv write_csv
#' @importFrom rlang %||% .data .env sym
#' @importFrom r2dii.plot theme_2dii
#' @importFrom tibble enframe
#' @importFrom tidyr unnest
#' @importFrom utils head
NULL

globalVariables(c(
  "category",
  "end",
  "id",
  "start",
  "type"
))
