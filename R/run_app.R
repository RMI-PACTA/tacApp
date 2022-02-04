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
        "Select a company and technology",
        mainPanel(
          fluidRow(
            selectizeInput("name", label = "Parent company", choices = NULL),
            selectInput("tech", label = "Technology", choices = NULL),
            actionButton("apply", "Apply", class = "btn-lg btn-success")
          ),
          fluidRow(
            tableOutput("summary"),
            plotOutput("plot")
          )
        )
      ),
      tabPanel(
        "Download results",
        tableOutput("table"),
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
  # Using server-side selectize for massively improved performance. See
  # ?selectizeInput and https://shiny.rstudio.com/articles/selectize.html
  choices <- unique(useful$target_company_name)
  updateSelectizeInput(session, "name", choices = choices, server = TRUE)

  company_name <- reactive({
    # browser()
    filter(useful, .data$target_company_name == input$name)
  })

  observeEvent(company_name(), {
    choices <- unique(company_name()$technology)
    updateSelectInput(inputId = "tech", choices = choices)
  })

  selected <- eventReactive(input$apply, {
    filter(company_name(), .data$technology == input$tech)
  })

  result <- reactive({
    # FIXME: Do we expect to have more than 1 row for one company name and tech?
    selected <- head(selected(), 1)
    prep_raw(valid, selected = selected)
  })

  output$summary <- renderTable({
    out <- summarize_change(result())
    out <- round_percent_columns(out)
    names(out) <- format_summary_names(names(out))
    out
  })

  output$plot <- renderPlot(
    {
      req(input$apply)
      plot_techs(result(), aspect.ratio = 1 / 1)
    },
    res = match_rstudio(),
    height = function() {
      # https://github.com/rstudio/shiny/issues/650#issuecomment-62443654
      session$clientData$output_plot_width
    }
  )

  output$table <- renderTable(result())
  output$download <- download(result())
}

download <- function(data) {
  downloadHandler(
    filename = function() "tacApp.csv",
    content = function(file) write_csv(data, file)
  )
}
