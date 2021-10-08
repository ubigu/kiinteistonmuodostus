# Kiinteistön ja tonttijaon tietomallit

Kiinteistön ja tonttijaon tietomallien kantatason toteutus.

## Tietomallin kuvaus

Tietomalli pyrkii mukailemaan kansallista tietomallia.

### Tonttijaon looginen tietomalli

[Tietomalli](logical_model/tonttijaon_looginen_tietomalli_30082021.png) liitteenä

### Kiinteistön looginen tietomalli

[Tietomalli](logical_model/kiinteiston_looginen_tietomalli_v0.2_30082021.png) liitteenä

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

Suodattimien tarkoitus on poistaa tuotetusta pgModelerilla tuotetusta
SQL-tallenteesta tarpeettomia toimenpiteitä, joita työkalusta
itsestään ei voi kytkeä pois. Näitä ovat esimerkiksi roolin (ROLE) tai
laajennuksen (EXTENSION) tarpeettomat muutokset.

On huomattava, että suodattimien toiminta on vahvasti riippuvainen pgModeler:n tuottamasta
SQL-kielestä, ja on todennäköistä että suodattimia pitää myöhemmin päivittää.

Suodattimien käyttöesimerkki, turhien roolien poistaminen tallenteesta:
```sh
[shell]$ cat database_export.sql | ./filter_role.sh
```

Todenna suodattimen toiminta manuaalisella tarkastelulla vaikka näin:
```sh
[shell]$ cat database_export.sql | ./filter_role.sh | diff database_export.sql -
```

# Tietokantapalvelun käynnistäminen

Palvelu (PostgreSQL 12, PostGIS 3) käynnistetään docker-compose -komennolla:

```
[shell]$ docker-compose up
```

PostgreSQL käynnistyy porttiin 5432.

Komentorivipääsy tietokantaan onnistuu seuraavasti:

```
[shell]$ PGPASSWORD=docker psql -U docker -h localhost dev_alueraja_db
```
