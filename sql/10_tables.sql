CREATE TABLE tonttijakosuunnitelman_laji (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

ALTER TABLE tonttijakosuunnitelman_laji ADD CONSTRAINT tonttijakosuunnitelman_laji_koodi_kieli_unique UNIQUE (lang, koodi);

COMMENT ON TABLE tonttijakosuunnitelman_laji IS 'Tonttijakosuunnitelman laji.';
COMMENT ON COLUMN tonttijakosuunnitelman_laji.id IS 'Pääavain.';
COMMENT ON COLUMN tonttijakosuunnitelman_laji.lang IS 'Koodin kieli.';
COMMENT ON COLUMN tonttijakosuunnitelman_laji.koodi IS 'Tonttijakosuunnitelman lajin koodi';
COMMENT ON COLUMN tonttijakosuunnitelman_laji.arvo IS 'Tonttijakosuunnitelman lajin koodin selite.';

CREATE TABLE tonttijakosuunnitelman_elinkaaren_tila (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

ALTER TABLE tonttijakosuunnitelman_elinkaaren_tila ADD CONSTRAINT tonttijakosuunnitelman_elinkaaren_tila_koodi_kieli_unique UNIQUE (lang, koodi);

COMMENT ON TABLE tonttijakosuunnitelman_elinkaaren_tila IS 'Tonttijakosuunnitelman elinkaaren tila.';
COMMENT ON COLUMN tonttijakosuunnitelman_elinkaaren_tila.id IS 'Pääavain.';
COMMENT ON COLUMN tonttijakosuunnitelman_elinkaaren_tila.lang IS 'Koodin kieli.';
COMMENT ON COLUMN tonttijakosuunnitelman_elinkaaren_tila.koodi IS 'Tonttijakosuunnitelman elinkaaren koodi.';
COMMENT ON COLUMN tonttijakosuunnitelman_elinkaaren_tila.arvo IS 'Tonttijakosuunnitelman elinkaaren koodin selite.';

CREATE TABLE olotila (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

ALTER TABLE olotila ADD CONSTRAINT olotila_koodi_kieli_unique UNIQUE (lang, koodi);

COMMENT ON TABLE olotila IS 'Tonttijakosuunnitelman olotila';
COMMENT ON COLUMN olotila.id IS 'Pääavain.';
COMMENT ON COLUMN olotila.lang IS 'Koodin kieli.';
COMMENT ON COLUMN olotila.koodi IS 'Olotilan koodi.';
COMMENT ON COLUMN olotila.arvo IS 'Olotilan koodin selite.';

CREATE TABLE suhde_peruskiinteistoon (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

ALTER TABLE suhde_peruskiinteistoon ADD CONSTRAINT suhde_peruskiinteistoon_koodi_kieli_unique UNIQUE (lang, koodi);

COMMENT ON TABLE suhde_peruskiinteistoon IS 'Suhde peruskiinteistöön.';
COMMENT ON COLUMN suhde_peruskiinteistoon.id IS 'Pääavain.';
COMMENT ON COLUMN suhde_peruskiinteistoon.lang IS 'Koodin kieli.';
COMMENT ON COLUMN suhde_peruskiinteistoon.koodi IS 'Suhteen koodi.';
COMMENT ON COLUMN suhde_peruskiinteistoon.arvo IS 'Suhteen koodin selite.';

CREATE TABLE tonttijakosuunnitelma (
    id BIGSERIAL PRIMARY KEY,
    tonttijakosuunnitelman_laji_id INTEGER NOT NULL,
    tunnus CHARACTER VARYING(100) NOT NULL,
    tonttijakosuunnitelman_elinkaaren_tila_id INTEGER NOT NULL,
    olotila_id INTEGER,
    suhde_peruskiinteistoon_id INTEGER,
    vireilletuloaika TIMESTAMP WITHOUT TIME ZONE,
    hyvaksymisaika TIMESTAMP WITHOUT TIME ZONE,
    voimaantuloaika TIMESTAMP WITHOUT TIME ZONE,
    kumottuaika TIMESTAMP WITHOUT TIME ZONE,
-- versioitu objekti
    korvattu_id BIGINT,
    korvaava_id BIGINT,
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100),
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITHOUT TIME ZONE,
    muokkausaika TIMESTAMP WITHOUT TIME ZONE
);

ALTER TABLE tonttijakosuunnitelma ADD CONSTRAINT tonttijakosuunnitelma_tonttijakosuunnitelman_laji_id_fk FOREIGN KEY (tonttijakosuunnitelman_laji_id) REFERENCES tonttijakosuunnitelman_laji (id);
ALTER TABLE tonttijakosuunnitelma ADD CONSTRAINT tonttijakosuunnitelma_tonttijakosuunnitelman_elinkaaren_tila_id_fk FOREIGN KEY (tonttijakosuunnitelman_elinkaaren_tila_id) REFERENCES tonttijakosuunnitelman_elinkaaren_tila (id);
ALTER TABLE tonttijakosuunnitelma ADD CONSTRAINT tonttijakosuunnitelma_olotila_id_fk FOREIGN KEY (olotila_id) REFERENCES olotila(id);
ALTER TABLE tonttijakosuunnitelma ADD CONSTRAINT tonttijakosuunnitelma_suhde_peruskiinteistoon_id_fk FOREIGN KEY (suhde_peruskiinteistoon_id) REFERENCES suhde_peruskiinteistoon(id);
ALTER TABLE tonttijakosuunnitelma ADD CONSTRAINT tonttijakosuunnitelma_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES tonttijakosuunnitelma(id);
ALTER TABLE tonttijakosuunnitelma ADD CONSTRAINT tonttijakosuunnitelma_korvaava_id_fk FOREIGN KEY (korvaava_id) REFERENCES tonttijakosuunnitelma(id);

COMMENT ON TABLE tonttijakosuunnitelma IS 'Tonttijakosuunnitelma';
COMMENT ON COLUMN tonttijakosuunnitelma.id IS 'Pääavain.';
COMMENT ON COLUMN tonttijakosuunnitelma.tonttijakosuunnitelman_laji_id IS 'Viittaus tonttijakosuunnitelman_laji -tauluun';
COMMENT ON COLUMN tonttijakosuunnitelma.tunnus IS 'Tonttijakosuunnitelman tunnus';
COMMENT ON COLUMN tonttijakosuunnitelma.tonttijakosuunnitelman_elinkaaren_tila_id IS 'Viittaus tonttjakosuunnitelman_elinkaaren_tila -tauluun.';
COMMENT ON COLUMN tonttijakosuunnitelma.olotila_id IS 'Viittaus olotila -tauluun';
COMMENT ON COLUMN tonttijakosuunnitelma.suhde_peruskiinteistoon_id IS 'Viittaus suhde_peruskiinteistoon -tauluun.';
COMMENT ON COLUMN tonttijakosuunnitelma.vireilletuloaika IS 'Vireilletulon aika.';
COMMENT ON COLUMN tonttijakosuunnitelma.hyvaksymisaika IS 'Hyväksymisaika.';
COMMENT ON COLUMN tonttijakosuunnitelma.voimaantuloaika IS 'Voimaantulon aika.';
COMMENT ON COLUMN tonttijakosuunnitelma.kumottuaika IS 'Aika jolloin kumottu.';
COMMENT ON COLUMN tonttijakosuunnitelma.korvattu_id IS 'Korvattu objekti.';
COMMENT ON COLUMN tonttijakosuunnitelma.korvaava_id IS 'Korvaava objekti.';
COMMENT ON COLUMN tonttijakosuunnitelma.identiteettitunnus IS 'Identiteettitunnus.';
COMMENT ON COLUMN tonttijakosuunnitelma.paikallinen_tunnus IS 'Paikallinen tunnus.';
COMMENT ON COLUMN tonttijakosuunnitelma.laatija IS 'Laatijan tunniste.';
COMMENT ON COLUMN tonttijakosuunnitelma.muokkaaja IS 'Muokkaajan tunniste.';
COMMENT ON COLUMN tonttijakosuunnitelma.luontiaika IS 'Luontiaika.';
COMMENT ON COLUMN tonttijakosuunnitelma.muokkausaika IS 'Muokkausaika.';

CREATE TABLE esitontti_geom_2d (
    id BIGSERIAL PRIMARY KEY,
    geom GEOMETRY(MULTIPOLYGON, 3878)
);

COMMENT ON TABLE esitontti_geom_2d IS 'Esitontin 2D-geometria.';
COMMENT ON COLUMN esitontti_geom_2d.id IS 'Pääavain';
COMMENT ON COLUMN esitontti_geom_2d.geom IS 'Esitontin 2D-geometria.';

CREATE TABLE esitontti_geom_3d (
    id BIGSERIAL PRIMARY KEY,
    geom GEOMETRY(POLYHEDRALSURFACE, 3878)    
);

COMMENT ON TABLE esitontti_geom_3d IS 'Esitontin 3D-geometria.';
COMMENT ON COLUMN esitontti_geom_3d.id IS 'Pääavain';
COMMENT ON COLUMN esitontti_geom_3d.geom IS 'Esitontin 3D-geometria.';

CREATE TABLE esitontti (
    id BIGSERIAL PRIMARY KEY,
    tonttijakosuunnitelma_id BIGINT NOT NULL,
    esitontti_tunnus CHARACTER VARYING(100) NOT NULL,
    esitontti_geom_2d_id BIGINT,
    esitontti_geom_3d_id BIGINT,
    olotila_id INTEGER,
    suhde_peruskiinteistoon_id INTEGER,
    -- TODO: handle precision (area: 3 decimals, height: ??)
    projisoitu_ala DOUBLE PRECISION,
    alin_korkeus FLOAT,
    ylin_korkeus FLOAT,
-- versioitu objekti
    korvattu_id BIGINT,
    korvaava_id BIGINT,
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100),
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITHOUT TIME ZONE,
    muokkausaika TIMESTAMP WITHOUT TIME ZONE
);

ALTER TABLE esitontti ADD CONSTRAINT esitontti_tonttijakosuunnitelma_id_fk FOREIGN KEY (tonttijakosuunnitelma_id) REFERENCES tonttijakosuunnitelma(id) ON DELETE CASCADE;
ALTER TABLE esitontti ADD CONSTRAINT esitontti_olotila_id_fk FOREIGN KEY (olotila_id) REFERENCES olotila(id);
ALTER TABLE esitontti ADD CONSTRAINT esitontti_suhde_peruskiinteistoon_id_fk FOREIGN KEY (suhde_peruskiinteistoon_id) REFERENCES suhde_peruskiinteistoon(id);
ALTER TABLE esitontti ADD CONSTRAINT esitontti_esitontti_geom_2d_id_fk FOREIGN KEY (esitontti_geom_2d_id) REFERENCES esitontti_geom_2d(id);
ALTER TABLE esitontti ADD CONSTRAINT esitontti_esitontti_geom_3d_id_fk FOREIGN KEY (esitontti_geom_3d_id) REFERENCES esitontti_geom_3d(id);
ALTER TABLE esitontti ADD CONSTRAINT esitontti_must_have_geom CHECK (
        (esitontti_geom_2d_id IS NOT NULL AND esitontti_geom_3d_id IS NULL)
    OR  (esitontti_geom_2d_id IS NULL AND esitontti_geom_3d_id IS NOT NULL)
    );
ALTER TABLE esitontti ADD CONSTRAINT esitontti_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES esitontti(id);
ALTER TABLE esitontti ADD CONSTRAINT esitontti_korvaava_id_fk FOREIGN KEY (korvaava_id) REFERENCES esitontti(id);

COMMENT ON TABLE esitontti IS 'Esitontti';
COMMENT ON COLUMN esitontti.id IS 'Pääavain.';
COMMENT ON COLUMN esitontti.tonttijakosuunnitelma_id IS 'Viittaus tonttijakosuunnitelma -tauluun.';
COMMENT ON COLUMN esitontti.esitontti_tunnus IS 'Esitontin tunnus.';
COMMENT ON COLUMN esitontti.olotila_id IS 'Viittaus olotila -tauluun';
COMMENT ON COLUMN esitontti.suhde_peruskiinteistoon_id IS 'Viittaus suhde_peruskiinteistoon -tauluun.';
COMMENT ON COLUMN esitontti.projisoitu_ala IS 'Projisoitu ala, yksikkö m^2';
COMMENT ON COLUMN esitontti.alin_korkeus IS 'Alin korkeus, yksikkö m';
COMMENT ON COLUMN esitontti.ylin_korkeus IS 'Ylin korkeus, yksikkö m';
COMMENT ON COLUMN esitontti.korvattu_id IS 'Korvattu objekti.';
COMMENT ON COLUMN esitontti.korvaava_id IS 'Korvaava objekti.';
COMMENT ON COLUMN esitontti.identiteettitunnus IS 'Identiteettitunnus.';
COMMENT ON COLUMN esitontti.paikallinen_tunnus IS 'Paikallinen tunnus.';
COMMENT ON COLUMN esitontti.laatija IS 'Laatijan tunniste.';
COMMENT ON COLUMN esitontti.muokkaaja IS 'Muokkaajan tunniste.';
COMMENT ON COLUMN esitontti.luontiaika IS 'Luontiaika.';
COMMENT ON COLUMN esitontti.muokkausaika IS 'Muokkausaika.';

CREATE TABLE kaavatunnus (
    id BIGSERIAL PRIMARY KEY,
    tunnus CHARACTER VARYING(100)
);

COMMENT ON TABLE kaavatunnus IS 'Kaavatunnus';
COMMENT ON COLUMN kaavatunnus.id IS 'Pääavain';
COMMENT ON COLUMN kaavatunnus.tunnus IS 'Kaavatunnus.';

CREATE TABLE esitontti_kaavatunnus_join (
    id BIGSERIAL PRIMARY KEY,
    esitontti_id BIGINT NOT NULL, -- TODO: ON DELETE CASCADE?
    kaavatunnus_id BIGINT NOT NULL
);

ALTER TABLE esitontti_kaavatunnus_join ADD CONSTRAINT esitontti_kaavatunnus_join_esitontti_id_fk FOREIGN KEY (esitontti_id) REFERENCES esitontti(id);
ALTER TABLE esitontti_kaavatunnus_join ADD CONSTRAINT esitontti_kaavatunnus_join_kaavatunnus_id_fk FOREIGN KEY (kaavatunnus_id) REFERENCES kaavatunnus(id);

COMMENT ON TABLE esitontti_kaavatunnus_join IS 'Esitontti - kaavatunnus. Monta-moneen liitostaulu.';
COMMENT ON COLUMN esitontti_kaavatunnus_join.id IS 'Pääavain';
COMMENT ON COLUMN esitontti_kaavatunnus_join.esitontti_id IS 'Vierasvain esitontti -tauluun.';
COMMENT ON COLUMN esitontti_kaavatunnus_join.kaavatunnus_id IS 'Vierasvain kaavatunnus-tauluun.';

CREATE TABLE rajamerkkityyppi (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

ALTER TABLE rajamerkkityyppi ADD CONSTRAINT rajamerkkityyppi_koodi_kieli_unique UNIQUE (lang, koodi);

COMMENT ON TABLE rajamerkkityyppi IS 'Rajamerkkityyppi';
COMMENT ON COLUMN rajamerkkityyppi.id IS 'Pääavain';
COMMENT ON COLUMN rajamerkkityyppi.lang IS 'Koodin kieli.';
COMMENT ON COLUMN rajamerkkityyppi.koodi IS 'Rajamerkktyypin koodi.';
COMMENT ON COLUMN rajamerkkityyppi.arvo IS 'Rajamerkkityypin koodin selite.';

CREATE TABLE esitontti_rajamerkki (
    id BIGSERIAL PRIMARY KEY,
    esitontti_id BIGINT NOT NULL,
    rajamerkkityyppi_id INTEGER,
    pistenumero CHARACTER VARYING(100),
    geom GEOMETRY(POINT, 3878),
-- versioitu objekti
    korvattu_id BIGINT,
    korvaava_id BIGINT,
    identiteettitunnus CHARACTER VARYING(100),
    paikallinen_tunnus CHARACTER VARYING(100),
    laatija CHARACTER VARYING(100),
    muokkaaja CHARACTER VARYING(100),
    luontiaika TIMESTAMP WITHOUT TIME ZONE,
    muokkausaika TIMESTAMP WITHOUT TIME ZONE
);

ALTER TABLE esitontti_rajamerkki ADD CONSTRAINT esitontti_rajamerkki_esitontti_id_fk FOREIGN KEY (esitontti_id) REFERENCES esitontti(id);
ALTER TABLE esitontti_rajamerkki ADD CONSTRAINT esitontti_rajamerkki_rajamerkkityyppi_id_fk FOREIGN KEY (rajamerkkityyppi_id) REFERENCES rajamerkkityyppi(id);
ALTER TABLE esitontti_rajamerkki ADD CONSTRAINT esitontti_rajamerkki_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES esitontti_rajamerkki(id);
ALTER TABLE esitontti_rajamerkki ADD CONSTRAINT esitontti_rajamerkki_korvaava_id_fk FOREIGN KEY (korvaava_id) REFERENCES esitontti_rajamerkki(id);

COMMENT ON TABLE esitontti_rajamerkki IS 'Esitontin rajamerkki';
COMMENT ON COLUMN esitontti_rajamerkki.id IS 'Pääavain.';
COMMENT ON COLUMN esitontti_rajamerkki.esitontti_id IS 'Vierasavain esitontti -tauluun.';
COMMENT ON COLUMN esitontti_rajamerkki.rajamerkkityyppi_id IS 'Vierasavain rajamerkkityypi -tauluun.';
COMMENT ON COLUMN esitontti_rajamerkki.pistenumero IS 'Rajamerkin pistenumero.';
COMMENT ON COLUMN esitontti_rajamerkki.geom IS 'Rajamerkin geometria.';
COMMENT ON COLUMN esitontti_rajamerkki.korvattu_id IS 'Korvattu objekti.';
COMMENT ON COLUMN esitontti_rajamerkki.korvaava_id IS 'Korvaava objekti.';
COMMENT ON COLUMN esitontti_rajamerkki.identiteettitunnus IS 'Identiteettitunnus.';
COMMENT ON COLUMN esitontti_rajamerkki.paikallinen_tunnus IS 'Paikallinen tunnus.';
COMMENT ON COLUMN esitontti_rajamerkki.laatija IS 'Laatijan tunniste.';
COMMENT ON COLUMN esitontti_rajamerkki.muokkaaja IS 'Muokkaajan tunniste.';
COMMENT ON COLUMN esitontti_rajamerkki.luontiaika IS 'Luontiaika.';
COMMENT ON COLUMN esitontti_rajamerkki.muokkausaika IS 'Muokkausaika.';

CREATE TABLE asiakirjalaji (
    id SERIAL PRIMARY KEY,
    lang CHAR(2) DEFAULT 'fi',
    koodi INTEGER,
    arvo CHARACTER VARYING(200)
);

ALTER TABLE asiakirjalaji ADD CONSTRAINT asiakirjalaji_koodi_kieli_unique UNIQUE (lang, koodi);

COMMENT ON TABLE asiakirjalaji IS 'Asiakirjalaji.';
COMMENT ON COLUMN asiakirjalaji.id IS 'Pääavain';
COMMENT ON COLUMN asiakirjalaji.lang IS 'Koodin kieli.';
COMMENT ON COLUMN asiakirjalaji.koodi IS 'Asiakirjalajin koodi.';
COMMENT ON COLUMN asiakirjalaji.arvo IS 'Asiakirjalajin koodin selite.';

CREATE TABLE asiakirja (
    id SERIAL PRIMARY KEY,
    tonttijakosuunnitelma_id BIGINT NOT NULL,
    asiakirjatunnus CHARACTER VARYING(300),
    asiakirjalaji_id INTEGER NOT NULL,
    lisatietolinkki CHARACTER VARYING(300),
    metatietolinkki CHARACTER VARYING(300),
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

ALTER TABLE asiakirja ADD CONSTRAINT asiakirja_tonttijakosuunnitelma_id_fk FOREIGN KEY (tonttijakosuunnitelma_id) REFERENCES tonttijakosuunnitelma(id);
ALTER TABLE asiakirja ADD CONSTRAINT asiakirja_asiakirjalaji_id_fk FOREIGN KEY (asiakirjalaji_id) REFERENCES asiakirjalaji(id);
ALTER TABLE asiakirja ADD CONSTRAINT asiakirja_korvattu_id_fk FOREIGN KEY (korvattu_id) REFERENCES asiakirja(id);
ALTER TABLE asiakirja ADD CONSTRAINT asiakirja_korvaava_id_fk FOREIGN KEY (korvaava_id) REFERENCES asiakirja(id);

COMMENT ON TABLE asiakirja IS 'Asiakirja.';
COMMENT ON COLUMN asiakirja.id IS 'Pääavain.';
COMMENT ON COLUMN asiakirja.tonttijakosuunnitelma_id IS 'Vierasavain tonttijakosuunnitelma -tauluun.';
COMMENT ON COLUMN asiakirja.asiakirjatunnus IS 'Asiakirjatunnus.';
COMMENT ON COLUMN asiakirja.asiakirjalaji_id IS 'Vierasavain asiakirjalaji -tauluun.';
COMMENT ON COLUMN asiakirja.lisatietolinkki IS 'Lisätietolinkki.';
COMMENT ON COLUMN asiakirja.metatietolinkki IS 'Metatietolinkki.';
COMMENT ON COLUMN asiakirja.korvattu_id IS 'Korvattu objekti.';
COMMENT ON COLUMN asiakirja.korvaava_id IS 'Korvaava objekti.';
COMMENT ON COLUMN asiakirja.identiteettitunnus IS 'Identiteettitunnus.';
COMMENT ON COLUMN asiakirja.paikallinen_tunnus IS 'Paikallinen tunnus.';
COMMENT ON COLUMN asiakirja.laatija IS 'Laatijan tunniste.';
COMMENT ON COLUMN asiakirja.muokkaaja IS 'Muokkaajan tunniste.';
COMMENT ON COLUMN asiakirja.luontiaika IS 'Luontiaika.';
COMMENT ON COLUMN asiakirja.muokkausaika IS 'Muokkausaika.';

-- TODO:
-- Muodostusluettelo -taulu?
