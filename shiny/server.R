library(shiny)

function(input, output) {
  
  output$graf1 <- renderPlot({
    graf.gibanje.obcina <- ggplot(brezposelnost_in_obsojeni %>% filter(obcina == input$obcina1)) + 
      aes(x = leto, y = stopnja, colour = meritev) + geom_line()+
      labs(title = "Gibanje kriminalitete in brezposelnosti")
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
  
  output$graf2 <- renderPlot({
    podatki <- brezposelnost_in_obsojeni2 %>% filter(obsojeni < 10 & brezposelni < 25) %>% filter(leto == input$leto2)
    LM <- lm(obsojeni ~ brezposelni, data=podatki)
    novi.brezposelni <- data.frame(brezposelni=c(25, 30,35))
    predict(LM, novi.brezposelni)
    napoved <- novi.brezposelni %>% mutate(obsojeni=predict(LM, .))
    graf.povezava <- ggplot(podatki, aes(x = brezposelni, y = obsojeni)) + 
      geom_point(shape=1) + 
      geom_smooth(method=lm, se = FALSE) +
      geom_point(data=napoved, aes(x = brezposelni, y = obsojeni), color='red', size=3)+
      labs(title = "Povezava med stopnjo brezposelnih in obsojenih")
    print(graf.povezava)
  })
  
}
