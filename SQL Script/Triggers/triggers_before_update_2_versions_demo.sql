-- Suppression de la trigger existante si elle existe
DROP TRIGGER IF EXISTS before_update_client;

-- Changement du délimiteur pour permettre des caractères spéciaux dans la trigger
DELIMITER $$

-- Création de la trigger before_update_client
-- Cette trigger se déclenche avant une mise à jour sur la table T_CLIENT_TRI
CREATE TRIGGER before_update_client BEFORE UPDATE ON T_CLIENT_TRI
FOR EACH ROW 
BEGIN
    -- Enregistrement dans la table T_LOG_TRI des informations de modification
    -- Enregistre l'horodatage et un message spécifiant le client modifié
    INSERT INTO
        T_LOG_TRI (timestamp_log, msg_log)
    VALUES
        (
            now(),  -- Insère l'heure actuelle
            CONCAT (  -- Concatène le texte pour le message log
                'modification table client sur client ',
                NEW.id_client  -- Récupère l'ID du client modifié
            )
        );

    -- Vérification du type de client
    -- Si le type de client est différent de 'P' (Personne) et 'E' (Entreprise)
    -- une erreur est levée, annulant la modification
    IF NEW.type_client IS NOT NULL
        AND NEW.type_client != 'P' -- Type de client Personne
        AND NEW.type_client != 'E' -- Type de client Entreprise
    THEN 
        -- Levée d'une erreur personnalisée
        SIGNAL sqlstate '45000'	
        SET MESSAGE_TEXT = 'Modification annulée ! Erreur de type client pour le client ';
    END IF;
END $$

-- Retour au délimiteur standard
DELIMITER ;

-- Deuxième création de la trigger before_update_client 
-- Cette version modifie le type de client à 'P' si une erreur de type client est détectée
-- Elle insère également un enregistrement dans la table T_ERREUR_TRI pour signaler l'erreur
DELIMITER $$

CREATE TRIGGER before_update_client BEFORE UPDATE ON T_CLIENT_TRI
FOR EACH ROW 
BEGIN
    -- Enregistrement de la modification dans T_LOG_TRI
    INSERT INTO
        T_LOG_TRI (timestamp_log, msg_log)
    VALUES
        (
            now(),  -- Date et heure de la modification
            CONCAT (  -- Message de log pour la modification
                'modification table client sur client ',
                NEW.id_client  -- ID du client concerné
            )
        );

    -- Vérification du type de client
    -- Si le type est invalide (autre que 'P' ou 'E'), corrige la valeur
    IF NEW.type_client IS NOT NULL
        AND NEW.type_client != 'P' -- Type de client Personne
        AND NEW.type_client != 'E' -- Type de client Entreprise
    THEN 
        -- Correction du type de client à 'P' (par défaut)
        SET NEW.type_client = 'P';

        -- Enregistrement de l'erreur dans T_ERREUR_TRI pour une analyse ultérieure
        INSERT INTO T_ERREUR_TRI (lib_error) VALUES
        (CONCAT ('Erreur de type client pour le client ', NEW.id_client));
    END IF;
END $$

-- Retour au délimiteur standard
DELIMITER ;
