SET search_path TO kii_staattinen_tieto, public;

INSERT INTO esitonttikohteen_laji (koodi, arvo) VALUES 
    ('01', 'Esitontti'),
    ('02', 'Esitonttirajapiste');

INSERT INTO tonttijakosuunnitelman_laji (koodi, arvo) VALUES 
    ('01', 'Asemakaavan yhteydessä hyväksyttävä tonttijakosuunnitelma'),
    ('02', 'Erillinen tonttijakosuunnitelma');

INSERT INTO tonttijakosuunnitelman_elinkaaren_tila (koodi, arvo) VALUES
    ('01', 'Vireillä'),
    ('02', 'Luonnos'),
    ('03', 'Ehdotus'),
    ('04', 'Hyväksytty'),
    ('05', 'Voimassa'),
    ('06', 'Kumottu osittain'),
    ('07', 'Kumottu kokonaan'),
    ('08', 'Kumoutunut osittain'),
    ('09', 'Kumoutunut kokonaan');

INSERT INTO suhde_peruskiinteistoon (koodi, arvo) VALUES
    ('101', 'Peruskiinteistön alapuolinen'),
    ('102', 'Peruskiinteistön yläpuolinen');

INSERT INTO asiakirjalaji (koodi, arvo) VALUES
    ('1', 'Rajamerkkiluettelo'),
    ('2', 'Laskupaperi'),
    ('3', 'Muodostusluettelo'),
    ('4', 'Tonttijakosuunnitelmakartta');
