-- Sélectionner toutes les données de T_EMPRUNT_TRI
SELECT * 
FROM `T_EMPRUNT_TRI`;

-- Sélectionner toutes les données de T_CLIENT_TRI
SELECT * 
FROM `T_CLIENT_TRI`;

-- Compter le nombre d'emprunts par client et vérifier si le nombre est égal à 3
SELECT COUNT(*) 
FROM T_EMPRUNT_TRI A 
JOIN `T_CLIENT_TRI` N ON A.id_client = N.id_client 
HAVING COUNT(*) = 3;

-- ============================================
-- Trigger BEFORE INSERT sur T_EMPRUNT_TRI
-- ============================================
DELIMITER $$

CREATE TRIGGER TRG_INS_EMPRUNT
BEFORE INSERT ON T_EMPRUNT_TRI
FOR EACH ROW
BEGIN
    -- Annuler l'insertion si le client a déjà 3 emprunts
    IF EXISTS (
        SELECT 1 
        FROM T_EMPRUNT_TRI A 
        WHERE A.id_client = NEW.id_client 
        HAVING COUNT(*) = 3
    ) THEN
        ROLLBACK;
    END IF;
END$$

DELIMITER ;

-- Insertion de données dans T_EMPRUNT_TRI
INSERT INTO `T_EMPRUNT_TRI` (id_client, type_emprunt)
VALUES (9, 'A');
