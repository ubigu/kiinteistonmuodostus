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

# Ajantasainen kannan skeemakuva

Käynnistyksen yhteydessä luodaan myös kannan skeemakuva. Se löytyy sijainnista:
*output/diagrams/summary/relationships.implied.large.png*
## Kannan palvelimen osoitteen määritys *schemaspy.properites* -tiedostoon

Koska kantaa pyöritetään dockerissa, pitää palvelimen osoite olla docker gatewayn osoite.

Linuxissa osoitteen saa selville seuraavasti:
```
docker network inspect bridge --format='{{range .IPAM.Config}}{{.Gateway}}{{end}}'
```

Tämä osoite pitää määrittää schemaspy.properties -tiedostoon, riville: *schemaspy.host=*