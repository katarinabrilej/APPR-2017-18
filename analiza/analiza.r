# 4. faza: Analiza podatkov

#predvidevanje gibanja 
podatki <- brezposelnost_in_obsojeni2 %>% filter(obsojeni < 10 & brezposelni < 25)

ggplot(podatki, aes(x = brezposelni, y = obsojeni)) + 
  geom_point() + geom_smooth(method=lm, se = FALSE) 

# izračun modela
fit <- lm(obsojeni ~ brezposelni, data=podatki)
summary(fit)

# primer predikcije
novi.brezposelni <- data.frame(brezposelni=c(25, 30,35))
predict(fit, novi.brezposelni)
napoved <- novi.brezposelni %>% mutate(obsojeni=predict(fit, .))

# izris napovedi
ggplot(podatki, aes(x = brezposelni, y = obsojeni)) + 
  geom_point(shape=1) + 
  geom_smooth(method=lm) +
  geom_point(data=napoved, aes(x = brezposelni, y = obsojeni), color='red', size=3)

# dodajanje enačbe kot anotacije  
enacba <- function(x) {
  lm_coef <- list(a = round(coef(x)[1], digits = 2),
                  b = round(coef(x)[2], digits = 2),
                  r2 = round(summary(x)$r.squared, digits = 2));
  lm_eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(R)^2~"="~r2,lm_coef)
  as.character(as.expression(lm_eq));                 
}

enacba(fit)

ggplot(podatki, aes(x = brezposelni, y = obsojeni)) + 
  geom_point(shape=1) + 
  geom_smooth(method=lm) +
  geom_point(data=napoved, aes(x = brezposelni, y = obsojeni), color='red', size=3) +
  annotate("text", x = 20, y = 10, label = enacba(fit), parse = TRUE) +
  ggtitle('Linearna regresija') + 
  theme_bw()

