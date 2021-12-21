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
  op <- options(shiny.maxRequestSize = 500 * 1024 ^ 2)
  on.exit(options(op), add = TRUE, after = FALSE)

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
    raw <- reactive({
      path <- private_path("all_technologies.csv")
      read_csv(path, show_col_types = FALSE, lazy = TRUE)
    })

    tweaked <- reactive(tweak(raw()))
    output$explore <- renderDT(tweaked(), filter = "top")

    observeEvent(input$upload, {
      updateSelectInput(
        inputId = "technology",
        choices = unique(tweaked()$technology)
      )
    })

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
