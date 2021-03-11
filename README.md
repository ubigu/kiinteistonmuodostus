# kiinteistonmuodostus
Kiinteistönmuodostuksen tietomallit

# Tietokantapalvelun käynnistäminen

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