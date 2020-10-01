library(shiny)
library(rsconnect)
library(shinydashboard)
library("googlesheets4")
library("DT")

#(deaths <- gs4_example("deaths") %>%
#    range_read(range = "other_data", col_types = "????DD"))
#deaths_one   <- deaths[ 1:5, ]
#sheet_append("https://docs.google.com/spreadsheets/d/13G-tkOyOIv4XIzpRywgc2FEcIAJOr8jntjSPKGVf8cE/edit#gid=0",
#             deaths_one,
#             sheet = 1)

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
      Name = c("Question 1",
               "Question 2",
               "Question 3"),
      Value = as.character(c(input$question_1,
                             input$question_2,
                             input$question_3)
                           ),
      stringsAsFactors = FALSE)
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