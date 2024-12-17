DROP PROCEDURE IF EXISTS CurseurLireRoman;
DELIMITER $$
CREATE PROCEDURE CurseurLireRoman()
BEGIN 
    DECLARE boucler BOOL DEFAULT TRUE;
    DECLARE v_nom, v_auteur VARCHAR(200);
    DECLARE curseurRoman CURSOR FOR SELECT nom, auteur FROM roman;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET boucler = FALSE;
    OPEN curseurRoman;
    WHILE boucler DO
        FETCH curseurRoman INTO v_nom, v_auteur;
        SELECT CONCAT('Valeur : ',v_nom, ' -- ',v_auteur,'.');
    END WHILE;
    CLOSE curseurRoman;
END$$
DELIMITER ;

CALL curseurLireRoman();