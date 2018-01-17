# 3. faza: Vizualizacija podatkov
library(ggplot2)
library(dplyr)

#10 držav z največjih številom umorjenih na 100000 prebivalcev

umorjeni.urejeno <- umorjeni[order(umorjeni$umorjeni, decreasing=TRUE), ] %>% .[1:10, ]
graf1 <- ggplot(umorjeni.urejeno) + aes(x = Drzava, y = umorjeni, fill = Drzava) + geom_col()

#gibanje kriminalitete v ljubljani v obdobju 2006-2015

Ljubljana <- brezposelnost_in_obsojeni[brezposelnost_in_obsojeni$obcina == "Ljubljana",]
graf2 <- ggplot(Ljubljana) + aes(x = leto, y = stopnja, colour = meritev) + geom_line()


#lj <- melt(Ljubljana[, c(1,3,4)], id = "leto")
#graf3 <- ggplot(data=lj,
#       aes(x=leto, y=value, colour=variable)) +
#  geom_line()

  

# Uvozimo zemljevid.
#zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip",
#                             "OB/OB", encoding = "Windows-1250")
#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
#  { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels = levels(obcine$obcina))
#zemljevid <- pretvori.zemljevid(zemljevid)


