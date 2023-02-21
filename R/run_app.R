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
    #content
    tabsetPanel(
      id = "tabs",
      tabPanel(
        "Select a company and technology",
        mainPanel(
          fluidRow(
            selectizeInput("name", label = "Company", choices = NULL),
            selectInput("sector", label = "Sector", choices = NULL),
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
  # Password prompt
  shinyalert::shinyalert(
    title = "Log in",
    text = "Password",
    type = "input",
    closeOnEsc = F,
    closeOnClickOutside = F,
    showCancelButton = F,
    showConfirmButton = T,
    inputType = "password",
    inputPlaceholder = "password",
    inputValue = "Password",
    confirmButtonCol = "#26a69a"
  )

  observeEvent(input$shinyalert, {

    if (input$shinyalert == Sys.getenv("tacApp_password")) {
      # If user successfully authenticated.

      # Using server-side selectize for massively improved performance. See
      # ?selectizeInput and https://shiny.rstudio.com/articles/selectize.html
      choices <- unique(useful$company_name)
      updateSelectizeInput(session, "name", choices = choices, server = TRUE)

      company_name <- reactive({
        filter(useful, .data$company_name == input$name)
      })

      company_name_sector <- reactive({
        filter(company_name(), .data$sector == input$sector)
      })

      observeEvent(company_name(), {
        choices_sector <- unique(company_name()$sector)
        updateSelectInput(inputId = "sector", choices = choices_sector)
      })

      observeEvent(company_name_sector(), {
        choices_tech <- unique(company_name_sector()$technology)
        updateSelectInput(inputId = "tech", choices = choices_tech)
      })

      selected <- eventReactive(input$apply, {
        filter(company_name(), .data$sector == input$sector, .data$technology == input$tech)
      })

      result <- reactive({
        # FIXME: Do we expect to have more than 1 row for one company name and tech?
        selected <- head(selected(), 1)
        prep_raw(valid, selected = selected)
      })

      output$summary <- renderTable({
        out <- summarize_change(result())
        out <- round_percent_columns(out)
        names(out) <- format_summary_names(nms = names(out), sector = unique(result()$sector))
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

    } else {
      # Bad password.
      shinyalert::shinyalert(
        title = "Unauthorized",
        text = "Bad password. Try again?",
        type = "error",
        showConfirmButton = T,
        showCancelButton = T,
        closeOnClickOutside = F,
        closeOnEsc = F,
        confirmButtonCol = "#26a69a",
        callbackJS = "function(x) { if(x !== false) history.go(0); }" #refresh page on OK
      )
    }
  })
}

download <- function(data) {
  downloadHandler(
    filename = function() "tacApp.csv",
    content = function(file) write_csv(data, file)
  )
}
