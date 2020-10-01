library(shiny)
library(rsconnect)
library(shinydashboard)
library("googlesheets4")
library("DT")

ui <- tagList(
  tags$head(includeScript("navAppend.js")),
  navbarPage(
    title = "DBT ADHERE",
    fluid = TRUE, 
    collapsible = TRUE,
    
    tabPanel("Home", 
             includeHTML("html/index.html")
    ),
    
    tabPanel("What is Adherence?",
             includeHTML("html/what_is_adherence_tab.html")
    ),
    

    
    tabPanel("Adherence Questions",
             titlePanel("Questionaire"),
             div(
               id = "form",
               sliderInput("question_1", "Question 1", 0, 10, 5, ticks = FALSE),
               sliderInput("question_2", "Question 2", 0, 10, 5, ticks = FALSE),
               sliderInput("question_3", "Question 3", 0, 10, 5, ticks = FALSE),
               
               actionButton("submit", "Submit", class = "btn-primary")
               )
    ), 
    
    tabPanel("Analysis")
  )
)

fieldsName <- c("question_1", "question_2", "question_3")

server <- function(input, output) {
  
  formData <- reactive({
    data.frame(
      q_1 = c(input$question_1),
      q_2 = c(input$question_2),
      q_3 = c(input$question_3)
    )
  })
  
  
  saveData <- function(data) {
    sheet_append("https://docs.google.com/spreadsheets/d/13G-tkOyOIv4XIzpRywgc2FEcIAJOr8jntjSPKGVf8cE/edit#gid=0",
                 formData(),
                 sheet = 1)
  }
  
  observeEvent(input$submit, {
    saveData(formData)
  })
  
}


shinyApp(ui = ui, server = server)