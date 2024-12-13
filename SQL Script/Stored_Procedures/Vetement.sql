DROP PROCEDURE IF EXISTS Vetement;

DELIMITER $$

CREATE PROCEDURE Vetement (IN p_tp INT, IN p_temps VARCHAR(50), OUT p_vert VARCHAR(50))
    BEGIN
        CASE
            WHEN p_tp < 5 AND (p_temps = "beau" OR p_temps = "Nuageux") THEN
                SELECT 'Manteau' INTO p_vert
            WHEN p_tp < 20 AND p_temps = "Pluvieux" THEN 
                SELECT "Imperméable" INTO p_vert
            WHEN p_tp >= 20 AND p_temps = "Pluvieux" THEN 
                SELECT "Parapluie" INTO p_vert
            WHEN p_tp >= 5 AND p_temps < 20 THEN 
                SELECT "" INTO p_vert