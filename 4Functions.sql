USE oddzial_okulistyczny;

DELIMITER //

DROP FUNCTION IF EXISTS imieNazwiskoOsoby//
 
CREATE FUNCTION imieNazwiskoOsoby(id_osoby INT) RETURNS VARCHAR(81)
    DETERMINISTIC
BEGIN
    DECLARE nazwa varchar(81);
	
    SET nazwa = (SELECT concat(imie , ' ' , nazwisko) FROM Osoby
    where Osoby.id_osoby = 2);
 
 RETURN (nazwa);
END //
