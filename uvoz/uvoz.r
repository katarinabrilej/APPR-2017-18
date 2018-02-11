# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")


# Funkcija, ki uvozi podatke iz datoteke druzine.csv


uvozi.brezposelnost2 <- function(){
  data <- read_csv2("podatki/brezposelnost2.csv", skip = 3,
                    locale = locale(encoding = "Windows-1250"), n_max = 25, na=c("-")) %>% fill(X1) 
  data$X2 <- NULL
  data <- data[-c(1),]
  data <- data[-seq(1,23,2),]
  colnames(data)[1] <- "leto"
  data <- data[data$leto >= 2006,]
  data <- melt(data, id.vars = "leto", variable.name = "obcina", value.name = "brezposelni")
  data$brezposelni <- parse_number(data$brezposelni)
  return(data)
}

brezposelnost2 <- uvozi.brezposelnost2()



uvozi.obsojeni_po_obcinah2 <- function(){
  data <- read_csv2("podatki/obsojeni_po_obcinah2.csv", skip = 2,
                    locale = locale(encoding = "Windows-1250"), n_max = 12, na=c("-", "z")) 
  data <- data[-c(1),]
  colnames(data)[1] <- "leto"
  data <- melt(data, id.vars = "leto", variable.name = "obcina", value.name = "obsojeni")
  data$obsojeni <- parse_number(data$obsojeni)
  
  return(data)
}

obsojeni_po_obcinah2 <- uvozi.obsojeni_po_obcinah2()


#brezposelnost_in_obsojeni <- brezposelnost2
#brezposelnost_in_obsojeni$obsojeni <- obsojeni_po_obcinah2$obsojeni

brezposelnost_in_obsojeni <- rbind(brezposelnost2 %>% transmute(leto, obcina,
                                                                meritev = "brezposelni",
                                                                stopnja = brezposelni),
                                   obsojeni_po_obcinah2 %>% transmute(leto, obcina,
                                                                      meritev = "obsojeni",
                                                                      stopnja = obsojeni))

obsojeni_po_kaznivem_dejanju_arhiv <- read_csv2("podatki/arhiv_obsojeni.csv", skip = 3,
                    locale = locale(encoding = "Windows-1250"),n_max = 18)
  
  colnames(obsojeni_po_kaznivem_dejanju_arhiv)[2] <- c('zaporna kazen')
  colnames(obsojeni_po_kaznivem_dejanju_arhiv)[18] <- c('denarna kazen')
  colnames(obsojeni_po_kaznivem_dejanju_arhiv)[34] <- c('sodni opomin')
  colnames(obsojeni_po_kaznivem_dejanju_arhiv)[50] <- c('kazen opuscena')
  colnames(obsojeni_po_kaznivem_dejanju_arhiv)[66] <- c('varnostni ukrep brez izreka kazni')


  

  
obsojeni_arhiv <- obsojeni_po_kaznivem_dejanju_arhiv 
obsojeni_arhiv$X1 <- sub(".*? (.+)", "\\1", obsojeni_arhiv$X1)

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
  tabela <- with(tabela,  tabela[order(Drzava) , ])
  return(tabela)
}

# zadnji dve tabeli združimo v eno
umorjeni <- uvozi.umorjeni()
zaprti_in_umorjeni <- inner_join(zaprti,umorjeni, by = "Drzava")



