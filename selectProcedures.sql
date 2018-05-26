USE oddzial_okulistyczny;

DELIMITER //

DROP VIEW IF EXISTS wybierzZakonczoneEpizody //

CREATE VIEW wybierzZakonczoneEpizody AS

    SELECT 
        ep.id_epizodu, 
        ep.data_rozp_epizodu, 
        ep.data_zak_epizodu, 
        ep.id_pacjenta AS 'ID pacjenta', 
        pacjent.imie AS 'Imie pacjenta',  
        pacjent.nazwisko AS 'Nazwisko pacjenta', 
        ep.id_pracownika AS 'ID pracownika', 
        pracownik.imie AS 'Imie pracownika', 
        pracownik.nazwisko AS 'Nazwisko pracownika', 
        per.data_zatrudnienia, 
        per.specjalizacja
	FROM 
		Epizod AS ep
	LEFT JOIN Osoby AS pacjent ON ( pacjent.id_osoby = ep.id_pacjenta )
    LEFT JOIN Personel AS per ON ( per.id_pracownika = ep.id_pracownika )
    LEFT JOIN Osoby AS pracownik ON ( pracownik.id_osoby = per.id_pracownika )
    WHERE ( ep.data_zak_epizodu IS NOT NULL ) //
    

DROP VIEW IF EXISTS wybierzOtwarteEpizody //

CREATE VIEW wybierzOtwarteEpizody AS

    SELECT 
        ep.id_epizodu, 
        ep.data_rozp_epizodu, 
        ep.data_zak_epizodu, 
        ep.id_pacjenta AS 'ID pacjenta', 
        pacjent.imie AS 'Imie pacjenta',  
        pacjent.nazwisko AS 'Nazwisko pacjenta', 
        ep.id_pracownika AS 'ID pracownika', 
        pracownik.imie AS 'Imie pracownika', 
        pracownik.nazwisko AS 'Nazwisko pracownika', 
        per.data_zatrudnienia, 
        per.specjalizacja
	FROM 
		Epizod AS ep
	LEFT JOIN Osoby AS pacjent ON ( pacjent.id_osoby = ep.id_pacjenta )
    LEFT JOIN Personel AS per ON ( per.id_pracownika = ep.id_pracownika )
    LEFT JOIN Osoby AS pracownik ON ( pracownik.id_osoby = per.id_pracownika )
    WHERE ( ep.data_zak_epizodu IS NULL ) //
    
    
DROP VIEW IF EXISTS wyswietlHistoriePacjentow //

CREATE VIEW wyswietlHistoriePacjentow AS

    SELECT 
        ep.id_epizodu, 
        ep.data_rozp_epizodu, 
        ep.data_zak_epizodu, 
        ep.id_pacjenta AS 'ID pacjenta', 
        pacjent.imie AS 'Imie pacjenta',  
        pacjent.nazwisko AS 'Nazwisko pacjenta', 
        ep.id_pracownika AS 'ID pracownika', 
        pracownik.imie AS 'Imie pracownika', 
        pracownik.nazwisko AS 'Nazwisko pracownika', 
        per.data_zatrudnienia, 
        per.specjalizacja
	FROM 
		Epizod AS ep
	LEFT JOIN Osoby AS pacjent ON ( pacjent.id_osoby = ep.id_pacjenta )
    LEFT JOIN Personel AS per ON ( per.id_pracownika = ep.id_pracownika )
    LEFT JOIN Osoby AS pracownik ON ( pracownik.id_osoby = per.id_pracownika ) //


DROP VIEW IF EXISTS wyswietlOsobyZWaznymUbezpieczeniem //

CREATE VIEW wyswietlOsobyZWaznymUbezpieczeniem AS

    SELECT 
		ub.nazwa_ubezpieczyciela,
        ub.numer_ubezpieczenia,
        ub.wazne_od,
        ub.wazne_do,
        Osoby.imie,  
        Osoby.nazwisko,
        Osoby.PESEL
	FROM 
		Ubezpieczenie AS ub
	LEFT JOIN Osoby ON ( Osoby.id_osoby = ub.id_osoby )
    WHERE ( CURDATE() BETWEEN ub.wazne_od AND ub.wazne_do ) //


/*DROP PROCEDURE IF EXISTS wyswietlOsobyZWaznymUbezpieczeniem //

CREATE PROCEDURE wyswietlOsobyZWaznymUbezpieczeniem()
BEGIN
	
    SELECT * FROM osoby
    LEFT JOIN ubezpieczenie ON ( ubezpieczenie.id_osoby = osoby.id_osoby )
    WHERE ( CURDATE() BETWEEN ubezpieczenie.wazne_od AND ubezpieczenie.wazne_do );
    
END //
*/

