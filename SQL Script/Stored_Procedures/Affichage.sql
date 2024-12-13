DROP PROCEDURE IF EXISTS Affichage;

DELIMITER $$

CREATE PROCEDURE Affichage (
    OUT texte VARCHAR(200),
    OUT texte1 VARCHAR(200),
    OUT texte2 VARCHAR(200)
)
BEGIN
    -- Première assignation
    SELECT 'texte0' INTO texte;

    -- Deuxième assignation
    SELECT 'texte1' INTO texte1;

    -- Troisième assignation
    SELECT 'texte2' INTO texte2;
END$$

DELIMITER ;

-- Appel de la procédure
CALL Affichage(@texte, @texte1, @texte2);

-- Affichage des valeurs assignées
SELECT @texte, @texte1, @texte2;
