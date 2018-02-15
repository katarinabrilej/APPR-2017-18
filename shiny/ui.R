library(shiny)

fluidPage(
  titlePanel("Analiza"),
  
  tabPanel("Graf",
           sidebarPanel(
             selectInput("obcina1", label = "Izberi obcino", 
                         choices = unique(brezposelnost_in_obsojeni$obcina))),
           mainPanel(plotOutput("grafi1")))
)
