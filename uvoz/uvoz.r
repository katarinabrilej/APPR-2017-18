# 2. faza: Uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")


# Funkcija, ki uvozi podatke iz datoteke druzine.csv

uvozi.brezposelnost <- function(){
  data <- read_csv2("podatki/brezposelnost.csv", skip = 2,
                    locale = locale(encoding = "Windows-1250"), n_max = 193)
  colnames(data) <- c("obcina","stevilo")
  return(data)
}

brezposelnost <- uvozi.brezposelnost()

brezposelnost["leto"] <- NA
brezposelnost$leto <- rep(2015, 193)

uvozi.obsojeni_po_obcinah <- function(){
  data <- read_csv2("podatki/obsojeni_po_obcinah.csv", skip = 2,
                    locale = locale(encoding = "Windows-1250"), n_max = 213) 
  #colnames(data) <- c("obcina","leto","stevilo")
  return(data)
}

obsojeni_po_obcinah <- uvozi.obsojeni_po_obcinah()


