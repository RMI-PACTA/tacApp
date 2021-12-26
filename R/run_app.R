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
  known_id <- 8L
  default <- list(mode = "single", selected = known_id, target = "row")
  output$row_selector <- renderDT(
    select_output_columns(full()),
    selection = default
  )
  data <- reactive({
    row <- slice(full(), input$row_selector_rows_selected)
    prep_raw(full(), row)
  })

  output$summary <- renderTable({
    out <- summarize_change(data())
    out <- round_percent_columns(out)
    names(out) <- format_summary_names(names(out))
    out
  })
  output$plot <- renderPlot(
    plot_techs(data(), aspect.ratio = 1 / 1),
    res = match_rstudio(),
    height = function() {
      # https://github.com/rstudio/shiny/issues/650#issuecomment-62443654
      session$clientData$output_plot_width
    }
  )

  output$table <- renderDT(data())
  output$download <- download(data())
}

download <- function(data) {
  downloadHandler(
    filename = function() "tacApp.csv",
    content = function(file) write_csv(data, file)
  )
}
