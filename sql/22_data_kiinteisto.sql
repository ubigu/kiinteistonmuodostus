SET search_path TO kii_staattinen_tieto, public;

INSERT INTO rajamerkin_alusta (koodi, arvo) VALUES
    ('1', 'ei tietoa'),
    ('2', 'kallio'),
    ('3', 'maaperäkivi'),
    ('4', 'sokkeli'),
    ('5', 'seinä'),
    ('6', 'katto'),
    ('7', 'asfaltti'),
    ('8', 'puu'),
    ('9', 'maaperä');

INSERT INTO rajamerkin_nakyvyys (koodi, arvo) VALUES
    ('1', 'tuntematon'),
    ('2', 'näkyvissä'),
    ('3', 'upotettu');

INSERT INTO rajamerkin_rakenne (koodi, arvo) VALUES
    ('1', 'putki'),
    ('2', 'pultti'),
    ('3', 'yksikivinen'),
    ('4', 'nelikulmainen'),
    ('5', 'viisikivinen'),
    ('6', 'yksipaaluinen'),
    ('7', 'viisipaaluinen'),
    ('8', 'reikä, ura, putki, pultti'),
    ('9', 'peräkkäiset kivet'),
    ('10', 'peräkkäiset puupaalut'),
    ('11', 'oja');

INSERT INTO rajamerkkilaji (koodi, arvo) VALUES
    ('1', 'Tonttipyykki'),
    ('2', 'Yleisen alueen pyykki'),
    ('3', 'Maarekisteripyykki'),
    ('4', 'Rajapiste'),
    ('5', 'Tuntematon'),
    ('6', 'Rajaviitta'),
    ('7', 'Suuntapyykki'),
    ('8', 'Tiealueen paalu');

INSERT INTO kohdeyksikko (koodi, arvo) VALUES
    ('1', 'Rekisteriyksikkö'),
    ('2', 'Käyttöoikeusyksikkö'),
    ('3', 'Määräala'),
    ('4', 'Vuokra-alue'),
    ('5', 'Rajamerkki');

INSERT INTO rajamerkin_elinkaaren_tila (koodi, arvo) VALUES
    ('1', 'Tuntematon'),
    ('2', 'Olemassa'),
    ('3', 'Kadonnut'),
    ('4', 'Ei rakennettu');

INSERT INTO rekisteriyksikkolaji (koodi, arvo) VALUES
    ('1', 'Tila'),
    ('3', 'Valtion metsämaa'),
    ('4', 'Lunastusyksikkö'),
    ('7', 'Erillinen vesijättö'),
    ('8', 'Yleinen vesialue'),
    ('10', 'Yhteismetsä'),
    ('12', 'Lakkautettu tie- tai liitännäisalue'),
    ('13', 'Tontti'),
    ('14', 'Yleinen alue'),
    ('17', 'Yhteinen vesialue'),
    ('18', 'Yhteinen maa-alue'),
    ('19', 'Suojelualuekiinteistö'),
    ('21', 'Tie- tai liitännäisalue tieoikeudella'),
    ('22', 'Tie- tai liitännäisalue omistusoikeudella');

INSERT INTO rekisteriyksikon_elinkaaren_tila (koodi, arvo) VALUES
    ('1', 'Luonnos'),
    ('2', 'Esirekisteritila'),
    ('3', 'Rekisteröity'),
    ('4', 'Lakannut');

INSERT INTO yleisen_alueen_tyyppi (koodi, arvo) VALUES
    ('9901', 'K katu'),
    ('9902', 'G tori'),
    ('9903', 'P puisto'),
    ('9904', 'U urheilualue'),
    ('9905', 'R retkeilyalue'),
    ('9906', 'L loma-alue'),
    ('9907', 'V vaara-alue'),
    ('9908', 'E erityisalue'),
    ('9909', 'W vesialue');

INSERT INTO kayttooikeusyksikkolaji (koodi, arvo) VALUES
    ('101', 'Talousveden ottaminen'),
    ('102', 'Talousveden johtaminen'),
    ('103', 'Vesijohto'),
    ('104', 'Veden johtaminen maan kuivattamista varten'),
    ('105', 'Viemärijohto'),
    ('106', 'Puhelinjohto'),
    ('107', 'Sähköjohto'),
    ('108', 'Kaasujohto'),
    ('109', 'Lämpöjohto'),
    ('110', 'Johto'),
    ('112', 'Venevalkama'),
    ('114', 'Laituri'),
    ('115', 'Uimapaikka'),
    ('116', 'Puutavaran varastointi'),
    ('117', 'Lastauspaikka'),
    ('118', 'Kalastusta varten tarvittava alue'),
    ('119', 'Kiven ottaminen'),
    ('120', 'Soran ottaminen'),
    ('121', 'Hiekan ottaminen'),
    ('122', 'Saven ottaminen'),
    ('123', 'Turpeen ottaminen'),
    ('124', 'Maa-aineksen ottaminen'),
    ('125', 'Väestösuojelua varten tarvittava rakennelma'),
    ('126', 'Kiinteistöjen yhteinen lämpökeskus'),
    ('127', 'Jätteiden kokoamispaikka'),
    ('128', 'Kulkuyhteys asemakaava-alueella'),
    ('130', 'Sadevesiviemäri'),
    ('131', 'Jäteveden johtaminen ja käsittely'),
    ('132', 'Ajoneuvojen pitäminen'),
    ('133', 'Venevalkama ja ajoneuvojen pitäminen'),
    ('134', 'Ajoneuvojen pitäminen, venevalkama ja laituri'),
    ('135', 'Yhteispiha'),
    ('9101', 'Talousveden ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9102', 'Talousveden johtaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9103', 'Vesijohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9104', 'Veden johtaminen maan kuivattamista varten, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9105', 'Viemärijohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9106', 'Puhelinjohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9107', 'Sähköjohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9108', 'Kaasujohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9109', 'Lämpöjohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9110', 'Johto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9111', 'Autojen pitäminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9112', 'Venevalkama, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9113', 'Venevalkama ja autojen pitäminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9114', 'Laituri, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9115', 'Uimapaikka, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9116', 'Puutavaran varastointi, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9117', 'Lastauspaikka, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9118', 'Kalastusta varten tarvittava alue, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9119', 'Kiven ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9120', 'Soran ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9121', 'Hiekan ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9122', 'Saven ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9123', 'Turpeen ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9124', 'Maa-aineksen ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9125', 'Väestösuojelua varten tarvittava rakennelma, kaikkia oikeutettuja, Lakannut'),
    ('9126', 'Kiinteistöjen yhteinen lämpökeskus, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9127', 'Jätteiden kokoamispaikka, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9128', 'Kulkuyhteys asemakaava-alueella, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9129', 'Autojen pitäminen, venevalkama ja laituri, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9130', 'Sadevesiviemäri, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9190', 'Veden ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9191', 'Veden johtaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9192', 'Veden patoaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9193', 'Kalastus, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9194', 'Muuntaja, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    ('9301', 'Tieoikeus, kaikkia oikeutettuja ei ole selvitetty, Lakannut');

INSERT INTO maaraalan_elinkaaren_tila (koodi, arvo) VALUES
    ('1', 'Erottamaton'),
    ('2', 'Muodostettu osittain rekisteriyksiköksi'),
    ('3', 'Lakannut'),
    ('4', 'Virheellisesti rekisteröity');