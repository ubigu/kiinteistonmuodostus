# Analyysi pgModeler mallinnustyökalusta

Analyysin tarkoituksena on tarkastella pgModeler -työkalun sopivuutta
tietokannan elinkaaren hallintaan Tampereen Kaupungin paikkatiedon
tietokanta-arkkitehtuurin PostgreSQL-kantatoteutusten ylläpidossa ja
kehityksessä.

Kannan elinkaaren hallinnan osalta olennaiset toiminnallisuudet tämän
työn osalta ovat:
* kantamalli suunnitelaan pgModeler-työkalulla
* työkalun kyky tuottaa muutoslistaus kannan nykytilan ja työn alla olevan
  kantamallin välillä
* mahdollisuus tuottaa muutoslistaus eräajona komentoriviltä
* tunnettujen konfliktien suodatus automaattisesti työkalun
  tuottamista listauksista

Tarkoituksena on hyödyntää tuotettua muutoslistausta
Flyway-työkalun kanssa. Flyway työkalu pystyy hallinnoimaan
inkrementaaliset muutokset tietokantoihin eri tuotantoympäristöjen
välillä.

## Työn suoritus

Työ suoritettiin tonttijakosuunnitelma -tietomallin työstön
yhteydessä. Työssä suunniteltiin fyysinen tietomalli
tonttijakosuunnitelmalle pgModeler-työkalulla loogisen tietomallin pohjalta,
sekä tarkasteltiin
pgModelerin diff -työkalun käyttöä tietomallimuutoksissa.

Tietomallin kehityksen yhteydessä muuttuvaa mallia päivitettiin
kohdekantaan sekä export-toiminnolla että diff-toiminnolla.

Kohdekantoina oli docker:ssa sijaitseva lokaalin kehitysympäristön
sekä Azuressa sijaitseva dev-ympäristön tietokanta.

PostgreSQL oli versiota 12.

pgModelerista oli käytössä Ubuntussa lähdekoodeista käännetty v0.9.3
-versio.

## Oletukset kantamallien päivittämiseksi

Arvio työkalun käytöstä on tehty seuraavien oletusten vallitessa

* kannan käyttäjät hallitaan mallinnustyökalun ulkopuolella
* tietokannan laajennukset hallitaan mallinnustyökalun ulkopuolella
* tietokantaa pystytään päivittämään inkrementaalisilla muutoksilla

## Esimerkkilistaus pgModelerin tuottamista eri kategorian operaatioista

pgModeler luokittelee generoimansa muutokset SQL-kommentteihin. Esimerkkinä lukumäärätietoa pgModelerin tuottamasta listauksesta.
```
grep object tonttijakosuunnitelma.sql | sed 's/^.* type: //'| sort | uniq -c
     41 CONSTRAINT --
      1 DATABASE --
      2 EXTENSION --
      1 ROLE --
      6 SCHEMA --
     43 TABLE --
```
Luokittelun perusteella on myöhemmin mahdollista tehdä suodatustoimintoja.

# pgModeler-työkalun kanssa havaitut ongelmat

## Ylimääräiset operaatiot laajennusten (extension) kanssa

Työkalun diff-ominaisuus tuottaa toisinaan suoritettavaksi
kommenttimuutoksia kantalajennuksiin. Näillä ei ole toiminnallista
merkitystä, mutta käyttöoikeuksien kannalta saattavat aiheuttaa
ongelmia. Päivitystä suorittava ns. normikäyttäjä ei pääse
muokkaamaan laajennusten kommentteja.

Riippuen vertailukannasta, käyttäjälle näkymätön laajennus
(erityisesti "azure") aiheuttaa turhia toimenpiteitä.

### Vaikuttavuus ja ongelman välttäminen

Jatkuvassa kehityksessä voidaan adaptoitua turhiin operaatioihin
laajennuksiin liittyen. Muutokset eivät aiheuta toiminnallista
haittaa.

Voidaan poistaa automaattisesti (jatkuvasti kehitettävällä) suodattimella.

## Kannan käyttäjä halutaan poistaa ja lisätä

Toisinaan kannan käyttäjä halutaan poistaa ja lisätä. Tämä ei ole
tarkoituksenmukaista, eikä suunnitellussa päivitysprosessissa edes
vastaa käyttötarkoitusta.

### Vaikuttavuus ja ongelman välttäminen

Nyt havaitut ongelmat voidaan poistaa täysin suodattimella. Poistetaan
kaikki rooleihin liittyvät osiot SQL:stä.

## Ongelma, jos taulussa on unique-rajoitteita

Ongelma havaitaan, jos taulujen liitosten yhteydessä malli muuttuu ja
liitosten tyyppi vaihtuu. Tälläin uniikkiusrajoitukset poistuvat
osittain.

Seuraavalla testisetupilla tulee ongelmia
* luo kolmen taulun tietomalli (päätaulu, 2*sivutaulu)
* luo päätaulu-sivutaulu -liitos tyyppiä 1:1
* vie kantaan (Export)
* laita merkille UNIQUE -rajoitteet
* muuta taulun ensimmäinen rajoitteista 1:m
* vie diff:llä kantaan
* tarkastele rajoitteita

Viety kokonainen malli export:lla
```
pgmodeler_incremental=# \d tonttijakosuunnitelma
                                     Table "public.tonttijakosuunnitelma"
  Column   |          Type          | Collation | Nullable |                      Default                      
-----------+------------------------+-----------+----------+---------------------------------------------------
 id        | integer                |           | not null | nextval('tonttijakosuunnitelma_id_seq'::regclass)
 nimi      | character varying(100) |           |          | 
 tila_id   | integer                |           |          | 
 tyyppi_id | integer                |           |          | 
Indexes:
    "tonttijakosuunnitelma_pk" PRIMARY KEY, btree (id)
    "tonttijakosuunnitelma_uq" UNIQUE CONSTRAINT, btree (tila_id)
    "tonttijakosuunnitelma_uq1" UNIQUE CONSTRAINT, btree (tyyppi_id)
Foreign-key constraints:
    "tila_fk" FOREIGN KEY (tila_id) REFERENCES tila(id) MATCH FULL ON UPDATE CASCADE ON DELETE SET NULL
    "tyyppi_fk" FOREIGN KEY (tyyppi_id) REFERENCES tyyppi(id) MATCH FULL ON UPDATE CASCADE ON DELETE SET NULL
```

Muutettu ensimmäisen taulun (tila) liitos tyypiksi 1:m. Ajettu
diff-työkalulla muutos tietokantaan.

Huomaa, että UNIQUE -rajoitus on virheellisesti tauluun "tila".

```
pgmodeler_incremental=# \d tonttijakosuunnitelma
                                     Table "public.tonttijakosuunnitelma"
  Column   |          Type          | Collation | Nullable |                      Default                      
-----------+------------------------+-----------+----------+---------------------------------------------------
 id        | integer                |           | not null | nextval('tonttijakosuunnitelma_id_seq'::regclass)
 nimi      | character varying(100) |           |          | 
 tila_id   | integer                |           |          | 
 tyyppi_id | integer                |           |          | 
Indexes:
    "tonttijakosuunnitelma_pk" PRIMARY KEY, btree (id)
    "tonttijakosuunnitelma_uq" UNIQUE CONSTRAINT, btree (tila_id)
Foreign-key constraints:
    "tila_fk" FOREIGN KEY (tila_id) REFERENCES tila(id) MATCH FULL ON UPDATE CASCADE ON DELETE SET NULL
    "tyyppi_fk" FOREIGN KEY (tyyppi_id) REFERENCES tyyppi(id) MATCH FULL ON UPDATE CASCADE ON DELETE SET NULL
```

### Vaikuttavuus ja ongelman välttäminen

Diff-operaation jälkeen tietokanta jää väärään tilaan, kun rajoitteet
eivät päivity oikein. Vaatii manuaalisen tarkastelun diff:n jälkeen ja
tarvittaessa manuaalisen poiston kantaan ja uuden diff:n ajon
pgModelerilla ja diff:n päivityksen tietokantaan.

Pitkällä aikajänteellä on mahdollista että työkalun toiminnallisuus korjataan, ja työkalu osaa itse havaita kyseiset ongelmat.

Toistaiseksi pgModelerista ei ole löytynyt sopivaa valintakombinaatiota, jolla ongelman pystyy yksiselitteisesti välttämään.

Jos tällainen valintakombinaatio jatkossa löytyy, se pitäisi pystyä
välittämään komentorivityökalulle, jotta pienennetään inhimillisen
virheen todennäköisyyttä diff-muutoslistauksen ottamisessa.

Tällaisenaan ongelma aiheuttaa liian suuren manuaalisen työn ja riskin siihen, että automaattinen päivitysketju ei toimi luotettavasti.