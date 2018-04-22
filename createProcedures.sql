USE Oddzial_Okulistyczny;

DELIMITER //


DROP PROCEDURE IF EXISTS stworzPacjenta //

CREATE PROCEDURE stworzPacjenta
(
	imie_pacjenta 		VARCHAR(30),
    nazwisko_pacjenta 	VARCHAR(50),
    pesel				VARCHAR(11),
	imiona_rodzicow 	VARCHAR(50),
	typ_dokumentu 		VARCHAR(50),
	seria_dokumentu 	VARCHAR(20),
	data_urodzenia 		DATE,
	miejsce_urodzenia 	VARCHAR(30),
	plec 				CHAR(1),
    telefon_kontaktowy 	INT,
    panstwo				VARCHAR(30),
    miasto				VARCHAR(30),
    ulica				VARCHAR(30),
    numer_domu			VARCHAR(7),
    kod_pocztowy		VARCHAR(10),
    gmina				VARCHAR(30),
    wojewodztwo			VARCHAR(30)
)
BEGIN
	
    INSERT INTO osoby (	imie, nazwisko, PESEL, imiona_rodzicow, typ_dokumentu, seria_dokumentu, data_urodzenia, miejsce_urodzenia, 
						telefon_kontaktowy, plec, panstwo, miasto, ulica, numer_domu, kod_pocztowy, gmina, wojewodztwo )
    VALUES( imie_pacjenta, nazwisko_pacjenta, pesel, imiona_rodzicow, typ_dokumentu, seria_dokumentu, data_urodzenia, miejsce_urodzenia, 
							telefon_kontaktowy, plec, panstwo, miasto, ulica, numer_domu, kod_pocztowy, gmina, wojewodztwo );

END //

DROP PROCEDURE IF EXISTS stworzPracownika //

CREATE PROCEDURE stworzPracownika
(
	id_pracownika		INT,
    data_zatrudnienia	DATE,
    specjalizacja		CHAR(1)
)
proc_label : BEGIN
    
    INSERT INTO personel ( id_pracownika, data_zatrudnienia, specjalizacja )
    VALUES ( id_pracownika, data_zatrudnienia, specjalizacja );

END //

DROP PROCEDURE IF EXISTS stworzUbezpieczenie //

CREATE PROCEDURE stworzUbezpieczenie
(
	id_osoby 			INT,
    nazwa_ubezpieczenia VARCHAR(50),
    numer_ubezpieczenia VARCHAR(50),
    wazne_od			DATE,
    wazne_do			DATE
)
BEGIN

	INSERT INTO ubezpieczenie
    VALUES ( id_osoby, nazwa_ubezpieczenia, numer_ubezpieczenia, wazne_od, wazne_do );

END //

DROP PROCEDURE IF EXISTS stworzEpizod //

CREATE PROCEDURE stworzEpizod
(
	id_lekarza 	INT,
    id_pacjenta	INT
)
BEGIN

	INSERT INTO epizod ( id_personelu, id_pacjenta )
    VALUES ( id_lekarza, id_pacjenta );

END //

DROP PROCEDURE IF EXISTS stworz_Zlecenie_Leku //

CREATE PROCEDURE stworz_Zlecenie_Leku
(
	id_leku		INT,
    id_epizodu	INT,
    dawka		VARCHAR(30)
)
proc_label : BEGIN
    
    IF ( ( NOT EXISTS( SELECT * FROM Slownik_lekow WHERE ( Slownik_lekow.id_leku = id_leku ) ) )
		OR ( NOT EXISTS( SELECT * FROM Epizod WHERE ( Epizod.id_epizodu = id_epizodu ) ) ) )
    THEN
		LEAVE proc_label;
    END IF;
    
    INSERT INTO Zlecenia_lekow ( id_leku, id_epizodu, dawka )
    VALUES ( id_leku, id_epizodu, dawka );

END //

DROP PROCEDURE IF EXISTS stworzSkierowanie //

CREATE PROCEDURE stworzSkierowanie
(
    id_epizodu			INT,
    id_lekarza			INT,
    data_skierowania 	DATE,
    rozpoznanie			VARCHAR(500)
)
proc_label : BEGIN
    
    IF ( NOT EXISTS( SELECT * FROM Epizod WHERE ( Epizod.id_epizodu = id_epizodu ) ) )
    THEN
		LEAVE proc_label;
    END IF;
    
    INSERT INTO Skierowanie ( id_epizodu, id_personelu, data_skierowania, rozpoznanie )
    VALUES ( id_epizodu, id_lekarza, data_skierowania, rozpoznanie );

END //

DROP PROCEDURE IF EXISTS stworz_Diagnoze //

CREATE PROCEDURE stworz_Diagnoze
(
	id_glownej_choroby		VARCHAR(7),
    choroby_wspolistniejace	VARCHAR(50),
    id_epizodu				INT
)
proc_label : BEGIN
    
    IF ( ( NOT EXISTS( SELECT * FROM Slownik_chorob WHERE ( Slownik_chorob.kod = id_glownej_choroby ) ) )
		OR ( NOT EXISTS( SELECT * FROM Epizod WHERE ( Epizod.id_epizodu = id_epizodu ) ) ) )
    THEN
		LEAVE proc_label;
    END IF;
    
    INSERT INTO Diagnoza ( id_choroba_glowna, id_choroby_wspolist, id_epizodu )
    VALUES ( id_glownej_choroby, choroby_wspolistniejace, id_epizodu );

END //

DROP PROCEDURE IF EXISTS stworz_Zlecenie_badania //

CREATE PROCEDURE stworz_Zlecenie_badania
(
	id_uslugi 			VARCHAR(6),
	id_pracownika 		INT,
	data_zlecenia 		DATE,
	id_epizodu 			INT
)
proc_label : BEGIN
    
    IF ( ( NOT EXISTS( SELECT * FROM Slownik_procedur_medycznych WHERE ( id_uslugi = id_uslugi ) ) )
		OR ( NOT EXISTS( SELECT * FROM Epizod WHERE ( Epizod.id_epizodu = id_epizodu ) ) ) )
    THEN
		LEAVE proc_label;
    END IF;
    
    INSERT INTO Zlecenie_badania ( id_uslugi, id_personelu, data_zlecenia, id_epizodu )
    VALUES ( id_uslugi, id_pracownika, data_zlecenia, id_epizodu );

END //
