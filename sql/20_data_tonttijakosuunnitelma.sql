INSERT INTO tonttijakosuunnitelman_laji (koodi, arvo) VALUES 
    (3002, 'Asemakaavaan sisältyvä sitova tonttijako'),
    (3003, 'Erillinen sitova tonttijako'),
    (3004, 'Sitova kolmiulotteinen tonttijako');

INSERT INTO tonttijakosuunnitelman_elinkaaren_tila (koodi, arvo) VALUES
    (0, 'Luonnos'),
    (1, 'Vireillä'),
    (2, 'Voimassa'),
    (3, 'Kumottu osittain'),
    (4, 'Kumottu kokonaan'),
    (5, 'Rauennut');

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
