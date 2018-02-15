library(shiny)

function(input, output) {
  
  output$graf1 <- renderPlot({
    graf.gibanje.obcina <- ggplot(brezposelnost_in_obsojeni %>% filter(obcina == input$obcina1)) + 
      aes(x = leto, y = stopnja, colour = meritev) + geom_line()+
      labs(title = "gibanje kriminalitete in brezposelnosti")
    print(graf.gibanje.obcina)
  })
  
  
  
  output$zemljevid1 <- renderPlot({
    zemljevid.obsojeni <- ggplot() +
      geom_polygon(data = left_join(obcine, obsojeni_po_obcinah2 %>% filter(leto == input$leto1), by = c("OB_UIME" = "obcina")),
                   aes(x = long, y = lat, group = group, fill = obsojeni), color = "black")+
      scale_fill_gradient2(low = "blanchedalmond", mid = "lightpink3",
                           high = "violetred", midpoint = 6) + 
      xlab("") + ylab("") + ggtitle("Stopnja obsojenih po slovenskih obcinah")
    print(zemljevid.obsojeni)
  })  
  
}
