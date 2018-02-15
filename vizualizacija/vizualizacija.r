# 3. faza: Vizualizacija podatkov
library(ggplot2)
library(dplyr)

#10 držav z največjih številom umorjenih na 100000 prebivalcev
graf.umorjeni.max <- ggplot(umorjeni2[order(umorjeni2$umorjeni, decreasing=TRUE), ] %>% .[1:10, ]) + 
  aes(x = reorder(Drzava, -umorjeni), y = umorjeni, fill = Drzava) + geom_col() + 
  xlab("Drzava") + ylab("Stopnja") +
  theme(axis.text.x = element_blank()) +
  ggtitle("10 drzav z najvisjo stopnjo umorjenih")
  #theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +

#print(graf.umorjeni.max)

#10 držav z najmanjšim številom umorjenih na 100000 prebivalcev
graf.umorjeni.min <- ggplot(umorjeni2[order(umorjeni2$umorjeni, decreasing=FALSE), ] %>% .[1:10, ]) + 
  aes(x = reorder(Drzava, umorjeni), y = umorjeni, fill = Drzava) + geom_col() + 
  xlab("Drzava") + ylab("Stopnja") +
  theme(axis.text.x = element_blank()) +
  ggtitle("10 drzav z najnizjo stopnjo umorjenih")
#theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +

#print(graf.umorjeni.min)

#10 držav z največjih številom zaprtih na 100000 prebivalcev
graf.zaprti.max <- ggplot(zaprti2[order(zaprti2$zaprti, decreasing=TRUE), ] %>% .[1:10, ]) + 
  aes(x = reorder(Drzava, -zaprti), y = zaprti, fill = Drzava) + geom_col() + 
  xlab("Drzava") + ylab("Stopnja") +
  theme(axis.text.x = element_blank()) +
  ggtitle("10 drzav z najvisjo stopnjo zaprtih")
#theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +

#print(graf.zaprti.max)

#10 držav z najmanjšim številom zaprtih na 100000 prebivalcev
graf.zaprti.min <- ggplot(zaprti2[order(zaprti2$zaprti, decreasing=FALSE), ] %>% .[1:10, ]) + 
  aes(x = reorder(Drzava, zaprti), y = zaprti, fill = Drzava) + geom_col() + 
  xlab("Drzava") + ylab("Stopnja") +
  theme(axis.text.x = element_blank()) +
  ggtitle("10 drzav z najnizjo stopnjo zaprtih")
#theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +

#print(graf.zaprti.min)

#povezava med številom umorjenih in zaprtih po svetu
graf.umorjeni.zaprti <- ggplot(data = zaprti_in_umorjeni)+
  geom_point(aes(x = umorjeni, y = zaprti), stat = 'identity')+
  geom_text(data = zaprti_in_umorjeni %>% filter(zaprti > 430 | umorjeni > 30),size = 3,
            aes(x = umorjeni, y = zaprti, label=Drzava),vjust = 2, nudge_y = 0.5, check_overlap = TRUE)+
  #geom_smooth(aes(x = umorjeni , y = zaprti), method = lm, na.rm = TRUE, color = "violet")+
  ggtitle("Povezava med stopnjo umorjenih in zaprtih")+
  xlab("Stopnja umorjenih") + ylab("Stopnja zaprtih")

#print(graf.umorjeni.zaprti)

#gibanje stevila brezposelnih in obsojenih v Sloveniji v obdobju 2006-2015
graf.gibanje <- ggplot(aggregate(stopnja ~ leto+meritev,brezposelnost_in_obsojeni,sum)) + 
  aes(x = leto, y = stopnja, colour = meritev) + geom_line()+
  ggtitle("Gibanje kriminalitete in brezposelnosti v Sloveniji") 

#print(graf.gibanje)

#povezava med številom brezposelnih in obsojenih v slovenskih občinah
graf.obsojeni.brezposelni <- ggplot(data = brezposelnost_in_obsojeni2 %>% filter(leto == 2016))+
  geom_point(aes(x = brezposelni , y = obsojeni), na.rm = TRUE, stat = 'identity')+
  geom_smooth(aes(x = brezposelni , y = obsojeni), method = lm, na.rm = TRUE, color = "violet")+
  geom_text(data = brezposelnost_in_obsojeni2 %>% filter(leto == 2016 & (obsojeni > 6 | brezposelni > 20)),
            aes(x = brezposelni, y = obsojeni, label=obcina),vjust = 2, nudge_y = 0.5, check_overlap = TRUE,na.rm = TRUE)+
  ggtitle("Povezava med stopnjo brezposelnih in obsojenih v Sloveniji")+
  ylab("Stopnja obsojenih") + xlab("Stopnja brezposelnih")

#print(graf.obsojeni.brezposelni)

#gibanje števila kaznivih dejanj v Sloveniji
kazniva.dejanja <- c("KAZNIVA DEJANJA ZOPER URADNO DOLŽNOST IN JAVNA POOBLASTILA",
                        "KAZNIVA DEJANJA ZOPER OKOLJE, PROSTOR IN NARAVNE DOBRINE","KAZNIVA DEJANJA ZOPER ČAST IN DOBRO IME",
                        "KAZNIVA DEJANJA ZOPER SPLOŠNO VARNOST LJUDI IN PREMOŽENJA", "KAZNIVA DEJANJA ZOPER PRAVOSODJE")
Encoding(kazniva.dejanja) <- "UTF-8"

graf.kazniva <- ggplot(data = aggregate(stevilo.obsojenih ~ kaznivo.dejanje+leto,obsojeni_arhiv,sum) %>% 
                         filter(leto > 2008) %>% filter (!kaznivo.dejanje %in% kazniva.dejanja))+
  aes(x = leto, y = stevilo.obsojenih, colour = kaznivo.dejanje) + geom_line()+
  ggtitle("Gibanje kaznivih dejanj v Sloveniji") + 
  ylab("stevilo obsojenih")

#print(graf.kazniva)

#brez kaznivih dejanj proti premoženju
zoper.premozenje <- c("KAZNIVA DEJANJA ZOPER PREMOŽENJE")
kazniva.skupaj = c(kazniva.dejanja, zoper.premozenje)
Encoding(zoper.premozenje) <- "UTF-8"
Encoding(kazniva.skupaj) <- "UTF-8"

graf.kazniva2 <- ggplot(data = aggregate(stevilo.obsojenih ~ kaznivo.dejanje+leto,obsojeni_arhiv,sum) %>% 
                         filter(leto > 2008) %>% filter (!kaznivo.dejanje %in% kazniva.skupaj))+
  aes(x = leto, y = stevilo.obsojenih, colour = kaznivo.dejanje) + geom_line()+
  ggtitle("Gibanje kaznivih dejanj v Sloveniji") + 
  ylab("stevilo obsojenih")

#print(graf.kazniva2)

#graf sankcij glede na spol
graf.sankcije <- ggplot(data = aggregate(stevilo.obsojenih ~ sankcija+leto+spol,obsojeni_arhiv,sum) %>% filter (leto == 2011),
                       aes(x=sankcija, y=stevilo.obsojenih, fill = spol)) +
  geom_bar(position="stack", stat="identity", colour="black")+
  labs(title ="Stevilo obsojenih glede na sankcijo in spol")+
  ylab("Stevilo obsojenih")+xlab("Sankcija")

#print(graf.sankcije)
  
#graf obsojenih glede na spol skozi leta
graf.spol <- ggplot(data = aggregate(stevilo.obsojenih ~ spol+leto,obsojeni_arhiv,sum) %>% filter (leto > 2008),
                       aes(x=leto, y=stevilo.obsojenih, fill = spol)) +
    geom_bar(position="stack", stat="identity", colour="black")+
    labs(title ="Stevilo obsojenih glede na spol")+
    ylab("Stevilo obsojenih")+xlab("Leto")

#print(graf.spol)
  
#tortni diagram deležev sankcij
#kazni <- aggregate(stevilo.obsojenih ~ sankcija,obsojeni_arhiv,sum)                      
#torta.kazni <- pie(kazni$stevilo.obsojenih, labels = kazni$sankcija, main = "Povprecen delez sankcij")

graf.delez.sankcij <- ggplot(data = aggregate(stevilo.obsojenih ~ sankcija,obsojeni_arhiv,sum),
                        aes(x="", y=stevilo.obsojenih, fill = sankcija)) +
  geom_bar(width = 1, stat="identity", colour="black") + coord_polar("y", start=0)+
  xlab("") + ylab("") + ggtitle("Povprecen delez sankcij") + theme(axis.text.x=element_blank(), panel.grid=element_blank())
#theme_minimal()

#print(graf.delez.sankcij)

  
# Uvozimo zemljevid zemljevid sveta
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

print(zemljevid.umorjeni)

  
zemljevid.zaprti <- ggplot() +
    geom_polygon(data = zaprti2 %>% right_join(zemljevid, by = c("Drzava" = "drzava")),
                 aes(x = long, y = lat, group = group, fill = zaprti), color = "black")+
    xlab("") + ylab("") + ggtitle("Stopnja zaprtih po svetu")
  
print(zemljevid.zaprti)

#uvozimo zemljevid slovenskih občin
obcine <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip",
                          "OB/OB", encoding = "Windows-1250") %>% pretvori.zemljevid()
obcine$OB_UIME <- as.character(obcine$OB_UIME)

#zemljevid stopnje obsojenih
zemljevid.obsojeni <- ggplot() +
  geom_polygon(data = left_join(obcine, obsojeni_po_obcinah2 %>% filter(leto == "2016"), by = c("OB_UIME" = "obcina")),
               aes(x = long, y = lat, group = group, fill = obsojeni), color = "black")+
  scale_fill_gradient2(low = "yellow", mid = "red",
                       high = "brown", midpoint = 6) + 
  xlab("") + ylab("") + ggtitle("Stopnja obsojenih po slovenskih obcinah")

print(zemljevid.obsojeni)

ob <- unique(obcine$OB_UIME)
OB <- unique(obsojeni_po_obcinah2$obcina) #podatki za 212 občin


