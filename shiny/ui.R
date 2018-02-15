library(shiny)

fluidPage(
  titlePanel("Analiza"),
  
  tabPanel("Graf",
           sidebarPanel(
             selectInput("obcina1", label = "Izberi obcino", 
                         choices = unique(brezposelnost_in_obsojeni$obcina))),
           mainPanel(plotOutput("graf1"))),
  tabPanel("Zemljevid",
           sidebarPanel(
             selectInput("leto1", label = "Izberi leto", 
                         choices = unique(obsojeni_po_obcinah2$leto))),
           mainPanel(plotOutput("zemljevid1"))),
  tabPanel("Graf",
           sidebarPanel(
             selectInput("leto2", label = "Izberi leto", 
                         choices = unique(brezposelnost_in_obsojeni2$leto))),
           mainPanel(plotOutput("graf2")))
)
