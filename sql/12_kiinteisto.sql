-- Kiinteistö
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
    id UUID PRIMARY KEY,
    kiinteistotunnus CHARACTER VARYING(100) NOT NULL,
    elinkaaren_tila_id INTEGER NOT NULL,
    rekisteriyksikkolaji_id INTEGER NOT NULL,
    -- liittyvan_lahtotietokohteen_tunnus ref to muodostusluettelo
    projisoitu_ala DOUBLE PRECISION,
    suhde_peruskiinteistoon_id INTEGER,
    alin_korkeus FLOAT,
    ylin_korkeus FLOAT,
    olotila_id INTEGER,
-- versioitu objekti
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100) DEFAULT user,
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITH TIME ZONE,
    muokkausaika TIMESTAMP WITH TIME ZONE
);

ALTER TABLE rekisteriyksikko ADD CONSTRAINT rekisteriyksikko_elinkaaren_tila_id_fk FOREIGN KEY (elinkaaren_tila_id) REFERENCES rekisteriyksikon_elinkaaren_tila(id);
ALTER TABLE rekisteriyksikko ADD CONSTRAINT rekisteriyksikko_rekisteriyksikkolaji_id_fk FOREIGN KEY (rekisteriyksikkolaji_id) REFERENCES rekisteriyksikkolaji(id);
ALTER TABLE rekisteriyksikko ADD CONSTRAINT rekisteriyksikko_suhde_peruskiinteistoon_id_fk FOREIGN KEY (suhde_peruskiinteistoon_id) REFERENCES suhde_peruskiinteistoon(id);

CREATE TABLE rekisteriyksikko_geometria (
    id UUID PRIMARY KEY,
    rekisteriyksikko_id UUID NOT NULL,
    geom_2d GEOMETRY(MULTIPOLYGON, 3878),
    geom_3d GEOMETRY(POLYHEDRALSURFACE, 3878)
);

ALTER TABLE rekisteriyksikko_geometria ADD CONSTRAINT rekisteriyksikko_geometria_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);

CREATE TABLE rekisteriyksikko_versio (
    id BIGSERIAL PRIMARY KEY,
    korvaaja_id UUID NOT NULL,
    korvattu_id UUID NOT NULL
);

ALTER TABLE rekisteriyksikko_versio ADD CONSTRAINT rekisteriyksikko_versio_korvaaja_id_fk FOREIGN KEY (korvaaja_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE rekisteriyksikko_versio ADD CONSTRAINT rekisteriyksikko_versio_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES rekisteriyksikko(id);

CREATE TABLE kiinteisto_rajamerkki (
    id UUID PRIMARY KEY,
    rajamerkkityyppi_id INTEGER NOT NULL,
    olemassaolo_id INTEGER,
    pistenumero CHARACTER VARYING(100),
    rakenne_id INTEGER,
    alusta_id INTEGER,
    nakyvyys_id INTEGER,
    rekisteriyksikko_id UUID NOT NULL,
    olotila_id INTEGER,
    geom GEOMETRY(POINT, 3878),
-- versioitu objekti
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100) DEFAULT user,
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITH TIME ZONE,
    muokkausaika TIMESTAMP WITH TIME ZONE
);

ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_rajamerkkityyppi_id_fk FOREIGN KEY (rajamerkkityyppi_id) REFERENCES rajamerkkityyppi(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_olemassaolo_id_fk FOREIGN KEY (olemassaolo_id) REFERENCES olemassaolo(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_rakenne_id_fk FOREIGN KEY (rakenne_id) REFERENCES rakenne(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_alusta_id_fk FOREIGN KEY (alusta_id) REFERENCES alusta(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_nakyvyys_id_fk FOREIGN KEY (nakyvyys_id) REFERENCES nakyvyys(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE kiinteisto_rajamerkki ADD CONSTRAINT kiinteisto_rajamerkki_olotila_id_fk FOREIGN KEY (olotila_id) REFERENCES olotila(id);

CREATE TABLE kiinteisto_rajamerkki_versio (
    id BIGSERIAL PRIMARY KEY,
    korvaaja_id UUID NOT NULL,
    korvattu_id UUID NOT NULL
);

ALTER TABLE kiinteisto_rajamerkki_versio ADD CONSTRAINT kiinteisto_rajamerkki_versio_korvaaja_id_fk FOREIGN KEY (korvaaja_id) REFERENCES kiinteisto_rajamerkki(id);
ALTER TABLE kiinteisto_rajamerkki_versio ADD CONSTRAINT kiinteisto_rajamerkki_versio_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES kiinteisto_rajamerkki(id);

CREATE TABLE toimitusasia (
    id BIGSERIAL PRIMARY KEY,
    toimenpidelaji_id INTEGER NOT NULL,
    toimitusnumero CHARACTER VARYING(100),
    hakemusnumero CHARACTER VARYING(100),
    kirjaamisaika TIMESTAMP WITH TIME ZONE,
    maaraysaika TIMESTAMP WITH TIME ZONE,
    toimitusinsinoori CHARACTER VARYING(100) NOT NULL,
    toimitusvalmistelija CHARACTER VARYING(100) NOT NULL,
    esirekisterointiaika TIMESTAMP WITH TIME ZONE,
    arkistointiaika TIMESTAMP WITH TIME ZONE,
    lisatietoja CHARACTER VARYING(1000),
-- versioitu objekti
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100) DEFAULT user,
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITH TIME ZONE,
    muokkausaika TIMESTAMP WITH TIME ZONE
);

ALTER TABLE toimitusasia ADD CONSTRAINT toimitusasia_toimenpidelaji_id_fk FOREIGN KEY (toimenpidelaji_id) REFERENCES toimenpidelaji(id);

CREATE TABLE toimitusasia_versio (
    id BIGSERIAL PRIMARY KEY,
    korvaaja_id BIGINT NOT NULL,
    korvattu_id BIGINT NOT NULL
);

ALTER TABLE toimitusasia_versio ADD CONSTRAINT toimitusasia_versio_korvaaja_id_fk FOREIGN KEY (korvaaja_id) REFERENCES toimitusasia(id);
ALTER TABLE toimitusasia_versio ADD CONSTRAINT toimitusasia_versio_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES toimitusasia(id);

CREATE TABLE toimitusasia_asiakirja_join (
    id BIGSERIAL PRIMARY KEY,
    asiakirja_id BIGINT NOT NULL,
    toimitusasia_id BIGINT NOT NULL
);

ALTER TABLE toimitusasia_asiakirja_join ADD CONSTRAINT toimitusasia_asiakirja_join_asiakirja_id_fk FOREIGN KEY (asiakirja_id) REFERENCES asiakirja(id);
ALTER TABLE toimitusasia_asiakirja_join ADD CONSTRAINT toimitusasia_asiakirja_join_toimitusasia_id_fk FOREIGN KEY (toimitusasia_id) REFERENCES toimitusasia(id);

CREATE TABLE rekisteriyksikko_yleisen_alueen_tyyppi_join (
    id BIGSERIAL PRIMARY KEY,
    rekisteriyksikko_id UUID NOT NULL,
    yleisen_alueen_tyyppi_id INTEGER NOT NULL
);

ALTER TABLE rekisteriyksikko_yleisen_alueen_tyyppi_join ADD CONSTRAINT rekisteriyksikko_yleisen_alueen_tyyppi_join_1_fk FOREIGN KEY (yleisen_alueen_tyyppi_id) REFERENCES yleisen_alueen_tyyppi(id);
ALTER TABLE rekisteriyksikko_yleisen_alueen_tyyppi_join ADD CONSTRAINT rekisteriyksikko_yleisen_alueen_tyyppi_join_2_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);

CREATE TABLE rekisteriyksikko_kiinteisto_rajamerkki_join (
    id BIGSERIAL PRIMARY KEY,
    rekisteriyksikko_id UUID NOT NULL,
    kiinteisto_rajamerkki_id UUID NOT NULL
);

ALTER TABLE rekisteriyksikko_kiinteisto_rajamerkki_join ADD CONSTRAINT rekisteriyksikko_kiinteisto_rajamerkki_join_1_fk FOREIGN KEY (kiinteisto_rajamerkki_id) REFERENCES kiinteisto_rajamerkki(id);
ALTER TABLE rekisteriyksikko_kiinteisto_rajamerkki_join ADD CONSTRAINT rekisteriyksikko_kiinteisto_rajamerkki_join_2_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);

CREATE TABLE vuokraalue (
    id UUID PRIMARY KEY,
    vuokraalue_tunnus CHARACTER VARYING(200) NOT NULL,
    alkamisaika TIMESTAMP WITH TIME ZONE,
    paattymisaika TIMESTAMP WITH TIME ZONE,
    rekisteriyksikko_id UUID NOT NULL,
    olotila_id INTEGER,
-- versioitu objekti
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100) DEFAULT user,
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITH TIME ZONE,
    muokkausaika TIMESTAMP WITH TIME ZONE
);

ALTER TABLE vuokraalue ADD CONSTRAINT vuokraalue_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE vuokraalue ADD CONSTRAINT vuokraalue_olotila_id_fk FOREIGN KEY (olotila_id) REFERENCES olotila(id);

CREATE TABLE vuokraalue_geometria (
    id UUID PRIMARY KEY,
    vuokraalue_id UUID NOT NULL,
    geom_2d GEOMETRY(MULTIPOLYGON, 3878),
    geom_3d GEOMETRY(POLYHEDRALSURFACE, 3878)
);

ALTER TABLE vuokraalue_geometria ADD CONSTRAINT vuokraalue_geometria_rekisteriyksikko_id_fk FOREIGN KEY (vuokraalue_id) REFERENCES vuokraalue(id);

CREATE TABLE vuokraalue_versio (
    id BIGSERIAL PRIMARY KEY,
    korvaaja_id UUID NOT NULL,
    korvattu_id UUID NOT NULL
);

ALTER TABLE vuokraalue_versio ADD CONSTRAINT vuokraalue_versio_korvaaja_id_fk FOREIGN KEY (korvaaja_id) REFERENCES vuokraalue(id);
ALTER TABLE vuokraalue_versio ADD CONSTRAINT vuokraalue_versio_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES vuokraalue(id);

CREATE TABLE maaraala (
    id UUID PRIMARY KEY,
    maaraala_tunnus CHARACTER VARYING(100) NOT NULL,
    maaraalan_olotila_id INTEGER NOT NULL,
    rekisteriyksikko_id UUID NOT NULL,
    olotila_id INTEGER,
-- versioitu objekti
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100) DEFAULT user,
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITH TIME ZONE,
    muokkausaika TIMESTAMP WITH TIME ZONE
);

ALTER TABLE maaraala ADD CONSTRAINT maaraala_maaraalan_olotila_id_fk FOREIGN KEY (maaraalan_olotila_id) REFERENCES maaraalan_olotila(id);
ALTER TABLE maaraala ADD CONSTRAINT maaraala_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE maaraala ADD CONSTRAINT maaraala_olotila_id_fk FOREIGN KEY (olotila_id) REFERENCES olotila(id);

CREATE TABLE maaraala_geometria (
    id UUID PRIMARY KEY,
    maaraala_id UUID NOT NULL,
    geom_2d GEOMETRY(MULTIPOLYGON, 3878),
    geom_3d GEOMETRY(POLYHEDRALSURFACE, 3878)
);

ALTER TABLE maaraala_geometria ADD CONSTRAINT maaraala_geometria_rekisteriyksikko_id_fk FOREIGN KEY (maaraala_id) REFERENCES maaraala(id);

CREATE TABLE maaraala_versio (
    id BIGSERIAL PRIMARY KEY,
    korvaaja_id UUID NOT NULL,
    korvattu_id UUID NOT NULL
);

ALTER TABLE maaraala_versio ADD CONSTRAINT maaraala_versio_korvaaja_id_fk FOREIGN KEY (korvaaja_id) REFERENCES maaraala(id);
ALTER TABLE maaraala_versio ADD CONSTRAINT maaraala_versio_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES maaraala(id);

CREATE TABLE kayttooikeusyksikko (
    id UUID PRIMARY KEY,
    kayttooikeusyksikko_tunnus CHARACTER VARYING(100),
    alkamisaika TIMESTAMP WITH TIME ZONE,
    paattymisaika TIMESTAMP WITH TIME ZONE,
    laji_id INTEGER NOT NULL,
    rekisteriyksikko_id UUID NOT NULL,
    olotila_id INTEGER,
-- versioitu objekti
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100) DEFAULT user,
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITH TIME ZONE,
    muokkausaika TIMESTAMP WITH TIME ZONE
);

ALTER TABLE kayttooikeusyksikko ADD CONSTRAINT kayttooikeusyksikko_laji_id_fk FOREIGN KEY (laji_id) REFERENCES kayttooikeusyksikkolaji(id);
ALTER TABLE kayttooikeusyksikko ADD CONSTRAINT kayttooikeusyksikko_rekisteriyksikko_id_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);
ALTER TABLE kayttooikeusyksikko ADD CONSTRAINT kayttooikeusyksikko_olotila_id_fk FOREIGN KEY (olotila_id) REFERENCES olotila(id);

CREATE TABLE kayttooikeusyksikko_geometria (
    id UUID PRIMARY KEY,
    kayttooikeusyksikko_id UUID NOT NULL,
    geom_2d GEOMETRY(MULTIPOLYGON, 3878),
    geom_3d GEOMETRY(POLYHEDRALSURFACE, 3878)
);

ALTER TABLE kayttooikeusyksikko_geometria ADD CONSTRAINT kayttooikeusyksikko_geometria_rekisteriyksikko_id_fk FOREIGN KEY (kayttooikeusyksikko_id) REFERENCES kayttooikeusyksikko(id);

CREATE TABLE kayttooikeusyksikko_versio (
    id BIGSERIAL PRIMARY KEY,
    korvaaja_id UUID NOT NULL,
    korvattu_id UUID NOT NULL
);

ALTER TABLE kayttooikeusyksikko_versio ADD CONSTRAINT kayttooikeusyksikko_versio_korvaaja_id_fk FOREIGN KEY (korvaaja_id) REFERENCES kayttooikeusyksikko(id);
ALTER TABLE kayttooikeusyksikko_versio ADD CONSTRAINT kayttooikeusyksikko_versio_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES kayttooikeusyksikko(id);

CREATE TABLE rekisteriyksikko_maaraala_join (
    id BIGSERIAL PRIMARY KEY,
    rekisteriyksikko_id UUID NOT NULL,
    maaraala_id UUID NOT NULL
);

ALTER TABLE rekisteriyksikko_maaraala_join ADD CONSTRAINT rekisteriyksikko_maaraala_join_1_fk FOREIGN KEY (maaraala_id) REFERENCES maaraala(id);
ALTER TABLE rekisteriyksikko_maaraala_join ADD CONSTRAINT rekisteriyksikko_maaraala_join_2_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);

CREATE TABLE rekisteriyksikko_vuokraalue_join (
    id BIGSERIAL PRIMARY KEY,
    rekisteriyksikko_id UUID NOT NULL,
    vuokraalue_id UUID NOT NULL
);

ALTER TABLE rekisteriyksikko_vuokraalue_join ADD CONSTRAINT rekisteriyksikko_vuokraalue_join_1_fk FOREIGN KEY (vuokraalue_id) REFERENCES vuokraalue(id);
ALTER TABLE rekisteriyksikko_vuokraalue_join ADD CONSTRAINT rekisteriyksikko_vuokraalue_join_2_fk FOREIGN KEY (rekisteriyksikko_id) REFERENCES rekisteriyksikko(id);

-- ALTER TABLE ADD CONSTRAINT FOREIGN KEY () REFERENCES (id);
