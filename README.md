# Kiinteistonmuodostus
Kiinteistönmuodostuksen ja tonttijaon tietomallit

## Tietomallin kuvaus

Tietomalli pyrkii mukailemaan kansallista tietomallia.

## Tietomallin ohjelmistovaatimukset

Tietomalli on suunniteltu käyttäen [pgModeler](https://pgmodeler.io/)
-suunnitteluohjelmaa.

Käytetty pgModeler:n versio on 0.9.3. Mallia on hyödynnetty
PostgreSQL versiolla 12 ja PostGIS versiolla 3.0.

## Tietomallin käyttöönotto

* Avaa tietomalli pgModeler:lla.
* Käytä Export -toimintoa viedäksesi tietomalli PostgreSQL-kantaan.

## Havaintoja inkrementaalisesta päivityksestä

Inkrementaalisen päivityksen tähän asti havaittuja ongelmia on
dokumentoitu [raportissa](pgmodeler_tyokaluna.md).

### Päivitystyötä tukevat suodattimet

Inkrementaalisten päivitysten mahdollistamiseksi filters-hakemistoon
on lisätty joitain käyttöä ja tulevaa automatisointia helpottavia
suodattimia.

Suodattimien tarkoitus on poistaa tuotetusta sql-tallenteesta
tarpeettomia päivityksiä, joita työkalusta itsestään ei voi kytkeä
pois. Näitä ovat esimerkiksi roolin (ROLE) tai laajennuksen (EXTENSION)
tarpeettomat muutokset.

Suodattimien käyttöesimerkki:
```sh
$ cat database_export.sql | ./filter_role.sh
```

Todenna suodattimen toiminta manuaalisella tarkastelulla vaikka näin:
```sh
$ cat database_export.sql | ./filter_role.sh | diff database_export.sql -
```

# Tietokantapalvelun käynnistäminen

Ensimmäisellä kerralla käynnistettäessä aja build:
```
[shell]$ docker-compose build schema_image
```

Palvelu (PostgreSQL 12, PostGIS 3) käynnistetään docker-compose -komennolla:

```
[shell]$ docker-compose up
```

Palvelu käynnistyy porttiin 5432. Kehitysvaiheessa tietokannan kaikki taulut
poistetaan ja luodaan uudet.

NB: kannan uudelleenluonti ei ole tällä hetkellä täysin luotettava.
Toistaiseksi kannattaa ajaa palvelu alas komennolla, mikä siivoaa mountatun volumen:
```
[shell]$ docker-compose down -v
```

Komentorivipääsy tietokantaan onnistuu seuraavasti:

```
[shell]$ PGPASSWORD=docker psql -U docker -h localhost tre_kiintmuod
```

# Ajantasainen kannan skeemakuva

Käynnistyksen yhteydessä luodaan myös kannan skeemakuva. Se löytyy sijainnista:
*output/diagrams/summary/relationships.implied.large.png*

Versionhallintaa varten kuva voidaan kopioida (puoli)automaattisesti
tiedostoksi *images/tonttijako.png* tai *images/tonttijako_kiinteisto.png*

## Kannan skeemakuvan päivittäminen

Kannan skeemakuvan voi päivittää helpommin saatavaksi komennolla:
```
sh update_image.sh
```
Shell-skriptissä yritetään tunnistaa, onko kuva luotu pelkästä tonttijaon
tietomallista, vai onko mukana myös kiinteistön tietomalli.

# Flyway-työkalun käyttö

Kannan migraatioita hallitaan [Flyway](https://flywaydb.org/)-työkalulla.

Migraatioskriptit ovat *flyway/sql* -hakemistossa. Kehitysvaiheessa migraatiot
ovat vain esimerkkejä, kehitysvaiheen jälkeen kannan luontilauseet kirjoitetaan
migraatioskripteiksi.

## Migraatioiden ajaminen

Flyway ajetaan oletusarvoisesti kantapalvelun käynnistämisen yhteydessä.

Jos migraatioita halutaan ajaa manuaalisesti, kun tietokanta on jo käynnissä,
seuraavalla komennolla voi suorittaa migraatiot:
```
docker-compose up flyway
```
Migraatioiden tilan voi tarkastaa seuraavalla komennolla:
```
docker-compose up flyway_info
```
Migraatioiden ajon docker-image ajamalla voi suorittaa seuraavasti
```
docker run --rm -v $(pwd)/flyway/sql:/flyway/sql flyway/flyway \
 -url=jdbc:postgresql://172.17.0.1:5432/tre_kiintmuod \
 -schemas=public -user=docker -password=docker \
 -locations=filesystem:/flyway/sql migrate
```
Kantapalvelimen (lokaali kehitysympäristö docker:ssa) osoitteen voi selvittää seuraavasti:
```
docker network inspect bridge --format='{{range .IPAM.Config}}{{.Gateway}}{{end}}'
```