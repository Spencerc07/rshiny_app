library(shiny)

# Title and base structure
ui <- navbarPage(
  title = "DBT ADHERE",
  fluid = TRUE, 
  collapsible = TRUE,
  
  #Home tab
  tabPanel("Home", 
        includeHTML("html/home.html")
  ),
  
  #Individual panels, edit for specifics i.e. video link or questions
  tabPanel("What is Adherence?",
        includeHTML("html/what_is_adherence_tab.html")
  ),
  
  
  tabPanel(
      tags$a(href="https://login.panopto.com/?_ga=2.231228637.390442522.1549577689-2042957927.1549577689","Video")
    ),
  
  tabPanel("Adherence Questions"), 
  tabPanel("Analysis")
)

server <- function(input, output) {
  
}


shinyApp(ui = ui, server = server)