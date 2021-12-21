#' @importFrom dplyr arrange case_when filter group_by filter if_else mutate
#' @import shiny
#' @import ggplot2
#' @importFrom dplyr select summarise mutate relocate pull bind_rows
#' @importFrom tibble enframe
#' @importFrom tidyr unnest
#' @importFrom readr read_csv write_csv
#' @importFrom rlang %||% .data .env sym
#' @importFrom r2dii.plot theme_2dii
#' @importFrom utils head
#' @importFrom DT renderDT DTOutput
NULL

globalVariables(c(
  "category",
  "end",
  "id",
  "start",
  "type"
))
