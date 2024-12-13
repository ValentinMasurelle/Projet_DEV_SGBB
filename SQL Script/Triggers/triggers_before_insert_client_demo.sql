-- Utilisation de la base de données ComprendreSQL
USE ComprendreSQL;

-- Récupération du nom de l'utilisateur actuel
SELECT CURRENT_USER();

-- Suppression de la trigger existante si elle existe déjà
DROP TRIGGER IF EXISTS trg_before_insert_client;

-- Définition du délimiteur pour permettre l'utilisation de ';' dans la trigger
DELIMITER $$

-- Création de la trigger trg_before_insert_client
-- Cette trigger se déclenche avant une insertion sur la table T_CLIENT_TRI
CREATE TRIGGER trg_before_insert_client BEFORE INSERT
	ON T_CLIENT_TRI
    FOR EACH ROW 
    BEGIN 
        -- Déclaration d'une variable pour stocker le nom de l'utilisateur
        DECLARE user_name VARCHAR(20);

        -- Récupération du nom de l'utilisateur actuel et stockage dans la variable
        SELECT current_user() INTO user_name;

        -- Enregistrement de la modification dans T_LOG_TRI
        -- Insère l'heure actuelle et un message détaillant l'insertion
        INSERT INTO
            T_LOG_TRI (timestamp_log, msg_log)
        VALUES
            (
                now(),  -- Insère l'heure actuelle de l'insertion
                CONCAT (  -- Concatène un message détaillé pour le log
                    'Insertion table client Id et valeur ',
                    NEW.id_client,  -- ID du client inséré
                    ' - ', NEW.Nom_client,  -- Nom du client
                    ' - ', NEW.type_client,  -- Type du client
                    ' - Auteur : ', user_name  -- Nom de l'utilisateur qui a effectué l'insertion
                )
            );
    END $$

-- Retour au délimiteur standard
DELIMITER ;
