# Analiza podatkov s programom R, 2017/18

avtor: Katarina Brilej

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Analiza kriminalitete

V svojem projektu bom analizirala povezavo med stopnjo brezposelnosti in kriminaliteto v slovenskih občinah, primerjala bom tudi katere vrste kriminalitete so najpogostejše po regijah. Prav tako bom analizirala različne vrste kriminalitete skozi leta in jih primerjala s spolom storilcev in sankcijo, ki so je bili deležni.
Na koncu pa bom slovenske podatke o številu umorjenih in zaprtih primerjala s svetovnimi. 

### Tabele:
1. tabela: brezposelnost in kriminaliteta (različne vrste) po slovenskih občinah
* stolpci: stopnja kriminalitete, stopnja brezposelnosti, občina, leto
2. tabela: različne vrste kriminalitete v Sloveniji skozi leta glede na spol in glavno sankcijo 
* stolpci: vrste kriminalitete, leto, spol, glavna sankcija
3. tabela: število zaprtih in umorjenih po svetu
* stolpci: država, število zaprtih, število umorjenih

### Viri:
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/01_statistika_toz_sodisc/10_13722_obsojene_kazalniki/10_13722_obsojene_kazalniki.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/07_trg_dela/90_arhivski_podatki/03_akt_preb_let_arhiv/03_akt_preb_let_arhiv.asp
* https://en.wikipedia.org/wiki/List_of_countries_by_incarceration_rate
* https://en.wikipedia.org/wiki/List_of_countries_by_intentional_homicide_rate

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
