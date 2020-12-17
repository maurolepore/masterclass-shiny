library(shiny)
library(reactlog)
reactlog::reactlog_enable()

ui <- fluidPage(
  selectInput("choice", "A or B?", c("a", "b")),
  numericInput("a", "a", 0),
  numericInput("b", "b", 10),
  textOutput("out")
)

server <- function(input, output, session) {
  a <- reactive(input$a, label = "expression 'a' ")
  b <- reactive(input$b, label = "expresison 'b' ")
  output$out <- renderText({
    if (input$choice == "a") {
      a()
    } else {
      b()
    }
  })
}

shiny::shinyApp(ui, server)
