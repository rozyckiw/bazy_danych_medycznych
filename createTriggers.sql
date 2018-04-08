USE oddzial_okulistyczny;

DELIMITER //

DROP TRIGGER IF EXISTS zablokuj_wstawienie_epizodu //

CREATE TRIGGER zablokuj_wstawienie_epizodu BEFORE INSERT ON epizod
FOR EACH ROW
BEGIN

	DECLARE id_pracownika INT;
    SET @id_pracownika := NEW.id_personelu;
    
    IF ( NOT EXISTS ( SELECT * FROM personel WHERE ( personel.id_pracownika = id_pracownika AND personel.specjalizacja = 'L' ) ) )
    THEN
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = "Podane id lekarza nie wskazuje na lekarza";
    END IF;

END //

DROP TRIGGER IF EXISTS dodaj_do_archiwum //

CREATE TRIGGER dodaj_do_archiwum BEFORE DELETE ON epizod
FOR EACH ROW
BEGIN

	INSERT INTO archiwum SELECT * FROM OLD;

END //
