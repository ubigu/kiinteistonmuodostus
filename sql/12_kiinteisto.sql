-- Kiinteistö
CREATE TABLE muodostusluettelo (
    id BIGSERIAL PRIMARY KEY,
    kiinteistotunnus CHARACTER VARYING(100) NOT NULL,
    pinta_ala DOUBLE PRECISION NOT NULL
);

CREATE TABLE rekisteriyksikkolaji (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

CREATE TABLE rekisteriyksikon_elinkaaren_tila (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

CREATE TABLE yleisen_alueen_tyyppi (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

CREATE TABLE kayttooikeusyksikkolaji (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

CREATE TABLE rakenne (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

CREATE TABLE maaraalan_olotila (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

CREATE TABLE toimenpidelaji (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

CREATE TABLE olemassaolo (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

CREATE TABLE alusta (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

CREATE TABLE nakyvyys (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

CREATE TABLE rekisteriyksikko (
    id BIGSERIAL PRIMARY KEY,
    kiinteistotunnus CHARACTER VARYING(100) NOT NULL,
    elinkaaren_tila_id INTEGER NOT NULL,
    rekisteriyksikkolaji_id INTEGER NOT NULL,
    projisoitu_ala DOUBLE PRECISION,
    suhde_peruskiinteistoon_id INTEGER,
    alin_korkeus FLOAT,
    ylin_korkeus FLOAT
);

ALTER TABLE rekisteriyksikko ADD CONSTRAINT rekisteriyksikko_elinkaaren_tila_id_fk FOREIGN KEY (elinkaaren_tila_id) REFERENCES rekisteriyksikon_elinkaaren_tila(id);
ALTER TABLE rekisteriyksikko ADD CONSTRAINT rekisteriyksikko_rekisteriyksikkolaji_id_fk FOREIGN KEY (rekisteriyksikkolaji_id) REFERENCES rekisteriyksikkolaji(id);
ALTER TABLE rekisteriyksikko ADD CONSTRAINT rekisteriyksikko_suhde_peruskiinteistoon_id_fk FOREIGN KEY (suhde_peruskiinteistoon_id) REFERENCES suhde_peruskiinteistoon(id);

CREATE TABLE rekisteriyksikko_geom_2d (
    id BIGSERIAL PRIMARY KEY,
    rekisteriyksikko_id BIGINT NOT NULL,
    geom GEOMETRY(MULTIPOLYGON, 3878)
);

ALTER TABLE rekisteriyksikko_geom_2d ADD CONSTRAINT rekisteriyksikko_geom_2d_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);

CREATE TABLE rekisteriyksikko_geom_3d (
    id BIGSERIAL PRIMARY KEY,
    rekisteriyksikko_id BIGINT NOT NULL,
    geom GEOMETRY(POLYHEDRALSURFACE, 3878)    
);

ALTER TABLE rekisteriyksikko_geom_3d ADD CONSTRAINT rekisteriyksikko_geom_3d_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);

CREATE TABLE kiinteisto_rajamerkki (
    id BIGSERIAL PRIMARY KEY,
    rajamerkkityyppi_id INTEGER NOT NULL,
    olemassaolo_id INTEGER,
    pistenumero CHARACTER VARYING(100),
    rakenne_id INTEGER,
    alusta_id INTEGER,
    nakyvyys_id INTEGER,
    rekisteriyksikko_id BIGINT NOT NULL,
    olotila_id INTEGER,
    geom GEOMETRY(POINT, 3878),
-- versioitu objekti
    korvattu_id INTEGER,
    korvaava_id INTEGER,
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100),
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITHOUT TIME ZONE,
    muokkausaika TIMESTAMP WITHOUT TIME ZONE
);

ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_rajamerkkityyppi_id_fk FOREIGN KEY (rajamerkkityyppi_id) REFERENCES rajamerkkityyppi(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_olemassaolo_id_fk FOREIGN KEY (olemassaolo_id) REFERENCES olemassaolo(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_rakenne_id_fk FOREIGN KEY (rakenne_id) REFERENCES rakenne(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_alusta_id_fk FOREIGN KEY (alusta_id) REFERENCES alusta(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_nakyvyys_id_fk FOREIGN KEY (nakyvyys_id) REFERENCES nakyvyys(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_olotila_id_fk FOREIGN KEY (olotila_id) REFERENCES olotila(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES kiinteisto_rajamerkki(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_korvaava_id_fk FOREIGN KEY (korvaava_id) REFERENCES kiinteisto_rajamerkki(id);

CREATE TABLE toimitusasia (
    id BIGSERIAL PRIMARY KEY,
    toimenpidelaji_id INTEGER NOT NULL,
    toimitusnumero CHARACTER VARYING(100),
    hakemusnumero CHARACTER VARYING(100),
    kirjaamisaika TIMESTAMP WITHOUT TIME ZONE,
    maaraysaika TIMESTAMP WITHOUT TIME ZONE,
    toimitusinsinoori CHARACTER VARYING(100) NOT NULL,
    toimitusvalmistelija CHARACTER VARYING(100) NOT NULL,
    esirekisterointiaika TIMESTAMP WITHOUT TIME ZONE,
    arkistointiaika TIMESTAMP WITHOUT TIME ZONE,
    lisatietoja CHARACTER VARYING(1000),
-- versioitu objekti
    korvattu_id INTEGER,
    korvaava_id INTEGER,
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100),
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITHOUT TIME ZONE,
    muokkausaika TIMESTAMP WITHOUT TIME ZONE
);

ALTER TABLE toimitusasia ADD CONSTRAINT toimitusasia_toimenpidelaji_id_fk FOREIGN KEY (toimenpidelaji_id) REFERENCES toimenpidelaji(id);
ALTER TABLE toimitusasia ADD CONSTRAINT toimitusasia_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES toimitusasia(id);
ALTER TABLE toimitusasia ADD CONSTRAINT toimitusasia_korvaava_id_fk FOREIGN KEY (korvaava_id) REFERENCES toimitusasia(id);

CREATE TABLE rekisteriyksikko_yleisen_alueen_tyyppi_join (
    id BIGSERIAL PRIMARY KEY,
    rekisteriyksikko_id BIGINT NOT NULL,
    yleisen_alueen_tyyppi_id INTEGER NOT NULL
);

ALTER TABLE rekisteriyksikko_yleisen_alueen_tyyppi_join ADD CONSTRAINT rekisteriyksikko_yleisen_alueen_tyyppi_join_1_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE rekisteriyksikko_yleisen_alueen_tyyppi_join ADD CONSTRAINT rekisteriyksikko_yleisen_alueen_tyyppi_join_2_fk FOREIGN KEY (yleisen_alueen_tyyppi_id) REFERENCES yleisen_alueen_tyyppi(id);

CREATE TABLE rekisteriyksikko_kiinteisto_rajamerkki_join (
    id BIGSERIAL PRIMARY KEY,
    rekisteriyksikko_id BIGINT NOT NULL,
    kiinteisto_rajamerkki_id BIGINT NOT NULL
);

ALTER TABLE rekisteriyksikko_kiinteisto_rajamerkki_join ADD CONSTRAINT rekisteriyksikko_kiinteisto_rajamerkki_join_1_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE rekisteriyksikko_kiinteisto_rajamerkki_join ADD CONSTRAINT rekisteriyksikko_kiinteisto_rajamerkki_join_2_fk FOREIGN KEY (kiinteisto_rajamerkki_id) REFERENCES kiinteisto_rajamerkki(id);

CREATE TABLE vuokraalue (
    id BIGSERIAL PRIMARY KEY,
    vuokraalue_tunnus CHARACTER VARYING(200) NOT NULL,
    alkamisaika TIMESTAMP WITHOUT TIME ZONE,
    paattymisaika TIMESTAMP WITHOUT TIME ZONE,
    rekisteriyksikko_id BIGINT NOT NULL,
    olotila_id INTEGER,
    geom GEOMETRY(MULTIPOLYGON, 3878),
-- versioitu objekti
    korvattu_id INTEGER,
    korvaava_id INTEGER,
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100),
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITHOUT TIME ZONE,
    muokkausaika TIMESTAMP WITHOUT TIME ZONE
);

ALTER TABLE vuokraalue ADD CONSTRAINT vuokraalue_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE vuokraalue ADD CONSTRAINT vuokraalue_olotila_id_fk FOREIGN KEY (olotila_id) REFERENCES olotila(id);
ALTER TABLE vuokraalue ADD CONSTRAINT vuokraalue_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES vuokraalue(id);
ALTER TABLE vuokraalue ADD CONSTRAINT vuokraalue_korvaava_id_fk FOREIGN KEY (korvaava_id) REFERENCES vuokraalue(id);

CREATE TABLE maaraala (
    id BIGSERIAL PRIMARY KEY,
    maaraala_tunnus CHARACTER VARYING(100) NOT NULL,
    maaraalan_olotila_id INTEGER NOT NULL,
    rekisteriyksikko_id BIGINT NOT NULL,
    olotila_id INTEGER,
    geom GEOMETRY(MULTIPOLYGON, 3878),
-- versioitu objekti
    korvattu_id INTEGER,
    korvaava_id INTEGER,
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100),
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITHOUT TIME ZONE,
    muokkausaika TIMESTAMP WITHOUT TIME ZONE
);

ALTER TABLE maaraala ADD CONSTRAINT maaraala_maaraalan_olotila_id_fk FOREIGN KEY (maaraalan_olotila_id) REFERENCES maaraalan_olotila(id);
ALTER TABLE maaraala ADD CONSTRAINT maaraala_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE maaraala ADD CONSTRAINT maaraala_olotila_id_fk FOREIGN KEY (olotila_id) REFERENCES olotila(id);
ALTER TABLE maaraala ADD CONSTRAINT maaraala_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES maaraala(id);
ALTER TABLE maaraala ADD CONSTRAINT maaraala_korvaava_id_fk FOREIGN KEY (korvaava_id) REFERENCES maaraala(id);

CREATE TABLE kayttooikeusyksikko (
    id BIGSERIAL PRIMARY KEY,
    kayttooikeusyksikko_tunnus CHARACTER VARYING(100),
    alkamisaika TIMESTAMP WITHOUT TIME ZONE,
    paattymisaika TIMESTAMP WITHOUT TIME ZONE,
    laji_id INTEGER NOT NULL,
    rekisteriyksikko_id BIGINT NOT NULL,
    olotila_id INTEGER,
    geom GEOMETRY(MULTIPOLYGON, 3878),
-- versioitu objekti
    korvattu_id INTEGER,
    korvaava_id INTEGER,
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100),
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITHOUT TIME ZONE,
    muokkausaika TIMESTAMP WITHOUT TIME ZONE
);

ALTER TABLE kayttooikeusyksikko ADD CONSTRAINT kayttooikeusyksikko_laji_id_fk FOREIGN KEY (laji_id) REFERENCES kayttooikeusyksikkolaji(id);
ALTER TABLE kayttooikeusyksikko ADD CONSTRAINT kayttooikeusyksikko_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE kayttooikeusyksikko ADD CONSTRAINT kayttooikeusyksikko_olotila_id_fk FOREIGN KEY (olotila_id) REFERENCES olotila(id);
ALTER TABLE kayttooikeusyksikko ADD CONSTRAINT kayttooikeusyksikko_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES kayttooikeusyksikko(id);
ALTER TABLE kayttooikeusyksikko ADD CONSTRAINT kayttooikeusyksikko_korvaava_id_fk FOREIGN KEY (korvaava_id) REFERENCES kayttooikeusyksikko(id);

CREATE TABLE rekisteriyksikko_maaraala_join (
    id BIGSERIAL PRIMARY KEY,
    rekisteriyksikko_id BIGINT NOT NULL,
    maaraala_id BIGINT NOT NULL
);

ALTER TABLE rekisteriyksikko_maaraala_join ADD CONSTRAINT rekisteriyksikko_maaraala_join_1_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE rekisteriyksikko_maaraala_join ADD CONSTRAINT rekisteriyksikko_maaraala_join_2_fk FOREIGN KEY (maaraala_id) REFERENCES maaraala(id);


CREATE TABLE rekisteriyksikko_vuokraalue_join (
    id BIGSERIAL PRIMARY KEY,
    rekisteriyksikko_id BIGINT NOT NULL,
    vuokraalue_id BIGINT NOT NULL
);
ALTER TABLE rekisteriyksikko_vuokraalue_join ADD CONSTRAINT rekisteriyksikko_vuokraalue_join_1_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE rekisteriyksikko_vuokraalue_join ADD CONSTRAINT rekisteriyksikko_vuokraalue_join_2_fk FOREIGN KEY (vuokraalue_id) REFERENCES vuokraalue(id);

-- ALTER TABLE ADD CONSTRAINT FOREIGN KEY () REFERENCES (id);
