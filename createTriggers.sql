USE oddzial_okulistyczny;

DELIMITER //

DROP TRIGGER IF EXISTS zablokuj_wstawienie_epizodu //

CREATE TRIGGER zablokuj_wstawienie_epizodu BEFORE INSERT ON epizod
FOR EACH ROW
BEGIN

	DECLARE pracownik INT;
    
    SELECT id_pracownika 
    INTO pracownik
    FROM personel 
    WHERE ( personel.id_personelu = NEW.id_personelu );
    
    IF ( NOT EXISTS ( SELECT * FROM personel WHERE ( personel.id_pracownika = pracownik AND personel.specjalizacja = 'L' ) ) 
			OR ( pracownik = NEW.id_pacjenta ) )
    THEN
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = "Podane id lekarza nie wskazuje na lekarza lub lekarz jest tą samą osobą co pacjent";
    END IF;
	
END //

