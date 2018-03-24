DROP DATABASE IF EXISTS Oddzial_Okulistyczny;
CREATE DATABASE Oddzial_Okulistyczny;

use Oddzial_Okulistyczny;
/*LOAD DATA LOCAL INFILE 'C:\\Users\\19513\\Desktop\\Bazy_danych_medycznych\\Bazy_danych_medycznych\\ICD-10.txt' INTO TABLE Oddzial_Okulistyczny.Slownik_chorob
CHARACTER SET utf8
FIELDS TERMINATED BY '	'
LINES TERMINATED BY '\n'
(@col1, @col2,@col3, @col4)
set kod = @col1, skrocony_opis = @col2, pelny_opis = @col3;
*/

DELIMITER //

CREATE PROCEDURE createTables()
BEGIN

	CREATE TABLE Osoby (	
		
        id_osoby INT AUTO_INCREMENT PRIMARY KEY,
        imie VARCHAR(30) NOT NULL,
        nazwisko VARCHAR(50) NOT NULL,
        PESEL VARCHAR(11),
        imiona_rodzicow VARCHAR(50) NOT NULL,
        typ_dokumentu VARCHAR(50) NOT NULL CHECK (typ_dokumentu IN ('Dowód osobisty', 'Paszport')),
        seria_dokumentu VARCHAR(20) NOT NULL,
        data_urodzenia date NOT NULL,
        miejsce_urodzenia VARCHAR(30),
        telefon_kontaktowy INT,
        plec CHAR(1) NOT NULL CHECK (plec IN ('K', 'M')),
		
        # Dane zamieszkania
        
        panstwo VARCHAR(30) NOT NULL,
        miasto VARCHAR(30) NOT NULL,
        ulica VARCHAR(30) NOT NULL,
        numer_domu VARCHAR(7) NOT NULL,
        kod_pocztowy VARCHAR(10) NOT NULL,
        gmina VARCHAR(30),
        wojewodztwo VARCHAR(30)
	);
    
    SELECT 'Stworzono osoby';
    
    CREATE TABLE Lekarze (
		
        id_lekarza INT AUTO_INCREMENT PRIMARY KEY,
        id_osoby INT NOT NULL,
        FOREIGN KEY (id_osoby) REFERENCES Osoby( id_osoby )    
    );
    
    SELECT 'Stworzono lekarzy';
    
    CREATE TABLE Slownik_chorob (
		
        kod VARCHAR(7) NOT NULL,
        skrocony_opis VARCHAR(150) NOT NULL,
        pelny_opis VARCHAR(200) NOT NULL
    );
    
    SELECT 'Stworzono slownik chorób';
	   
    CREATE TABLE Skierowanie (
		
        id_skierowania INT AUTO_INCREMENT PRIMARY KEY,
        id_pacjenta INT NOT NULL,
        id_lekarza INT NOT NULL,
        data_skierowania DATE NOT NULL,
        rozpoznanie VARCHAR(500) NOT NULL,
        FOREIGN KEY (id_pacjenta) REFERENCES Osoby( id_osoby ) 
    );
    
    CREATE TABLE Ubezpieczenie (
    
		id_osoby INT NOT NULL,
        nazwa_ubezpieczyciela VARCHAR(50) NOT NULL,
        numer_ubezpieczenia VARCHAR(50) PRIMARY KEY,
        wazne_od DATE NOT NULL,
        wazne_do DATE NOT NULL,
        FOREIGN KEY (id_osoby) REFERENCES Osoby( id_osoby ) 
    );
    
    CREATE TABLE Slownik_procedur_medycznych (
		
        id_procedury INT PRIMARY KEY,
        nazwa_procedury VARCHAR(50) NOT NULL    
    );
    
	
END //

CALL createTables();
