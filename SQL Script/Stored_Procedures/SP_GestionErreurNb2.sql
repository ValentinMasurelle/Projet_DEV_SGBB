
DROP PROCEDURE IF EXISTS ajouter_serie2;

DELIMITER $$
CREATE PROCEDURE ajouter_serie2(IN p_serie_id INT, IN p_serie_nom VARCHAR(200))
BEGIN
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SELECT 'Exit handler Duplicate Key';
    END;
    INSERT INTO serie (code_serie, nom_serie) VALUES (p_serie_id,p_serie_nom);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS ajouter_serie3;

DELIMITER $$
CREATE PROCEDURE ajouter_serie3(IN p_serie_id INT, IN p_serie_nom VARCHAR(200))
BEGIN
    DECLARE EXIT HANDLER FOR SQLSTATE '23000'
    BEGIN
        SELECT CONCAT('Error: Duplicate ',p_serie_nom,'. Please choose a different name.') AS Message;
    END;
    INSERT INTO serie (code_serie, nom_serie) VALUES (p_serie_id,p_serie_nom);
    SELECT CONCAT(p_serie_nom,' inserted successfully') AS Message;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS ajouter_serie4;
DELIMITER $$
CREATE PROCEDURE ajouter_serie4(IN p_serie_id INT, IN p_serie_nom VARCHAR(200))
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
    BEGIN
        SELECT CONCAT('Error: Duplicate ',p_serie_nom,'. Please choose a different name.') AS Message;
    END;
    INSERT INTO serie (code_serie, nom_serie) VALUES (p_serie_id,p_serie_nom);
    SELECT CONCAT(p_serie_nom,' is not insert, but this message is display because Handler is CONTINUE');
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS update_serie;

DELIMITER $$
CREATE PROCEDURE update_serie(IN p_serie_id INT, IN p_serie_nom VARCHAR(200))
BEGIN
    DECLARE v_serie_count INT;
    SELECT COUNT(*) INTO v_serie_count FROM serie WHERE code_serie = p_serie_id;
    IF v_serie_count = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Serie not found';
    END IF;
    UPDATE serie SET nom_serie = p_serie_nom WHERE code_serie = p_serie_id;
    
END$$
DELIMITER ;

CALL ajouter_serie2(4, 'Star Wars');
CALL ajouter_serie3(4, 'Star Wars');
CALL ajouter_serie4(4, 'Star Wars');
CALL update_serie(5, 'Star Gate');
CALL update_serie(4, 'Star Gate');
SELECT * FROM serie;