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
        mainPanel(
          fileInput(
            "upload",
            sprintf("Upload a file (%s)", toString(ext())),
            accept = ext()
          ),
          a(
            "Hint: Compress a large .csv to .zip.",
            href = "https://archive.r-lib.org/"
          ),
          DT::DTOutput("explore")
        )
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
        DT::DTOutput("table"),
        downloadButton("download", "Download")
      )
    )
  )

  server <- function(input, output, session) {
    raw <- reactive({
      req(input$upload)
      read_csv(input$upload$datapath, show_col_types = FALSE)
    })

    raw_tweaked <- reactive({
      raw() %>%
        dplyr::relocate(.data$technology, company_types()) %>%
        lump_technology() %>%
        dplyr::mutate(
          technology = factor(.data$technology),
          target_company_id = as.integer(.data$target_company_id),
          subsidiary_company_id = as.integer(.data$subsidiary_company_id)
        )
    })
    output$explore <- DT::renderDT(raw_tweaked(), filter = "top")

    observeEvent(input$upload, {
      updateSelectInput(
        inputId = "technology",
        choices = unique(raw_tweaked()$technology)
      )
    })

    data <- eventReactive(input$go, {
      req(input$company_id)
      prep_raw(
        raw(),
        company_id = input$company_id,
        company_type = input$company_type,
        technology = input$technology
      )
    })

    output$summary <- renderTable(summarize_change(data()))
    output$plot <- renderPlot(plot_techs(data()), res = match_rstudio())

    output$table <- DT::renderDT(data())
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
