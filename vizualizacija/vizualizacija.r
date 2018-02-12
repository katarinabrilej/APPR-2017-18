# 3. faza: Vizualizacija podatkov
library(ggplot2)
library(dplyr)

#10 držav z največjih številom umorjenih na 100000 prebivalcev
graf.umorjeni <- ggplot(umorjeni2[order(umorjeni2$umorjeni, decreasing=TRUE), ] %>% .[1:10, ]) + 
  aes(x = Drzava, y = umorjeni, fill = Drzava) + geom_col() + 
  theme(axis.text.x = element_blank()) +
  labs(title = "10 drzav z najvisjo stopnjo umorjenih") +
  ylab("Stopnja")

#print(graf.umorjeni)

#10 držav z najmanjšim številom umorjenih na 100000 prebivalcev
graf.umorjeni2 <- ggplot(umorjeni2[order(umorjeni2$umorjeni, decreasing=FALSE), ] %>% .[1:10, ]) + 
  aes(x = Drzava, y = umorjeni, fill = Drzava) + geom_col() + 
  theme(axis.text.x = element_blank()) +
  labs(title = "10 drzav z najnizjo stopnjo umorjenih") +
  ylab("Stopnja")

#print(graf.umorjeni2)

#10 držav z največjih številom zaprtih na 100000 prebivalcev
graf.zaprti <- ggplot(zaprti2[order(zaprti2$zaprti, decreasing=TRUE), ] %>% .[1:10, ]) + 
  aes(x = Drzava, y = zaprti, fill = Drzava) + geom_col() + 
  theme(axis.text.x = element_blank()) +
  labs(title = "10 drzav z najvisjo stopnjo zaprtih") +
  ylab("Stopnja")

#print(graf.zaprti)

#10 držav z najmanjšim številom zaprtih na 100000 prebivalcev
graf.zaprti2 <- ggplot(zaprti2[order(zaprti2$zaprti, decreasing=FALSE), ] %>% .[1:10, ]) + 
  aes(x = Drzava, y = zaprti, fill = Drzava) + geom_col() + 
  theme(axis.text.x = element_blank()) +
  labs(title = "10 drzav z najnizjo stopnjo zaprtih") +
  ylab("Stopnja")

#print(graf.zaprti2)

graf.umorjeni.zaprti <- ggplot(data = zaprti_in_umorjeni)+
  geom_point(aes(x = umorjeni, y = zaprti), stat = 'identity')+
  #geom_text(aes(x = umorjeni, y = zaprti, label=Drzava),hjust=0, vjust=0)+
  labs(title ="Primerjava stopnje zaprtih in stopnje umorjenih")+
  ylab("Stopnja zaprtih") + xlab("Stopnja umorjenih")

#print(graf.umorjeni.zaprti)

#gibanje kriminalitete v ljubljani v obdobju 2006-2015

Ljubljana <- brezposelnost_in_obsojeni[brezposelnost_in_obsojeni$obcina == "Ljubljana",]
graf2 <- ggplot(Ljubljana) + aes(x = leto, y = stopnja, colour = meritev) + geom_line()
#print(graf2)

#gibanje stevila brezposelnih in obsojenih v Sloveniji v obdobju 2006-2015
graf.gibanje <- ggplot(brezposelnost_in_obsojeni)


# Uvozimo zemljevid.
#zemljevid sveta
zemljevid <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                             "ne_50m_admin_0_countries", 
                             encoding = "UTF-8") %>% pretvori.zemljevid()

colnames(zemljevid)[11] <- 'drzava'

zemljevid$drzava <- as.character(zemljevid$drzava)
zemljevid$drzava[zemljevid$drzava == "Republic of Serbia"] <- "Serbia"
zemljevid$drzava[zemljevid$drzava == "Cabo Verde"] <- "Cape Verde"
zemljevid$drzava[zemljevid$drzava == "Czechia"] <- "Czech Republic"
zemljevid$drzava[zemljevid$drzava == "The Bahamas"] <- "Bahamas"
zemljevid$drzava[zemljevid$drzava == "United Republic of Tanzania"] <- "Tanzania"
zemljevid$drzava[zemljevid$drzava == "United States of America"] <- "United States"




zemljevid.umorjeni <- ggplot() +
  geom_polygon(data = umorjeni2 %>% right_join(zemljevid, by = c("Drzava" = "drzava")),
               aes(x = long, y = lat, group = group, fill = umorjeni), alpha = 0.8, color = "black")+
  scale_fill_gradient2(low = "yellow", mid = "red",
                       high = "brown", midpoint = 75) + 
  xlab("") + ylab("") + ggtitle("Stopnja umorjenih po svetu")

#print(zemljevid.umorjeni)

  
zemljevid.zaprti <- ggplot() +
    geom_polygon(data = zaprti2 %>% right_join(zemljevid, by = c("Drzava" = "drzava")),
                 aes(x = long, y = lat, group = group, fill = zaprti), color = "black")+
    xlab("") + ylab("") + ggtitle("Stopnja zaprtih po svetu")
  
#print(zemljevid.zaprti)

#zemljevid občin
obcine <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip",
                          "OB/OB", encoding = "Windows-1250") %>% pretvori.zemljevid()


obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Ankaran/Ancarano"] <- "Ankaran"

obcine$OB_UIME <- as.character(obcine$OB_UIME)
obsojeni_po_obcinah2$obcina <- as.character(obsojeni_po_obcinah2$obcina)
zemljevid.obsojeni <- ggplot() +
  geom_polygon(data = obsojeni_po_obcinah2 %>% filter(leto == "2016") %>% right_join(obcine, by = c("obcina" = "OB_UIME")),
               aes(x = long, y = lat, group = group, fill = obsojeni), color = "black")+
  xlab("") + ylab("") + ggtitle("Stopnja obsojenih po slovenskih obcinah")

print(zemljevid.obsojeni)

levels(obcine$OB_UIME)
unique(obsojeni_po_obcinah2$obcina) #podatki za 212 občin


  

