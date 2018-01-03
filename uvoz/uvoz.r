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


uvozi.obsojeni_po_obcinah <- function(){
  data <- read_csv2("podatki/obsojeni_po_obcinah.csv", skip = 3,
                    locale = locale(encoding = "Windows-1250"), n_max = 213, na=c("-", "z")) 
  data <- data[-c(1),]
  data <- melt(data, id.vars = "X1", variable.name = "leto")
  colnames(data) <- c("obcina","leto","stevilo obsojenih")
  return(data)
}

obsojeni_po_obcinah <- uvozi.obsojeni_po_obcinah()

#lvls <- levels(brezposelnost$leto)
#krim <- unique(obsojeni_po_obcinah$obcina)
#razlicni <- lvls != krim
#primerjava <- data.frame(lvls, krim, 
#                         stringsAsFactors = FALSE)[razlicni, ]
#rownames(primerjava) <- NULL

uvozi.obsojeni_po_kaznivem_dejanju_arhiv <- function(){
  data <- read_csv2("podatki/arhiv_obsojeni.csv", skip = 3,
                    locale = locale(encoding = "Windows-1250"), n_max = 19)
  return(data)
}

obsojeni_po_kaznivem_dejanju_arhiv <- uvozi.obsojeni_po_kaznivem_dejanju_arhiv()


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


