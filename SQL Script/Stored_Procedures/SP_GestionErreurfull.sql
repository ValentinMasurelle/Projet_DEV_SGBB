-- Active: 1734111287231@@127.0.0.1@3306@Biblio

DROP PROCEDURE GestionBiblio;
DELIMITER $$
CREATE PROCEDURE GestionBiblio(
    IN p_code_roman VARCHAR(17), 
    IN p_nom_roman VARCHAR(200),
    IN p_code_serie INT,
    IN p_nom_serie VARCHAR(200)
)
BEGIN
    DECLARE rollback_message VARCHAR(255) DEFAULT 'Transaction rolled back: Duplicate data';
    DECLARE commit_message VARCHAR(255) DEFAULT 'Transaction committed successfully';
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
        ROLLBACK; 
        SELECT rollback_message AS 'Result';
    END;
    START TRANSACTION;
    INSERT INTO roman (code_ISBN, nom) VALUES (p_code_roman,p_nom_roman);
    INSERT INTO serie(code_serie, nom_serie) VALUES (p_code_serie,p_nom_serie);
    INSERT INTO estDans(code_ISBN, code_serie) VALUES (p_code_roman,p_code_serie);
    -- Insert in log table information from insert statement
    COMMIT;
    SELECT commit_message AS 'Result';
END$$

DELIMITER ;
SELECT a.`code_ISBN`,a.nom, a.auteur, c.code_serie,c.nom_serie FROM `Biblio`.roman a
JOIN `Biblio`.`estDans` b ON a.`code_ISBN` = b.`code_ISBN`
JOIN `Biblio`.serie c ON b.code_serie = c.code_serie;

CALL `Biblio`.`GestionBiblio`("20","New Roman", 8, "New serie");