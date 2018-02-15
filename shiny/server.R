library(shiny)

function(input, output) {
  
  output$grafi1 <- renderPlot({
    graf2 <- ggplot(brezposelnost_in_obsojeni %>% filter(obcina == input$obcina1)) + 
      aes(x = leto, y = stopnja, colour = meritev) + geom_line()+
      labs(title = "gibanje kriminalitete in brezposelnosti v Ljubljani")
    print(graf2)
  })
}
