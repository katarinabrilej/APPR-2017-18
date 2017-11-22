# Analiza podatkov s programom R, 2017/18

avtor: Katarina Brilej

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Analiza kriminalitete

V svojem projektu bom analizirala povezavo med stopnjo brezposelnosti in kriminaliteto v slovenskih občinah, primerjala bom tudi katere vrste kriminalitete so najpogostejše po regijah. Prav tako bom analizirala različne vrste kriminalitete skozi leta in jih primerjala s spolom storilcev in sankcijo, ki so je bili deležni.
V nadaljevanju bom primerjala tudi razmerje med številom ovadenih in obsojenih pri fizičnih in pravnih osebah (kje je pravni sistem uspešnejši). Na koncu pa bom slovenske podatke o številu umorjenih in zaprtih primerjala s svetovnimi. 

### Tabele:
1. tabela: analiza povezave med  brezposelnostjo in kriminaliteto (različne vrste) po slovenskih občinah
2. tabela: analiza različnih vrst kriminalitete v Sloveniji skozi leta + primerjava glede na spol in glavno sankcijo 
3. tabela: primerjava razmerja med ovadenimi in obsojenimi za fizične in pravne osebe skozi leta
4. tabela: primerjava števila zaprtih in umorjenih po svetu

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

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
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
