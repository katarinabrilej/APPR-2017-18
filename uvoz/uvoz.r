# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")


# Funkcija, ki uvozi podatke iz datoteke druzine.csv

uvozi.brezposelnost <- function(){
  data <- read_csv2("podatki/brezposelnost.csv", skip = 4,
                    locale = locale(encoding = "Windows-1250"), n_max = 210, na=c("-"))
  data$X1 <- NULL
  data <- data[-c(1),]
  data <- melt(data, id.vars = "X2", variable.name = "leto")
  colnames(data) <- c("obcina","leto","stopnja brezposelnosti")
  return(data)
}

brezposelnost <- uvozi.brezposelnost()

uvozi.brezposelnost2 <- function(){
  data <- read_csv2("podatki/brezposelnost2.csv", skip = 3,
                    locale = locale(encoding = "Windows-1250"), n_max = 24, na=c("-")) %>% fill(X1) 
  data$X2 <- NULL
  data <- data[-c(1),]
  data <- data[-seq(1,23,2),]
  data <- data[-c(1),]
  data <- melt(data, id.vars = "X1", variable.name = "leto")
  colnames(data) <- c("leto","obcina","stopnja_brezposelnosti")
  return(data)
}

brezposelnost2 <- uvozi.brezposelnost2()


uvozi.obsojeni_po_obcinah <- function(){
  data <- read_csv2("podatki/obsojeni_po_obcinah.csv", skip = 3,
                    locale = locale(encoding = "Windows-1250"), n_max = 213, na=c("-", "z")) 
  data <- data[-c(1),]
  data <- melt(data, id.vars = "X1", variable.name = "leto")
  colnames(data) <- c("obcina","leto","stevilo obsojenih")
  return(data)
}


obsojeni_po_obcinah <- uvozi.obsojeni_po_obcinah()

uvozi.obsojeni_po_obcinah2 <- function(){
  data <- read_csv2("podatki/obsojeni_po_obcinah2.csv", skip = 2,
                    locale = locale(encoding = "Windows-1250"), n_max = 12, na=c("-", "z")) 
  data <- data[-c(1),]
  data <- data[-c(11),]
  data <- melt(data, id.vars = "X1", variable.name = "obcina")
  colnames(data) <- c("leto","obcina","stevilo_obsojenih")
  return(data)
}

obsojeni_po_obcinah2 <- uvozi.obsojeni_po_obcinah2()

#občine v obeh tabelah se očitno ujemajo
lvls <- levels(brezposelnost2$obcina)
obs <- unique(obsojeni_po_obcinah$obcina)
razlicni <- lvls != krim
#primerjava <- data.frame(lvls, obs, 
#                        stringsAsFactors = FALSE)[razlicni, ]
#rownames(primerjava) <- NULL

brezposelnost_in_obsojeni <- brezposelnost2
brezposelnost_in_obsojeni$stevilo_obsojenih <- obsojeni_po_obcinah2$stevilo_obsojenih

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
  
  stolpci1[1] <- "kaznivo_dejanje"
  colnames(obsojeni_arhiv) <- stolpci1
  
  obsojeni_arhiv <- melt(obsojeni_arhiv[-c(1, 2), ], value.name = "stevilo.obsojenih",
                               id.vars = "kaznivo_dejanje", variable.name = "stolpec") %>%
    mutate(stolpec = parse_character(stolpec)) %>% transmute(leto = stolpec %>% strapplyc("([0-9]+)") %>% unlist() %>% parse_number(),
  sankcija = stolpec %>% strapplyc("^([^0-9]+)") %>% unlist() %>% factor(), kaznivo_dejanje,
  spol = stolpec %>% strapplyc("([^0-9]+)$") %>% unlist() %>% factor(), stevilo.obsojenih)
  

#uvozimo še tabele iz wikipedie
#uvoz tabele s podatki o stopnji zaprtih
 uvozi.stevilo_zaprtih <- function(){
   link <- "https://en.wikipedia.org/wiki/List_of_countries_by_incarceration_rate"
   stran <- html_session(link) %>% read_html()
   tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% html_table(dec = ",") %>% .[[2]] %>% 
     .[-c(1),]
   colnames(tabela) <- c("Drzava", "Stopnja_zaprtih")
   tabela$Stopnja_zaprtih <- parse_number(tabela$Stopnja_zaprtih)
   return(tabela)
 }

stevilo_zaprtih <- uvozi.stevilo_zaprtih()

#uvoz tabele s podatki o stopnji umorov
uvozi.stevilo_umorjenih <- function(){
  link <- "https://en.wikipedia.org/wiki/List_of_countries_by_intentional_homicide_rate"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% html_table(fill = TRUE, dec = ",") %>%
    .[[2]] %>% .[-c(1),] %>% .[c(1,2)]
  colnames(tabela) <- c("Drzava", "Stopnja_umorjenih")
  tabela$Stopnja_umorjenih <- parse_number(tabela$Stopnja_umorjenih)
  return(tabela)
}

# zadnji dve tabeli združimo v eno
stevilo_umorjenih <- uvozi.stevilo_umorjenih()
skupno <- inner_join(stevilo_zaprtih,stevilo_umorjenih, by = "Drzava")
skupno$umorjeni_na_zaprtega <- (skupno$Stopnja_umorjenih / skupno$Stopnja_zaprtih) * 100


