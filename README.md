# Analiza podatkov s programom R, 2017/18

avtor: Katarina Brilej

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Analiza kriminalitete

<<<<<<< HEAD
V svojem projektu bom analizirala povezavo med stopnjo brezposelnosti in kriminaliteto v slovenskih obèinah, primerjala bom tudi katere vrste kriminalitete so najpogostejše po regijah. Prav tako bom analizirala razliène vrste kriminalitete skozi leta in jih primerjala s spolom storilcev in sankcijo, ki so je bili deležni.
V nadaljevanju bom primerjala tudi razmerje med številom ovadenih in obsojenih pri fiziènih in pravnih osebah (kje je pravni sistem uspešnejši). Na koncu pa bom slovenske podatke o številu umorjenih in zaprtih primerjala s svetovnimi. 
=======
V svojem projektu bom analizirala povezavo med stopnjo brezposelnosti in kriminaliteto v slovenskih obÄinah, primerjala bom tudi katere vrste kriminalitete so najpogostejÅ¡e po regijah. Prav tako bom analizirala razliÄne vrste kriminalitete skozi leta in jih primerjala s spolom storilcev in sankcijo, ki so je bili deleÅ¾ni.
V nadaljevanju bom primerjala tudi razmerje med Å¡tevilom ovadenih in obsojenih pri fiziÄnih in pravnih osebah (kje je pravni sistem uspeÅ¡nejÅ¡i). Na koncu pa bom slovenske podatke o Å¡tevilu umorjenih in zaprtih primerjala s svetovnimi. 
>>>>>>> 17cd1242a98bda3bd589fdc55af1d8f6465489b1

### Tabele:
1. tabela: brezposelnost in kriminaliteta (razliène vrste) po slovenskih obèinah
* stolpci: stopnja kriminalitete, stopnja brezposelnosti, obèina, leto
2. tabela: razliène vrste kriminalitete v Sloveniji skozi leta glede na spol in glavno sankcijo 
* stolpci: vrste kriminalitete, leto, spol, glavna sankcija
3. tabela: razmerja med ovadenimi in obsojenimi za fiziène in pravne osebe skozi leta
* stolpci: fiziène ovadene, pravne ovadene, fiziène obsojene, pravne obsojene, leto
4. tabela: število zaprtih in umorjenih po svetu
* stolpci: dr???ava, število zaprtih, število umorjenih

### Viri:
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/01_statistika_toz_sodisc/10_13722_obsojene_kazalniki/10_13722_obsojene_kazalniki.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/07_trg_dela/90_arhivski_podatki/03_akt_preb_let_arhiv/03_akt_preb_let_arhiv.asp
* https://en.wikipedia.org/wiki/List_of_countries_by_incarceration_rate
* https://en.wikipedia.org/wiki/List_of_countries_by_intentional_homicide_rate
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/05_statistika_pravne_osebe/07_13736_ovadene_prav_osebe/07_13736_ovadene_prav_osebe.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/01_statistika_toz_sodisc/01_13601_ovadene_poln_osebe/01_13601_ovadene_poln_osebe.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/01_statistika_toz_sodisc/03_13603_obsojene_poln_osebe/03_13603_obsojene_poln_osebe.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/05_statistika_pravne_osebe/15_13756_obsojene_prav_osebe/15_13756_obsojene_prav_osebe.asp

## Program

Glavni program in poroèilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in èetrti fazi projekta:

* obdelava, uvoz in èišèenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeèe pakete za R:

* `knitr` - za izdelovanje poroèila
* `rmarkdown` - za prevajanje poroèila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgošèevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (èišèenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
