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

Palvelu käynnistyy porttiin 5432.

Komentorivipääsy tietokantaan onnistuu seuraavasti:

```
[shell]$ PGPASSWORD=docker psql -U docker -h localhost dev_alueraja_db
```
