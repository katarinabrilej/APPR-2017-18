# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")


# Funkcija, ki uvozi podatke iz datoteke druzine.csv

#uvozi.brezposelnost <- function(){
#  data <- read_csv2("podatki/brezposelnost.csv", skip = 4,
#                    locale = locale(encoding = "Windows-1250"), n_max = 210, na=c("-"))
#  data$X1 <- NULL
#  data <- data[-c(1),]
#  data <- melt(data, id.vars = "X2", variable.name = "leto")
#  colnames(data) <- c("obcina","leto","stopnja brezposelnosti")
#  return(data)
#}

#brezposelnost <- uvozi.brezposelnost()

uvozi.brezposelnost2 <- function(){
  data <- read_csv2("podatki/brezposelnost2.csv", skip = 3,
                    locale = locale(encoding = "Windows-1250"), n_max = 24, na=c("-")) %>% fill(X1) 
  data$X2 <- NULL
  data <- data[-c(1),]
  data <- data[-seq(1,23,2),]
  data <- data[-c(1),]
  data <- melt(data, id.vars = "X1", variable.name = "leto")
  colnames(data) <- c("leto","obcina","brezposelni")
  data$brezposelni <- parse_number(data$brezposelni)
  return(data)
}

brezposelnost2 <- uvozi.brezposelnost2()


#uvozi.obsojeni_po_obcinah <- function(){
#  data <- read_csv2("podatki/obsojeni_po_obcinah.csv", skip = 3,
#                    locale = locale(encoding = "Windows-1250"), n_max = 213, na=c("-", "z")) 
#  data <- data[-c(1),]
#  data <- melt(data, id.vars = "X1", variable.name = "leto")
#  colnames(data) <- c("obcina","leto","stevilo obsojenih")
#  return(data)
#}


#obsojeni_po_obcinah <- uvozi.obsojeni_po_obcinah()

uvozi.obsojeni_po_obcinah2 <- function(){
  data <- read_csv2("podatki/obsojeni_po_obcinah2.csv", skip = 2,
                    locale = locale(encoding = "Windows-1250"), n_max = 12, na=c("-", "z")) 
  data <- data[-c(1),]
  data <- data[-c(11),]
  data <- melt(data, id.vars = "X1", variable.name = "obcina")
  colnames(data) <- c("leto","obcina","obsojeni")
  data$obsojeni <- parse_number(data$obsojeni)
  
  return(data)
}

obsojeni_po_obcinah2 <- uvozi.obsojeni_po_obcinah2()

#občine v obeh tabelah se očitno ujemajo
#lvls <- levels(brezposelnost2$obcina)
#krim <- unique(obsojeni_po_obcinah$obcina)
#razlicni <- lvls != krim


#brezposelnost_in_obsojeni <- brezposelnost2
#brezposelnost_in_obsojeni$obsojeni <- obsojeni_po_obcinah2$obsojeni

brezposelnost_in_obsojeni <- rbind(brezposelnost2 %>% transmute(leto, obcina,
                                                                meritev = "brezposelni",
                                                                stopnja = brezposelni),
                                   obsojeni_po_obcinah2 %>% transmute(leto, obcina,
                                                                      meritev = "obsojeni",
                                                                      stopnja = obsojeni))

obsojeni_po_kaznivem_dejanju_arhiv <- read_csv2("podatki/arhiv_obsojeni.csv", skip = 3,
                    locale = locale(encoding = "Windows-1250"),n_max = 19)
  
  colnames(obsojeni_po_kaznivem_dejanju_arhiv)[2] <- c('zaporna kazen')
  colnames(obsojeni_po_kaznivem_dejanju_arhiv)[18] <- c('denarna kazen')
  colnames(obsojeni_po_kaznivem_dejanju_arhiv)[34] <- c('sodni opomin')
  colnames(obsojeni_po_kaznivem_dejanju_arhiv)[50] <- c('kazen opuscena')
  colnames(obsojeni_po_kaznivem_dejanju_arhiv)[66] <- c('varnostni ukrep brez izreka kazni')
  
obsojeni_arhiv <- obsojeni_po_kaznivem_dejanju_arhiv  
stolpci1 <- data.frame(sankcija = colnames(obsojeni_arhiv) %>% { gsub("X.*", NA, .) },
                        leto = obsojeni_arhiv[2, ] %>% unlist() %>% parse_number(),
                        spol = obsojeni_arhiv[1, ] %>% unlist()) %>% fill(1:2 , 3) %>% apply(1, paste, collapse = "")
  
  stolpci1[1] <- "kaznivo.dejanje"
  colnames(obsojeni_arhiv) <- stolpci1
  
  obsojeni_arhiv <- melt(obsojeni_arhiv[-c(1, 2), ], value.name = "stevilo.obsojenih",
                               id.vars = "kaznivo.dejanje", variable.name = "stolpec") %>%
    mutate(stolpec = parse_character(stolpec)) %>% transmute(leto = stolpec %>% strapplyc("([0-9]+)") %>% unlist() %>% parse_number(),
  sankcija = stolpec %>% strapplyc("^([^0-9]+)") %>% unlist() %>% factor(), kaznivo.dejanje,
  spol = stolpec %>% strapplyc("([^0-9]+)$") %>% unlist() %>% factor(), stevilo.obsojenih)
  

#uvozimo še tabele iz wikipedie
#uvoz tabele s podatki o stopnji zaprtih
 uvozi.zaprti <- function(){
   link <- "https://en.wikipedia.org/wiki/List_of_countries_by_incarceration_rate"
   stran <- html_session(link) %>% read_html()
   tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% html_table(dec = ",") %>% .[[1]] %>% 
     .[-c(1),]
   colnames(tabela) <- c("Drzava", "zaprti")
   tabela$zaprti <- parse_number(tabela$zaprti)
   return(tabela)
 }

zaprti <- uvozi.zaprti()

#uvoz tabele s podatki o stopnji umorov
uvozi.umorjeni <- function(){
  link <- "https://en.wikipedia.org/wiki/List_of_countries_by_intentional_homicide_rate"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% html_table(fill = TRUE, dec = ",") %>%
    .[[2]] %>% .[-c(1),] %>% .[c(1,2)]
  colnames(tabela) <- c("Drzava", "umorjeni")
  tabela$umorjeni <- parse_number(tabela$umorjeni)
  return(tabela)
}

# zadnji dve tabeli združimo v eno
umorjeni <- uvozi.umorjeni()
zaprti_in_umorjeni <- inner_join(zaprti,umorjeni, by = "Drzava")
#skupno$umorjeni_na_zaprtega <- (skupno$Stopnja_umorjenih / skupno$Stopnja_zaprtih) * 100



