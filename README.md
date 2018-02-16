# Analiza podatkov s programom R, 2017/18

## Analiza kriminalitete

Avtor: Katarina Brilej


V svojem projektu bom analizirala različne vrste kriminalitete skozi leta v Sloveniji in jih primerjala s spolom storilcev in sankcijo, ki so je bili deležni. Poskušala bom tudi najti povezavo med stopnjo brezposelnosti in kriminaliteto v slovenskih občinah. Na koncu pa bom analizirala še svetovne podatki o stopnji umorjenih in zaprtih.  

### Viri:

Podatki so s Statističnega urada Slovenije in Wikipedije:

* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/01_statistika_toz_sodisc/10_13722_obsojene_kazalniki/10_13722_obsojene_kazalniki.asp
* http://pxweb.stat.si/pxweb/Dialog/Saveshow.asp
* https://en.wikipedia.org/wiki/List_of_countries_by_incarceration_rate
* https://en.wikipedia.org/wiki/List_of_countries_by_intentional_homicide_rate
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/05_statistika_pravne_osebe/07_13736_ovadene_prav_osebe/07_13736_ovadene_prav_osebe.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/01_statistika_toz_sodisc/01_13601_ovadene_poln_osebe/01_13601_ovadene_poln_osebe.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/01_statistika_toz_sodisc/03_13603_obsojene_poln_osebe/03_13603_obsojene_poln_osebe.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/05_statistika_pravne_osebe/15_13756_obsojene_prav_osebe/15_13756_obsojene_prav_osebe.asp

### Tabele:

Uvozila sem podatke o brezposelnih in obsojenih v Sloveniji v obliki CSV s Statističnega urada ter podatke o umorjenih in zaprtih 
po državah sveta v obliki HTML z Wikipedije. Podatke imam v treh razpredelnicah v obliki *tidy data*.

1. tabela: podatki o številu obsojenih glede na spol, kaznivo dejanje ter sankcijo, ki so je bili deležni
* stolpci: leto, sankcija, kaznivo dejanje, spol, stevilo obsojenih
2. tabela: podatki o številu brezposelnih in obsojenih na 1000 prebivalcev po slovenskih občinah
* stolpci: leto, obcina, meritev, stopnja
3. tabela: podatki o številu zaprtih in umorjenih po državah sveta
* stolpci: država, zaprti, umorjeni

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poro?ila
* `rmarkdown` - za prevajanje poro?ila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
