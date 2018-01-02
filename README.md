# Analiza podatkov s programom R, 2017/18

avtor: Katarina Brilej

Repozitorij z gradivi pri predmetu APPR v �tudijskem letu 2017/18

## Analiza kriminalitete

V svojem projektu bom analizirala povezavo med stopnjo brezposelnosti in kriminaliteto v slovenskih ob�inah, primerjala bom tudi katere vrste kriminalitete so najpogostej�e po regijah. Prav tako bom analizirala razli�ne vrste kriminalitete skozi leta in jih primerjala s spolom storilcev in sankcijo, ki so je bili dele�ni.
V nadaljevanju bom primerjala tudi razmerje med �tevilom ovadenih in obsojenih pri fizi�nih in pravnih osebah (kje je pravni sistem uspe�nej�i). Na koncu pa bom slovenske podatke o �tevilu umorjenih in zaprtih primerjala s svetovnimi. 

### Tabele:
1. tabela: brezposelnost in kriminaliteta (razli�ne vrste) po slovenskih ob�inah
* stolpci: stopnja kriminalitete, stopnja brezposelnosti, ob�ina, leto
2. tabela: razli�ne vrste kriminalitete v Sloveniji skozi leta glede na spol in glavno sankcijo 
* stolpci: vrste kriminalitete, leto, spol, glavna sankcija
3. tabela: razmerja med ovadenimi in obsojenimi za fizi�ne in pravne osebe skozi leta
* stolpci: fizi�ne ovadene, pravne ovadene, fizi�ne obsojene, pravne obsojene, leto
4. tabela: �tevilo zaprtih in umorjenih po svetu
* stolpci: dr???ava, �tevilo zaprtih, �tevilo umorjenih

### Viri:
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/01_statistika_toz_sodisc/10_13722_obsojene_kazalniki/10_13722_obsojene_kazalniki.asp
* http://pxweb.stat.si/pxweb/Dialog/Saveshow.asp
* https://en.wikipedia.org/wiki/List_of_countries_by_incarceration_rate
* https://en.wikipedia.org/wiki/List_of_countries_by_intentional_homicide_rate
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/05_statistika_pravne_osebe/07_13736_ovadene_prav_osebe/07_13736_ovadene_prav_osebe.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/01_statistika_toz_sodisc/01_13601_ovadene_poln_osebe/01_13601_ovadene_poln_osebe.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/01_statistika_toz_sodisc/03_13603_obsojene_poln_osebe/03_13603_obsojene_poln_osebe.asp
* http://pxweb.stat.si/pxweb/Database/Dem_soc/13_kriminaliteta/05_statistika_pravne_osebe/15_13756_obsojene_prav_osebe/15_13756_obsojene_prav_osebe.asp

## Program

Glavni program in poro�ilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in �etrti fazi projekta:

* obdelava, uvoz in �i��enje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti slede�e pakete za R:

* `knitr` - za izdelovanje poro�ila
* `rmarkdown` - za prevajanje poro�ila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgo��evalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (�i��enje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz �umnikov (neobvezno)
