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