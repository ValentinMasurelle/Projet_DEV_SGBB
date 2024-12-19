DROP PROCEDURE IF EXISTS ajouter_serie;

DELIMITER $$
CREATE PROCEDURE ajouter_serie(IN p_serie_id INT, IN p_serie_nom VARCHAR(200))
BEGIN
     SELECT 'BEFORE INSERT';    
     INSERT INTO serie (code_serie, nom_serie) VALUES (p_serie_id,p_serie_nom);
     SELECT 'AFTER INSERT';
END $$
DELIMITER ;

CALL ajouter_serie(4, 'Star Wars');

SELECT * FROM serie;