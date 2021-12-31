#' Run the tacApp
#'
#' @return Called for its side effect.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   run_app()
#' }
run_app <- function() {
  ui <- fluidPage(
    tabsetPanel(
      id = "tabs",
      tabPanel(
        "Search and select one row",
        mainPanel(DTOutput("row_selector"))
      ),
      tabPanel(
        "View changes",
        mainPanel(
          tableOutput("summary"),
          plotOutput("plot")
        )
      ),
      tabPanel(
        "Download results",
        DTOutput("table"),
        downloadButton(
          "download", "Download results",
          class = "btn-lg btn-success"
        )
      )
    )
  )

  shinyApp(ui, server)
}

server <- function(input, output, session) {
  first_row <- 1L
  default_row <- list(mode = "single", selected = first_row, target = "row")
  output$row_selector <- renderDT(
    select_output_columns(useful),
    selection = default_row,
    filter = "top"
  )

  result <- reactive({
    selected_row <- slice(useful, input$row_selector_rows_selected)
    prep_raw(valid, selected_row)
  }) %>%
    bindCache(input$row_selector_rows_selected)

  output$summary <- renderTable({
    out <- summarize_change(result())
    out <- round_percent_columns(out)
    names(out) <- format_summary_names(names(out))
    out
  })

  output$plot <- renderPlot(
    plot_techs(result(), aspect.ratio = 1 / 1),
    res = match_rstudio(),
    height = function() {
      # https://github.com/rstudio/shiny/issues/650#issuecomment-62443654
      session$clientData$output_plot_width
    }
  )

  output$table <- renderDT(result())
  output$download <- download(result())
}

download <- function(data) {
  downloadHandler(
    filename = function() "tacApp.csv",
    content = function(file) write_csv(data, file)
  )
}
