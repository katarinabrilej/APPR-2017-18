# 3. faza: Vizualizacija podatkov
library(ggplot2)
library(dplyr)

#primerjava stopnje umorjenih in stopnje zaprtih

umorjeni_urejeno <- stevilo_umorjenih[order(stevilo_umorjenih$Stopnja_umorjenih, decreasing=TRUE), ] %>% .[1:10, ]

graf1 <- ggplot(umorjeni_urejeno) + aes(x = Drzava, y = Stopnja_umorjenih, fill = Drzava) + 
  aes(x = Drzava, y = Stopnja_umorjenih, fill = Drzava)+ geom_col()
print(graf1)

#gibanje kriminalitete v ljubljani v obdobju 2006-2015

Ljubljana <- brezposelnost_in_obsojeni[brezposelnost_in_obsojeni$obcina == "Ljubljana",]
Ljubljana$stopnja_brezposelnosti <- parse_number(Ljubljana$stopnja_brezposelnosti)
Ljubljana$stevilo_obsojenih <- parse_number(Ljubljana$stevilo_obsojenih)
graf2 <- ggplot(Ljubljana) + aes(x = leto, y = stopnja_brezposelnosti, group = 1) + geom_line()
print(graf2)

#graf3 <- ggplot(Ljubljana, aes(leto)) + geom_line(aes(y = stevilo_obsojenih, colour = "stevilo_obsojenih")) +
#  geom_line(aes(y = stevilo_obsojenih, colour = "stopnja_brezposelnosti"))
#print(graf3)

lj <- melt(Ljubljana[, c(1,3,4)], id = "leto")

graf3 <- ggplot(data=test_data_long,
       aes(x=leto, y=value, colour=variable)) +
  geom_line()

print(graf3)
  

# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip",
                             "OB/OB", encoding = "Windows-1250")
levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
  { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels = levels(obcine$obcina))
zemljevid <- pretvori.zemljevid(zemljevid)

# Izračunamo povprečno velikost družine
povprecja <- druzine %>% group_by(obcina) %>%
  summarise(povprecje = sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))

