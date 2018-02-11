# 3. faza: Vizualizacija podatkov
library(ggplot2)
library(dplyr)

#10 držav z največjih številom umorjenih na 100000 prebivalcev
umorjeni.urejeno <- umorjeni[order(umorjeni$umorjeni, decreasing=TRUE), ] %>% .[1:10, ]
graf1 <- ggplot(umorjeni.urejeno) + aes(x = Drzava, y = umorjeni, fill = Drzava) + geom_col() + 
  theme(axis.text.x = element_blank())

#gibanje kriminalitete v ljubljani v obdobju 2006-2015

Ljubljana <- brezposelnost_in_obsojeni[brezposelnost_in_obsojeni$obcina == "Ljubljana",]
graf2 <- ggplot(Ljubljana) + aes(x = leto, y = stopnja, colour = meritev) + geom_line()


# Uvozimo zemljevid.

zemljevid <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                             "ne_50m_admin_0_countries", 
                             encoding = "UTF-8") %>%
  pretvori.zemljevid()


colnames(zemljevid)[11] <- 'drzava'

zemljevid$drzava <- as.character(zemljevid$drzava)
zemljevid$drzava[zemljevid$drzava == "Republic of Serbia"] <- "Serbia"
zemljevid$drzava[zemljevid$drzava == "Cabo Verde"] <- "Cape Verde"
zemljevid$drzava[zemljevid$drzava == "Czechia"] <- "Czech Republic"
zemljevid$drzava[zemljevid$drzava == "The Bahamas"] <- "Bahamas"
zemljevid$drzava[zemljevid$drzava == "United Republic of Tanzania"] <- "Tanzania"
zemljevid$drzava[zemljevid$drzava == "United States of America"] <- "United States"


umorjeni$Drzava[umorjeni$Drzava == "Micronesia, Fed. Sts."] <- "Federated States of Micronesia"


zemljevid.umorjeni <- ggplot() +
  geom_polygon(data = umorjeni %>% right_join(zemljevid, by = c("Drzava" = "drzava")),
               aes(x = long, y = lat, group = group, fill = umorjeni), color = "black")+
  xlab("") + ylab("") + ggtitle("Stopnja umorjenih po svetu")

#print(zemljevid.umorjeni)
  
  
zemljevid.zaprti <- ggplot() +
    geom_polygon(data = zaprti %>% right_join(zemljevid, by = c("Drzava" = "drzava")),
                 aes(x = long, y = lat, group = group, fill = zaprti), color = "black")+
    xlab("") + ylab("") + ggtitle("Stopnja zaprtih po svetu")
  
#print(zemljevid.zaprti)
  

