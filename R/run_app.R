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
        "Analize",
        sidebarPanel(
          selectInput("technology", "Technology", techs()),
          selectInput("company_type", "Company type", choices = company_types()),
          numericInput("company_id", "Company ID", value = NA),
          actionButton("go", "Analize", class = "btn-lg btn-success")
        ),
        mainPanel(
          tableOutput("summary"),
          plotOutput("plot")
        )
      ),
      tabPanel(
        "Download",
        DTOutput("table"),
        downloadButton("download", "Download")
      )
    )
  )

  server <- function(input, output, session) {
    tweaked <- reactive(tweak(full()))
    output$explore <- renderDT(select_tech_and_id(tweaked()), filter = "top")

    data <- eventReactive(input$go, {
      req(input$company_id)

      prep_raw(
        tweaked(),
        company_id = input$company_id,
        company_type = input$company_type,
        technology = input$technology
      )
    })

    output$summary <- renderTable(summarize_change(data()))
    output$plot <- renderPlot(plot_techs(data()), res = match_rstudio())

    output$table <- renderDT(data())
    output$download <- download(data())
  }

  shinyApp(ui, server)
}

download <- function(data) {
  downloadHandler(
    filename = function() "tacApp.csv",
    content = function(file) write_csv(data, file)
  )
}
