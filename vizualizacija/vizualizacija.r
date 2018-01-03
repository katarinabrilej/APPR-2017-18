# 3. faza: Vizualizacija podatkov
library(ggplot2)
library(dplyr)

#primerjava stopnje umorjenih in stopnje zaprtih

umorjeni_urejeno <- stevilo_umorjenih[order(stevilo_umorjenih$Stopnja_umorjenih, decreasing=TRUE), ] %>% .[1:10, ]

graf <- ggplot(umorjeni_urejeno) + aes(x = Drzava, y = Stopnja_umorjenih, fill = Drzava) + geom_col() 


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
