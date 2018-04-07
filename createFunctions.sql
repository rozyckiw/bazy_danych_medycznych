USE Oddzial_Okulistyczny;

DROP PROCEDURE IF EXISTS createPatient;

DELIMITER //

CREATE PROCEDURE createPatient
(
	patientName 	VARCHAR(30),
    patientSurname 	VARCHAR(50),
    pesel			VARCHAR(11),
	imiona_rodzicow VARCHAR(50),
	typ_dokumentu 	VARCHAR(50),
	seria_dokumentu VARCHAR(20),
	data_urodzenia 	DATE,
	miejsce_urodzenia VARCHAR(30),
	plec 			CHAR(1),
    telefon_kontaktowy INT,
    panstwo			VARCHAR(30),
    miasto			VARCHAR(30),
    ulica			VARCHAR(30),
    numer_domu		VARCHAR(7),
    kod_pocztowy	VARCHAR(10),
    gmina			VARCHAR(30),
    wojewodztwo		VARCHAR(30)
)
BEGIN
	
    INSERT INTO osoby (	imie, nazwisko, PESEL, imiona_rodzicow, typ_dokumentu, seria_dokumentu, data_urodzenia, miejsce_urodzenia, 
						telefon_kontaktowy, plec, panstwo, miasto, ulica, numer_domu, kod_pocztowy, gmina, wojewodztwo )
    VALUES( patientName, 	patientSurname, pesel, imiona_rodzicow, typ_dokumentu, seria_dokumentu, data_urodzenia, miejsce_urodzenia, 
							telefon_kontaktowy, plec, panstwo, miasto, ulica, numer_domu, kod_pocztowy, gmina, wojewodztwo );

END //

DROP PROCEDURE IF EXISTS createPersonel;

DELIMITER //

CREATE PROCEDURE createPersonel
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
    WHERE ( osoby.PESEL = pesel_pracownika );
    
    IF id_pracownika = -1 
    THEN LEAVE proc_label;
    END IF;
    
    INSERT INTO personel ( id_pracownika, data_zatrudnienia, specjalizacja )
    VALUES ( id_pracownika, data_zatrudnienia, specjalizacja );

END //


/*DROP PROCEDURE IF EXISTS loadDiseasesList;

DELIMITER //

CREATE PROCEDURE loadDiseasesList()
BEGIN

	LOAD DATA LOCAL INFILE 'C:\\Users\\19513\\Desktop\\Bazy_danych_medycznych\\Bazy_danych_medycznych\\ICD-10.txt' INTO TABLE Oddzial_Okulistyczny.Slownik_chorob
	CHARACTER SET utf8
	FIELDS TERMINATED BY '	'
	LINES TERMINATED BY '\n'
	(@col1, @col2,@col3, @col4)
	set kod = @col1, skrocony_opis = @col2, pelny_opis = @col3;

END //
*/




