USE oddzial_okulistyczny;

DELIMITER //


DROP PROCEDURE IF EXISTS usunEpizod //

CREATE PROCEDURE usunEpizod
(
	id_epizodu INT
)
BEGIN
	
    DELETE FROM epizod
    WHERE ( epizod.id_epizodu = id_epizodu );

END //

DROP PROCEDURE IF EXISTS usunOsobe //

CREATE PROCEDURE usunOsobe
(
	id_pacjenta INT
)
BEGIN
	
    DELETE FROM osoby
    WHERE ( osoby.id_osoby = id_pacjenta );

END //