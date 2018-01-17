# 3. faza: Vizualizacija podatkov
library(ggplot2)
library(dplyr)

#10 držav z največjih številom umorjenih na 100000 prebivalcev
umorjeni.urejeno <- umorjeni[order(umorjeni$umorjeni, decreasing=TRUE), ] %>% .[1:10, ]
graf1 <- ggplot(umorjeni.urejeno) + aes(x = Drzava, y = umorjeni, fill = Drzava) + geom_col()

#gibanje kriminalitete v ljubljani v obdobju 2006-2015

Ljubljana <- brezposelnost_in_obsojeni[brezposelnost_in_obsojeni$obcina == "Ljubljana",]
graf2 <- ggplot(Ljubljana) + aes(x = leto, y = stopnja, colour = meritev) + geom_line()




