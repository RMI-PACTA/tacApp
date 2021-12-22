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
        label_find_id(),
        mainPanel(DTOutput("explore"))
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
  output$explore <- renderDT(
    select_tech_and_id(full()),
    filter = "top",
    selection = list(mode = "single", selected = 1, target = "row")
  )

  row <- reactive(slice(full(), input$explore_rows_selected))

  data <- reactive({
    prep_raw(full(), row())
  })

  output$summary <- renderTable(summarize_change(data()))
  output$plot <- renderPlot(plot_techs(data()), res = match_rstudio())

  output$table <- renderDT(data())
  output$download <- download(data())
}

download <- function(data) {
  downloadHandler(
    filename = function() "tacApp.csv",
    content = function(file) write_csv(data, file)
  )
}
