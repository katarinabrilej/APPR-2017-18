# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")


# Funkcija, ki uvozi podatke iz datoteke druzine.csv

#tabela s podatki o stopnji brezposelnosti v slovenskih občinah med leti 2006 in 2016
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

#tabela s podatki o stopnji obsojenih v slovenskih občinah med leti 2006 in 2016
uvozi.obsojeni_po_obcinah2 <- function(){
  data <- read_csv2("podatki/obsojeni_po_obcinah2.csv", skip = 2,
                    locale = locale(encoding = "Windows-1250"), n_max = 12, na=c("-", "z")) 
  data <- data[-c(1),]
  colnames(data)[1] <- "leto"
  data <- melt(data, id.vars = "leto", variable.name = "obcina", value.name = "obsojeni")
  data$obsojeni <- parse_number(data$obsojeni)
  data$obcina <- as.character(data$obcina)
  
  return(data)
}

obsojeni_po_obcinah2 <- uvozi.obsojeni_po_obcinah2()
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Ankaran/Ancarano"] <- "Ankaran"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Izola/Isola"] <- "Izola"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Koper/Capodistria"] <- "Koper"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Dobrova - Polhov Gradec"] <- "Dobrova-Polhov Gradec"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Dobrovnik/Dobronak"] <- "Dobrovnik"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Gorenja vas - Poljane"] <- "Gorenja vas-Poljane"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Lendava/Lendva"] <- "Lendava"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Hrpelje - Kozina"] <- "Hrpelje-Kozina"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Log - Dragomer"] <- "Log-Dragomer"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Miren - Kostanjevica"] <- "Miren-Kostanjevica"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Mokronog - Trebelno"] <- "Mokronog-Trebelno"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Sveta Trojica v Slov. goricah"] <- "Sveta Trojica v Slovenskih goricah"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == "Sveti Jurij v Slov. goricah"] <- "Sveti Jurij v Slovenskih goricah"

hodos <- "Hodoš/Hodos"
Encoding(hodos) <- "UTF-8"
sempeter <- "Šempeter - Vrtojba"
Encoding(sempeter) <- "UTF-8"
race <- "Rače - Fram"
Encoding(race) <- "UTF-8"
slivnica <- "Hoče - Slivnica"
Encoding(slivnica) <- "UTF-8"
rence <- "Renče - Vogrsko"
Encoding(rence) <- "UTF-8"

obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == hodos] <- "Hodoš"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == sempeter] <- "Šempeter"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == race] <- "Rače-Fram"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == slivnica] <- "Hoče-Slivnica"
obsojeni_po_obcinah2$obcina[obsojeni_po_obcinah2$obcina == rence] <- "Renče-Vogrsko"



#združeni tabeli o brezposelnih in obsojenih
brezposelnost_in_obsojeni2 <- brezposelnost2
brezposelnost_in_obsojeni2$obsojeni <- obsojeni_po_obcinah2$obsojeni
brezposelnost_in_obsojeni2$obcina <- as.character(brezposelnost_in_obsojeni2$obcina)
brezposelnost_in_obsojeni2$obcina[brezposelnost_in_obsojeni2$obcina == "Lendava/Lendva"] <- "Lendava"

brezposelnost_in_obsojeni <- rbind(brezposelnost2 %>% transmute(leto, obcina,
                                                                meritev = "brezposelni",
                                                                stopnja = brezposelni),
                                   obsojeni_po_obcinah2 %>% transmute(leto, obcina,
                                                                      meritev = "obsojeni",
                                                                      stopnja = obsojeni))

#podatki o obsojenih glede na spol, sankcijo in kaznivo dejanje
obsojeni_arhiv <- read_csv2("podatki/arhiv_obsojeni.csv", skip = 3,
                    locale = locale(encoding = "Windows-1250"),n_max = 18)
  
  colnames(obsojeni_arhiv)[2] <- c('zaporna kazen')
  colnames(obsojeni_arhiv)[18] <- c('denarna kazen')
  colnames(obsojeni_arhiv)[34] <- c('sodni opomin')
  colnames(obsojeni_arhiv)[50] <- c('kazen opuscena')
  colnames(obsojeni_arhiv)[66] <- c('varnostni ukrep brez izreka kazni')


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
  
  obsojeni_arhiv$stevilo.obsojenih <- parse_number(obsojeni_arhiv$stevilo.obsojenih)
  

#uvozimo še tabele iz wikipedie
#tabela s podatki o stopnji umorjenih po svetu
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
zaprti$Drzava[zaprti$Drzava == "Timor-Leste (formerly East Timor)"] <- "Timor"
zaprti$Drzava[zaprti$Drzava == "Myanmar (formerly Burma)"] <- "Myanmar"
zaprti$Drzava[zaprti$Drzava == "Moldova (Republic of)"] <- "Moldova"
zaprti$Drzava[zaprti$Drzava == "Macau (China)"] <- "Macao"
zaprti$Drzava[zaprti$Drzava == "Micronesia, Federated States of"] <- "Federated States of Micronesia"
zaprti$Drzava[zaprti$Drzava == "Kosovo/Kosova"] <- "Kosovo"
zaprti$Drzava[zaprti$Drzava == "Ireland, Republic of"] <- "Ireland"
zaprti$Drzava[zaprti$Drzava == "United Kingdom: England and Wales"] <- "United Kingdom"
zaprti$Drzava[zaprti$Drzava == "United Kingdom: Northern Ireland"] <- "United Kingdom"
zaprti$Drzava[zaprti$Drzava == "United Kingdom: Scotland"] <- "United Kingdom"
zaprti$Drzava[zaprti$Drzava == "Russian Federation"] <- "Russia"
zaprti$Drzava[zaprti$Drzava == "Democratic Republic of Congo (formerly Zaire)"] <- "Democratic Republic of the Congo"
zaprti$Drzava[zaprti$Drzava == "Cote d'Ivoire"] <- "Ivory Coast"
zaprti$Drzava[zaprti$Drzava == "Congo (Brazzaville)"] <- "Congo"
zaprti$Drzava[zaprti$Drzava == "Cape Verde (Cabo Verde)"] <- "Cape Verde"
zaprti$Drzava[zaprti$Drzava == "Bosnia and Herzegovina: Federation"] <- "Bosnia and Herzegovina"
zaprti$Drzava[zaprti$Drzava == "Bosnia and Herzegovina: Republika Srpska"] <- "Bosnia and Herzegovina"
zaprti$Drzava[zaprti$Drzava == "Samoa (formerly Western Samoa)"] <- "Samoa"
zaprti$Drzava[zaprti$Drzava == "Republic of (South) Korea"] <- "South Korea"
zaprti$Drzava[zaprti$Drzava == "Puerto Rico (U.S.)"] <- "Puerto Rico (US)"
zaprti$Drzava[zaprti$Drzava == "Republic of Guinea"] <- "Guinea"
zaprti$Drzava[zaprti$Drzava == "Cyprus (Republic of)"] <- "Cyprus"

zaprti2 <- zaprti
zaprti2 <- with(zaprti2,  zaprti2[order(Drzava) , ])
rownames(zaprti2) <- NULL

vsota <- sum(zaprti2[208:210,]$zaprti)
zaprti2 <- zaprti2[-c(209:210),]
zaprti2[208, 2] <- vsota

vsota2 <- sum(zaprti2[26:27,]$zaprti)
zaprti2 <- zaprti2[-c(27),]
zaprti2[26, 2] <- vsota2

rownames(zaprti2) <- NULL


#uvoz tabele s podatki o stopnji umorov
uvozi.umorjeni <- function(){
  link <- "https://en.wikipedia.org/wiki/List_of_countries_by_intentional_homicide_rate"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% html_table(fill = TRUE, dec = ",") %>%
    .[[2]] %>% .[-c(1),] %>% .[c(1,2)]
  colnames(tabela) <- c("Drzava", "umorjeni")
  tabela <- with(tabela,  tabela[order(Drzava) , ])
  tabela$umorjeni <- parse_number(tabela$umorjeni)
  return(tabela)
}

umorjeni2 <- uvozi.umorjeni()
umorjeni2$Drzava[umorjeni2$Drzava == "Micronesia, Fed. Sts."] <- "Federated States of Micronesia"
umorjeni2$Drzava[umorjeni2$Drzava == "British Virgin Islands (UK)"] <- "Virgin Islands (United Kingdom)"
umorjeni2$Drzava[umorjeni2$Drzava == "United States Virgin Islands (US)"] <- "Virgin Islands (U.S.)"

umorjeni2<- with(umorjeni2,  umorjeni2[order(Drzava) , ])
rownames(umorjeni2) <- NULL

# zadnji dve tabeli združimo v eno
zaprti_in_umorjeni <- inner_join(zaprti2,umorjeni2, by = "Drzava")



