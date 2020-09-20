library(shiny)

# Define UI for app that draws a histogram ----
ui <- navbarPage(
          title = "Spencer's Twisted MIND",
          fluid = TRUE, 
          collapsible = TRUE,
                           
          tabPanel("Home", 
                   includeHTML("home.html")),
                    tags$head(
                      tags$link(rel = "stylesheet", 
                                type = "text/css", 
                                href = "plugins/font-awesome-4.7.0/css/font-awesome.min.css"),
                      tags$link(rel = "icon", 
                                type = "image/jpg", 
                                href = "test.jpg")
                    ),
          
          tabPanel("Video 1"), 
          tabPanel("Video 2"), 
          tabPanel("Graphs")
                           
)

server <- function(input, output) {
  
}


shinyApp(ui = ui, server = server)