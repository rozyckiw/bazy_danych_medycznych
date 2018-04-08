USE oddzial_okulistyczny;

DELIMITER //

DROP PROCEDURE IF EXISTS wybierzZakonczoneEpizody //

CREATE PROCEDURE wybierzZakonczoneEpizody()
BEGIN
	
    SELECT * FROM epizod
    WHERE ( epizod.data_zak_epizodu IS NOT NULL );
    
END //

DROP PROCEDURE IF EXISTS wybierzOtwarteEpizody //

CREATE PROCEDURE wybierzOtwarteEpizody()
BEGIN
	
    SELECT * FROM epizod
    WHERE ( epizod.data_zak_epizodu IS NULL );
    
END //

DROP PROCEDURE IF EXISTS wyswietlHistoriePacjenta //

CREATE PROCEDURE wyswietlHistoriePacjenta
(
	id_pacjenta INT
)
BEGIN
	
    SELECT * FROM epizod
    WHERE ( epizod.id_pacjenta = id_pacjenta );
    
END //

DROP PROCEDURE IF EXISTS wyswietlOsobyZWaznymUbezpieczeniem //

CREATE PROCEDURE wyswietlOsobyZWaznymUbezpieczeniem()
BEGIN
	
    SELECT * FROM osoby
    LEFT JOIN ubezpieczenie ON ( ubezpieczenie.id_osoby = osoby.id_osoby )
    WHERE ( CURDATE() BETWEEN ubezpieczenie.wazne_od AND ubezpieczenie.wazne_do );
    
END //