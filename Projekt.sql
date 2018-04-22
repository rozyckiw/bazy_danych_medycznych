DROP DATABASE IF EXISTS Oddzial_Okulistyczny;
CREATE DATABASE Oddzial_Okulistyczny;

USE Oddzial_Okulistyczny;

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
    
    CREATE TABLE Personel (
		
        id_personelu 		INT AUTO_INCREMENT PRIMARY KEY,
        id_pracownika 		INT NOT NULL,
        data_zatrudnienia 	DATE,
        data_zwolnienia 	DATE,
        specjalizacja 		CHAR(1) NOT NULL CHECK (specjalizacja IN ('P', 'L')), #P - Pielęgniarka, L - Lekarz
        FOREIGN KEY (id_pracownika) REFERENCES Osoby( id_osoby )    
    );
    
    SELECT 'Stworzono lekarzy';
    
    CREATE TABLE Slownik_chorob (
		
        kod VARCHAR(7) PRIMARY KEY,
        skrocony_opis VARCHAR(150) NOT NULL,
        pelny_opis VARCHAR(200) NOT NULL
    );
    
    SELECT 'Stworzono slownik chorób';
    
    CREATE TABLE Ubezpieczenie (
    
		id_osoby INT NOT NULL,
        nazwa_ubezpieczyciela VARCHAR(50) NOT NULL,
        numer_ubezpieczenia VARCHAR(50) PRIMARY KEY,
        wazne_od DATE NOT NULL,
        wazne_do DATE NOT NULL,
        FOREIGN KEY (id_osoby) REFERENCES Osoby( id_osoby ) 
    );
    
    CREATE TABLE Slownik_procedur_medycznych (
		
        id_procedury varchar(6) PRIMARY KEY,
        nazwa_procedury VARCHAR(50) NOT NULL    
    );
    
    CREATE TABLE Slownik_lekow (
		
        id_leku INT AUTO_INCREMENT PRIMARY KEY,
        nazwa_leku varchar(20) NOT NULL
    );
    
    SELECT 'Stworzono slownik lekow';
    
    # Dodać trigger, który blokuje wstawienie personelu innego niż Lekarz
    CREATE TABLE Epizod (
    
		id_epizodu INT AUTO_INCREMENT PRIMARY KEY,
        data_rozp_epizodu DATETIME DEFAULT NOW(),
        data_zak_epizodu DATE,
        id_personelu INT NOT NULL,
        id_pacjenta INT NOT NULL,
        FOREIGN KEY (id_personelu) REFERENCES Personel( id_personelu ),
        FOREIGN KEY (id_pacjenta) REFERENCES Osoby( id_osoby )
    );
    
    SELECT 'Stworzono epizody';
    
    CREATE TABLE Archiwum (
		
        id_epizodu INT PRIMARY KEY,
        data_rozp_epizodu DATE NOT NULL,
        data_zak_epizodu DATE NOT NULL,
        id_personelu INT NOT NULL,
        id_pacjenta INT NOT NULL,
        FOREIGN KEY (id_personelu) REFERENCES Personel( id_personelu ),
        FOREIGN KEY (id_pacjenta) REFERENCES Osoby( id_osoby )
    );
    
	CREATE TABLE Zlecenia_lekow (
		
        id_zlecenia INT AUTO_INCREMENT PRIMARY KEY,
        id_leku INT NOT NULL,
        id_epizodu INT NOT NULL,
        dawka VARCHAR(30) NOT NULL,
        FOREIGN KEY (id_leku) REFERENCES Slownik_lekow( id_leku ),
        FOREIGN KEY (id_epizodu) REFERENCES Epizod( id_epizodu )
    );
    SELECT 'Stworzono zlecenia lekow';
    
	CREATE TABLE Skierowanie (
		
        id_skierowania INT AUTO_INCREMENT PRIMARY KEY,
        id_epizodu INT NOT NULL,
        id_personelu INT NOT NULL,
        data_skierowania DATE NOT NULL,
        rozpoznanie VARCHAR(500) NOT NULL,
        FOREIGN KEY (id_epizodu) REFERENCES Epizod( id_epizodu ) 
    );
    SELECT 'Stworzono skierowania';
    
	CREATE TABLE Diagnoza (
    
		id_diagnozy INT AUTO_INCREMENT PRIMARY KEY,
        id_choroba_glowna VARCHAR(7) NOT NULL,
        id_choroby_wspolist VARCHAR(50),
        id_epizodu INT NOT NULL,
        FOREIGN KEY (id_choroba_glowna) REFERENCES Slownik_chorob( kod ),
        FOREIGN KEY (id_epizodu) REFERENCES Epizod( id_epizodu )
    );
    
    SELECT 'Stworzono diagnozy';
    
	CREATE TABLE Zlecenie_badania (
		
        id_zlecenia INT AUTO_INCREMENT PRIMARY KEY,
        id_uslugi varchar(6) NOT NULL,
        id_personelu INT NOT NULL,
        data_zlecenia DATE NOT NULL,
        id_epizodu INT NOT NULL,
        FOREIGN KEY (id_uslugi) REFERENCES Slownik_procedur_medycznych( id_procedury ),
        FOREIGN KEY (id_epizodu) REFERENCES Epizod( id_epizodu ) 
    );    
    
    SELECT 'Stworzono zlecenia badan';
	
END //

CALL createTables();
