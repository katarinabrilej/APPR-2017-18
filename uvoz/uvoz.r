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

uvozi.obsojeni_po_kaznivem_dejanju_arhiv <- function(){
  data <- read_csv2("podatki/arhiv_obsojeni.csv", skip = 3,
                    locale = locale(encoding = "Windows-1250"), n_max = 19)
  return(data)
}

obsojeni_po_kaznivem_dejanju_arhiv <- uvozi.obsojeni_po_kaznivem_dejanju_arhiv()

uvozi.obsojene_pravne_osebe <- function(){
  data <- read_csv2("podatki/obsojene_pravne_osebe.csv", skip = 2,
                    locale = locale(encoding = "Windows-1250"), n_max = 1)
  data <- melt(data, id.vars = "X1", variable.name = "leto", value.name = "stevilo obsojenih pravnih oseb")
  data$X1 <- NULL
  return(data)
}

obsojene_pravne_osebe <-uvozi.obsojene_pravne_osebe()

uvozi.ovadene_pravne_osebe <- function(){
  data <- read_csv2("podatki/ovadene_pravne_osebe.csv", skip = 4,
                    locale = locale(encoding = "Windows-1250"), n_max = 1)
  data <- melt(data, id.vars = "X1", variable.name = "leto", value.name = "stevilo ovadenih pravnih oseb")
  data$X1 <- NULL
  data <- data[-c(1),]
  return(data)
}

ovadene_pravne_osebe <-uvozi.ovadene_pravne_osebe()

uvozi.obsojene_polnoletne_osebe <- function(){
  data <- read_csv2("podatki/obsojene_polnoletne_osebe.csv", skip = 4,
                    locale = locale(encoding = "Windows-1250"), n_max = 2)
  data <- data[-c(1),]
  data <- melt(data, id.vars = "X1", variable.name = "leto", value.name = "stevilo obsojenih polnoletnih fizicnih oseb")
  data <- data[-c(1),]
  data$X1 <- NULL
  return(data)
}

obsojene_polnoletne_osebe <-uvozi.obsojene_polnoletne_osebe()

uvozi.ovadene_polnoletne_osebe <- function(){
  data <- read_csv2("podatki/ovadene_polnoletne_osebe.csv", skip = 4,
                    locale = locale(encoding = "Windows-1250"), n_max = 1)
  data <- melt(data, id.vars = "X1", variable.name = "leto", value.name = "stevilo ovadenih polnoletnih fizicnih oseb")
  data$X1 <- NULL
  return(data)
}

ovadene_polnoletne_osebe <-uvozi.ovadene_polnoletne_osebe()

skupno1 <- merge(ovadene_polnoletne_osebe, obsojene_polnoletne_osebe, by = "leto")
skupno2 <- merge(ovadene_pravne_osebe, obsojene_pravne_osebe, by = "leto")
skupno <- merge(skupno2, skupno1, by = "leto")

#uvozimo še tabele iz wikipedie



