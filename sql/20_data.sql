INSERT INTO tonttijakosuunnitelman_laji (koodi, arvo) VALUES 
    (3002, 'Asemakaavaan sisältyvä sitova tonttijako'),
    (3003, 'Erillinen sitova tonttijako'),
    (3004, 'Sitova kolmiulotteinen tonttijako');

INSERT INTO tonttijakosuunnitelman_elinkaaren_tila (koodi, arvo) VALUES
    (4, 'Vireillä oleva tonttijakosuunnitelma'),
    (6, 'Hyväksytty tonttijakosuunnitelma'),
    (100, 'Kumottu'),
    (101, 'Rauennut'),
    (102, 'Kumottu osittain');

INSERT INTO olotila (koodi, arvo) VALUES
    (1, 'Voimassaoleva'),
    (2, 'Lakannut');

INSERT INTO suhde_peruskiinteistoon (koodi, arvo) VALUES
    (101, 'Alapuolinen'),
    (102, 'Yläpuolinen');

INSERT INTO rajamerkkityyppi (koodi, arvo) VALUES
    (1, 'Tonttipyykki'),
    (2, 'Yleisen alueen pyykki'),
    (3, 'Maarekisteripyykki'),
    (4, 'Rajapiste'),
    (5, 'Tuntematon'),
    (6, 'Rajaviitta'),
    (7, 'Suuntapyykki'),
    (8, 'Tiealueen paalu'),
    (9, 'Esitonttirajamerkki');

INSERT INTO asiakirjalaji (koodi, arvo) VALUES
    (1, 'Rajamerkkiluettelo'),
    (2, 'Laskupaperi'),
    (3, 'Muodostusluettelo'),
    (4, 'Tonttijakosuunnitelmakartta');

INSERT INTO rekisteriyksikkolaji (koodi, arvo) VALUES
    (1, 'Tila'),
    (3, 'Valtion metsämaa'),
    (4, 'Lunastusyksikkö'),
    (7, 'Erillinen vesijättö'),
    (8, 'Yleinen vesialue'),
    (10, 'Yhteismetsä'),
    (12, 'Lakkautettu tie- tai liitännäisalue'),
    (13, 'Tontti'),
    (14, 'Yleinen alue'),
    (17, 'Yhteinen vesialue'),
    (18, 'Yhteinen maa-alue'),
    (19, 'Suojelualuekiinteistö'),
    (21, 'Tie- tai liitännäisalue tieoikeudella'),
    (22, 'Tie- tai liitännäisalue omistusoikeudella');

INSERT INTO rekisteriyksikon_elinkaaren_tila (koodi, arvo) VALUES
    (1, 'Luonnos'),
    (2, 'Esirekisteritila'),
    (3, 'Rekisteröity'),
    (4, 'Lakannut');

INSERT INTO yleisen_alueen_tyyppi (koodi, arvo) VALUES
    (9901, 'K katu'),
    (9902, 'G tori'),
    (9903, 'P puisto'),
    (9904, 'U urheilualue'),
    (9905, 'R retkeilyalue'),
    (9906, 'L loma-alue'),
    (9907, 'V vaara-alue'),
    (9908, 'E erityisalue'),
    (9909, 'W vesialue');

INSERT INTO kayttooikeusyksikkolaji (koodi, arvo) VALUES
    (101, 'Talousveden ottaminen'),
    (102, 'Talousveden johtaminen'),
    (103, 'Vesijohto'),
    (104, 'Veden johtaminen maan kuivattamista varten'),
    (105, 'Viemärijohto'),
    (106, 'Puhelinjohto'),
    (107, 'Sähköjohto'),
    (108, 'Kaasujohto'),
    (109, 'Lämpöjohto'),
    (110, 'Johto'),
    (112, 'Venevalkama'),
    (114, 'Laituri'),
    (115, 'Uimapaikka'),
    (116, 'Puutavaran varastointi'),
    (117, 'Lastauspaikka'),
    (118, 'Kalastusta varten tarvittava alue'),
    (119, 'Kiven ottaminen'),
    (120, 'Soran ottaminen'),
    (121, 'Hiekan ottaminen'),
    (122, 'Saven ottaminen'),
    (123, 'Turpeen ottaminen'),
    (124, 'Maa-aineksen ottaminen'),
    (125, 'Väestösuojelua varten tarvittava rakennelma'),
    (126, 'Kiinteistöjen yhteinen lämpökeskus'),
    (127, 'Jätteiden kokoamispaikka'),
    (128, 'Kulkuyhteys asemakaava-alueella'),
    (130, 'Sadevesiviemäri'),
    (131, 'Jäteveden johtaminen ja käsittely'),
    (132, 'Ajoneuvojen pitäminen'),
    (133, 'Venevalkama ja ajoneuvojen pitäminen'),
    (134, 'Ajoneuvojen pitäminen, venevalkama ja laituri'),
    (135, 'Yhteispiha'),
    (9101, 'Talousveden ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9102, 'Talousveden johtaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9103, 'Vesijohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9104, 'Veden johtaminen maan kuivattamista varten, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9105, 'Viemärijohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9106, 'Puhelinjohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9107, 'Sähköjohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9108, 'Kaasujohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9109, 'Lämpöjohto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9110, 'Johto, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9111, 'Autojen pitäminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9112, 'Venevalkama, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9113, 'Venevalkama ja autojen pitäminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9114, 'Laituri, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9115, 'Uimapaikka, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9116, 'Puutavaran varastointi, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9117, 'Lastauspaikka, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9118, 'Kalastusta varten tarvittava alue, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9119, 'Kiven ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9120, 'Soran ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9121, 'Hiekan ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9122, 'Saven ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9123, 'Turpeen ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9124, 'Maa-aineksen ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9125, 'Väestösuojelua varten tarvittava rakennelma, kaikkia oikeutettuja, Lakannut'),
    (9126, 'Kiinteistöjen yhteinen lämpökeskus, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9127, 'Jätteiden kokoamispaikka, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9128, 'Kulkuyhteys asemakaava-alueella, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9129, 'Autojen pitäminen, venevalkama ja laituri, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9130, 'Sadevesiviemäri, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9190, 'Veden ottaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9191, 'Veden johtaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9192, 'Veden patoaminen, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9193, 'Kalastus, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9194, 'Muuntaja, kaikkia oikeutettuja ei ole selvitetty, Lakannut'),
    (9301, 'Tieoikeus, kaikkia oikeutettuja ei ole selvitetty, Lakannut');

INSERT INTO rakenne (koodi, arvo) VALUES
    (1, 'Putki'),
    (2, 'Pultti'),
    (3, 'Yksikivinen'),
    (4, 'Nelikulmainen'),
    (5, 'Viisikivinen'),
    (6, 'Yksipaaluinen'),
    (7, 'Viisipaaluinen'),
    (8, 'Reikä, ura, putki, pultti'),
    (9, 'Peräkkäiset kivet'),
    (10, 'Peräkkäiset puupaalut'),
    (11, 'Oja');

INSERT INTO maaraalan_olotila (koodi, arvo) VALUES
    (1, 'Erottamaton'),
    (2, 'Muodostettu osittain rekisteriyksiköksi'),
    (3, 'Lakannut'),
    (4, 'Virheellisesti rekisteröity');

INSERT INTO olemassaolo (koodi, arvo) VALUES
    (1, 'Tuntematon'),
    (2, 'Olemassa'),
    (3, 'Kadonnut'),
    (4, 'Ei rakennettu');

INSERT INTO nakyvyys (koodi, arvo) VALUES
    (1, 'Tuntematon'),
    (2, 'Näkyvissä'),
    (3, 'Upotettu');

INSERT INTO alusta (koodi, arvo) VALUES
(1, 'Ei tietoa'),
(2, 'Kallio'),
(3, 'Maaperäkivi'),
(4, 'Sokkeli'),
(5, 'Seinä'),
(6, 'Katto'),
(7, 'Asfaltti'),
(8, 'Puu'),
(9, 'Maaperä');