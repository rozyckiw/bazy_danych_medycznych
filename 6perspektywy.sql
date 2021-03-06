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


DROP VIEW IF EXISTS wyswietlChorobyPacjentow //

CREATE VIEW wyswietlChorobyPacjentow AS

    SELECT 
		pacjent.imie,
        pacjent.nazwisko,
        FLOOR( DATEDIFF( CURDATE(), pacjent.data_urodzenia ) / 365 ) AS 'Wiek',
		choroba.kod AS 'Kod choroby',
        choroba.skrocony_opis AS 'Opis choroby'
	FROM 
		Slownik_chorob AS choroba
	LEFT JOIN Diagnoza AS diag ON ( diag.id_choroba_glowna = choroba.kod )
    LEFT JOIN Epizod AS ep ON ( ep.id_epizodu = diag.id_epizodu )
    LEFT JOIN Osoby AS pacjent ON ( pacjent.id_osoby = ep.id_pacjenta )
    WHERE( pacjent.imie IS NOT NULL )
    GROUP by choroba.kod //
    
DROP VIEW IF EXISTS wyswietlLekiPacjentow //
    
CREATE VIEW wyswietlLekiPacjentow AS

    SELECT 
		pacjent.imie,
        pacjent.nazwisko,
        FLOOR( DATEDIFF( CURDATE(), pacjent.data_urodzenia ) / 365 ) AS 'Wiek',
		lek.id_leku AS 'Id leku',
        lek.nazwa_leku AS 'Opis leku'
	FROM 
		Slownik_lekow AS lek
	LEFT JOIN Zlecenia_lekow AS zlec ON ( zlec.id_leku = lek.id_leku )
    LEFT JOIN Epizod AS ep ON ( ep.id_epizodu = zlec.id_epizodu )
    LEFT JOIN Osoby AS pacjent ON ( pacjent.id_osoby = ep.id_pacjenta )
    WHERE( pacjent.imie IS NOT NULL )
    GROUP by pacjent.imie //
    

DROP VIEW IF EXISTS wyswietlLekarzy //
    
CREATE VIEW wyswietlLekarzy AS

    SELECT * FROM Osoby AS osoby, Personel AS presonel
    WHERE( id_osoby = id_pracownika and specjalizacja = 'L')
    GROUP by id_osoby //
    


DROP VIEW IF EXISTS wyswietlPielegniarki //
    
CREATE VIEW wyswietlPielegniarki AS

    SELECT * FROM Osoby AS osoby, Personel AS presonel
    WHERE( id_osoby = id_pracownika and specjalizacja = 'P')
    GROUP by id_osoby //
    
    
    
DROP VIEW IF EXISTS wyswietlPacjentow //
    
CREATE VIEW wyswietlPacjentow AS

    SELECT * FROM Osoby AS osoby, Epizod AS epizod
    WHERE( id_osoby = id_pacjenta)
    GROUP by id_osoby//
    
    
    
DROP VIEW IF EXISTS wyswietlWszystkieZleconeBadania //
    
CREATE VIEW wyswietlWszystkieZleconeBadania AS

    SELECT Zlecenie_badania.id_uslugi, Slownik_procedur_medycznych.nazwa_procedury 
    FROM Epizod AS epizod, Zlecenie_badania, Slownik_procedur_medycznych
    WHERE( Zlecenie_badania.id_epizodu = Epizod.id_epizodu 
			and Zlecenie_badania.id_uslugi = Slownik_procedur_medycznych.id_procedury)//
            
            
DROP VIEW IF EXISTS wyswietlSkierowania //
    
CREATE VIEW wyswietlSkierowania AS

    SELECT Skierowanie.id_skierowania, Osoby.imie, Osoby.nazwisko, Skierowanie.id_pracownika AS id_lekarza, 
			Skierowanie.data_skierowania, Skierowanie.rozpoznanie	
	FROM Skierowanie, Osoby, Epizod
    WHERE( Skierowanie.id_epizodu = Epizod.id_epizodu and Epizod.id_pacjenta = Osoby.id_osoby)
/*DROP PROCEDURE IF EXISTS wyswietlOsobyZWaznymUbezpieczeniem //

CREATE PROCEDURE wyswietlOsobyZWaznymUbezpieczeniem()
BEGIN
	
    SELECT * FROM osoby
    LEFT JOIN ubezpieczenie ON ( ubezpieczenie.id_osoby = osoby.id_osoby )
    WHERE ( CURDATE() BETWEEN ubezpieczenie.wazne_od AND ubezpieczenie.wazne_do );
    
END //
*/

