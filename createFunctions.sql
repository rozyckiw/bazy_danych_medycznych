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
    VALUES( @imie_pacjenta, @nazwisko_pacjenta, @pesel, @imiona_rodzicow, @typ_dokumentu, @seria_dokumentu, @data_urodzenia, @miejsce_urodzenia, 
							@telefon_kontaktowy, @plec, @panstwo, @miasto, @ulica, @numer_domu, @kod_pocztowy, @gmina, @wojewodztwo );

END //

DROP PROCEDURE IF EXISTS stworzPracownika //

CREATE PROCEDURE stworzPracownika
(
	pesel_pracownika		INT,
    data_zatrudnienia		DATE,
    specjalizacja			CHAR(1)
)
proc_label : BEGIN

	DECLARE id_pracownika INT;
    SET @id_pracownika := -1;
    
    SELECT @id_pracownika := id_osoby 
    FROM osoby
    WHERE ( osoby.PESEL = @pesel_pracownika );
    
    IF @id_pracownika = -1 
    THEN LEAVE proc_label;
    END IF;
    
    INSERT INTO personel ( id_pracownika, data_zatrudnienia, specjalizacja )
    VALUES ( @id_pracownika, @data_zatrudnienia, @specjalizacja );

END //

DROP PROCEDURE IF EXISTS stworzUbezpieczenie //

CREATE PROCEDURE stworzUbezpieczenie
(
	pesel_osoby 		VARCHAR(11),
    nazwa_ubezpieczenia VARCHAR(50),
    numer_ubezpieczenia VARCHAR(50),
    wazne_od			DATE,
    wazne_do			DATE
)
proc_label : BEGIN

	DECLARE id_osoby INT;
    SET @id_osoby := -1;
    
    SELECT @id_osoby := id_osoby 
    FROM osoby
    WHERE ( osoby.PESEL = @pesel_osoby );
    
    IF @id_osoby = -1 
    THEN LEAVE proc_label;
    END IF;

	INSERT INTO ubezpieczenie
    VALUES ( @id_osoby, @nazwa_ubezpieczyciela, @numer_ubezpieczenia, @wazne_od, @wazne_do );

END //

DROP PROCEDURE IF EXISTS stworzEpizod //

CREATE PROCEDURE stworzEpizod
(
	pesel_lekarza 	VARCHAR(11),
    pesel_pacjenta	VARCHAR(11)
)
proc_label : BEGIN

	DECLARE id_lekarza 	INT;
	DECLARE id_pacjenta INT;
            
    SET @id_lekarza := -1;
    SET @id_pacjenta := -1;
    
    SELECT @id_lekarza := id_osoby 
    FROM osoby
    WHERE ( osoby.PESEL = @id_lekarza );
    
    IF @id_lekarza = -1 
    THEN LEAVE proc_label;
    END IF;
    
	SELECT @id_pacjenta := id_osoby 
    FROM osoby
    WHERE ( osoby.PESEL = @id_pacjenta );
    
    IF @id_pacjenta = -1 
    THEN LEAVE proc_label;
    END IF;

	INSERT INTO epizod ( id_personelu, id_pacjenta )
    VALUES ( @id_lekarza, @id_pacjenta );

END //

DROP PROCEDURE IF EXISTS stworz_Zlecenie_Leku //

CREATE PROCEDURE stworz_Zlecenie_Leku
(
	id_leku		INT,
    id_epizodu	INT,
    dawka		VARCHAR(30)
)
proc_label : BEGIN
    
    IF ( ( NOT EXISTS( SELECT * FROM Slownik_lekow WHERE ( Slownik_lekow.id_leku = @id_leku ) ) )
		OR ( NOT EXISTS( SELECT * FROM Epizod WHERE ( Epizod.id_epizodu = @id_epizodu ) ) ) )
    THEN
		LEAVE proc_label;
    END IF;
    
    INSERT INTO Zlecenia_lekow ( id_leku, id_epizodu, dawka )
    VALUES ( @id_leku, @id_epizodu, @dawka );

END //

DROP PROCEDURE IF EXISTS stworzSkierowanie //

CREATE PROCEDURE stworzSkierowanie
(
    id_epizodu			INT,
    pesel_lekarza		VARCHAR(11),
    data_skierowania 	DATE,
    rozpoznanie			VARCHAR(500)
)
proc_label : BEGIN
    
    DECLARE id_pracownika	INT;
    SET 	@id_pracownika := -1;
    
    IF ( NOT EXISTS( SELECT * FROM Epizod WHERE ( Epizod.id_epizodu = @id_epizodu ) ) )
    THEN
		LEAVE proc_label;
    END IF;
    
    SELECT @id_pracownika = id_osoby 
    FROM osoby
    WHERE ( osoby.PESEL = @pesel_lekarza );
    
    IF ( @id_pracownika = -1 )
    THEN LEAVE proc_label;
    END IF;
    
    INSERT INTO Skierowanie ( id_epizodu, id_personelu, data_skierowania, rozpoznanie )
    VALUES ( @id_epizodu, @id_pracownika, @data_skierowania, @rozpoznanie );

END //

DROP PROCEDURE IF EXISTS stworz_Diagnoze //

CREATE PROCEDURE stworz_Diagnoze
(
	id_glownej_choroby		VARCHAR(7),
    choroby_wspolistniejace	VARCHAR(50),
    id_epizodu				int
)
proc_label : BEGIN
    
    IF ( ( NOT EXISTS( SELECT * FROM Slownik_chorob WHERE ( Slownik_chorob.kod = @id_glownej_choroby ) ) )
		OR ( NOT EXISTS( SELECT * FROM Epizod WHERE ( Epizod.id_epizodu = @id_epizodu ) ) ) )
    THEN
		LEAVE proc_label;
    END IF;
    
    INSERT INTO Diagnoza ( id_choroba_glowna, id_choroby_wspolist, id_epizodu )
    VALUES ( @id_glownej_choroby, @choroby_wspolistniejace, @id_epizodu );

END //

DROP PROCEDURE IF EXISTS stworz_Zlecenie_badania //

CREATE PROCEDURE stworz_Zlecenie_badania
(
	id_uslugi 			INT,
	pesel_pracownika 	VARCHAR(11),
	data_zlecenia 		DATE,
	id_epizodu 			INT
)
proc_label : BEGIN

	DECLARE id_pracownika INT;
    SET @id_pracownika := -1;
    
    IF ( ( NOT EXISTS( SELECT * FROM Slownik_procedur_medycznych WHERE ( Slownik_procedur_medycznych.id_uslugi = @id_uslugi ) ) )
		OR ( NOT EXISTS( SELECT * FROM Epizod WHERE ( Epizod.id_epizodu = @id_epizodu ) ) ) )
    THEN
		LEAVE proc_label;
    END IF;
    
    SELECT @id_pracownika := id_osoby 
    FROM osoby
    WHERE ( osoby.PESEL = @pesel_pracownika );
    
    IF ( @id_pracownika = -1 )
    THEN LEAVE proc_label;
    END IF;    
    
    INSERT INTO Zlecenie_badania ( id_uslugi, id_personelu, data_zlecenia, id_epizodu )
    VALUES ( @id_uslugi, @id_personelu, @data_zlecenia, @id_epizodu );

END //


/*
LOAD DATA LOCAL INFILE 'C:\\Users\\19513\\Desktop\\Bazy_danych_medycznych\\Bazy_danych_medycznych\\ICD-10.txt' 
INTO TABLE Oddzial_Okulistyczny.Slownik_chorob
CHARACTER SET UTF8
FIELDS TERMINATED BY '	'
LINES TERMINATED BY '\n'
(@col1, @col2,@col3, @col4)
SET kod = @col1, skrocony_opis = @col2, pelny_opis = @col3;
*/

