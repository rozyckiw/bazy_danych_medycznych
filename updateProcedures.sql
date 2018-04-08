USE oddzial_okulistyczny;

DELIMITER //

DROP PROCEDURE IF EXISTS zakonczEpizodZData //

CREATE PROCEDURE zakonczEpizodZData
(
	id_epizodu 	INT,
    data_zak	DATE
)
BEGIN
	
	UPDATE epizod
    SET epizod.data_zak_epizodu = data_zak
    WHERE ( epizod.id_epizodu = id_epizodu );
    
END //

DROP PROCEDURE IF EXISTS zakonczEpizod //

CREATE PROCEDURE zakonczEpizod
(
	id_epizodu 	INT
)
BEGIN
	
	UPDATE epizod
    SET epizod.data_zak_epizodu = CURDATE()
    WHERE ( epizod.id_epizodu = id_epizodu );
    
END //