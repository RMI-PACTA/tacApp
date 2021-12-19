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
  op <- options(shiny.maxRequestSize = 1000 * 1024 ^ 2)
  on.exit(options(op), add = TRUE, after = FALSE)

  ui <- fluidPage(
    tabsetPanel(
      id = "tabs",

      tabPanel(
        label_find_id(),
        mainPanel(
          fileInput("upload", "Upload a .csv file", accept = c(".csv", ".zip")),
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
          DT::DTOutput("summary"),
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
        # TODO: Use technology_lumped everywhere?
        dplyr::mutate(technology_lumped = .data$technology) %>%
        dplyr::relocate(.data$technology_lumped, company_types()) %>%
        dplyr::mutate(technology_lumped = tolower(.data$technology_lumped)) %>%
        lump_technology() %>%
        dplyr::mutate(
          technology_lumped = factor(.data$technology_lumped),
          target_company_id = as.integer(.data$target_company_id),
          subsidiary_company_id = as.integer(.data$subsidiary_company_id)
        )
    })
    output$explore <- DT::renderDT(
      caption = "Uploaded data.",
      filter = "top",
      raw_tweaked()
    )

    observeEvent(input$upload, {
      updateSelectInput(
        inputId = "technology",
        choices = unique(raw_tweaked()$technology_lumped)
      )
    })

    data <- eventReactive(input$go, {
      req(input$company_id)
      prep_techs(
        raw(),
        company_id = input$company_id,
        company_type = input$company_type,
        technology = input$technology
      )
    })

    output$summary <- DT::renderDT(
      caption = "Summary.",
      summarize_change(data())
    )
    output$plot <- renderPlot(plot_techs(data()), res = match_rs())

    output$table <- DT::renderDT(
      caption = "Breakdown of changes.",
      data()
    )
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
