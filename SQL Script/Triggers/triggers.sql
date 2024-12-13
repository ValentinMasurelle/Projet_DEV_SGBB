USE comprendreSQL;

-- Suppression des tables si elles existent déjà
DROP TABLE IF EXISTS T_CLIENT_TRI;
DROP TABLE IF EXISTS T_LOG_TRI;
DROP TABLE IF EXISTS T_ERROR_LOG;
DROP TABLE IF EXISTS T_EMPRUNT_TRI;

-- Création de la table T_CLIENT_TRI
CREATE TABLE T_CLIENT_TRI (
    id_client INT AUTO_INCREMENT,
    Nom_client VARCHAR(50),
    type_client CHAR(1),
    PRIMARY KEY (id_client)
);

-- Création de la table T_EMPRUNT_TRI
CREATE TABLE T_EMPRUNT_TRI (
    id_emprunt INT AUTO_INCREMENT,
    id_client INT,
    type_emprunt CHAR(1),
    PRIMARY KEY (id_emprunt)
);

-- Création de la table T_LOG_TRI
CREATE TABLE T_LOG_TRI (
    id_log INT AUTO_INCREMENT,
    timestamp_log DATETIME,
    msg_log VARCHAR(200),
    PRIMARY KEY (id_log)
);

-- Création de la table T_ERREUR_TRI
CREATE TABLE T_ERREUR_TRI (
    id_error INT AUTO_INCREMENT,
    lib_error VARCHAR(200),
    PRIMARY KEY (id_error)
);

-- Insertion initiale dans la table T_EMPRUNT_TRI
INSERT INTO T_EMPRUNT_TRI (id_client, type_emprunt)
VALUES (1, 'D');

-- Suppression des triggers existants
DROP TRIGGER IF EXISTS trg_before_insert_client;
DROP TRIGGER IF EXISTS trg_before_update_client;

-- ============================================
-- Trigger BEFORE INSERT sur T_CLIENT_TRI
-- ============================================
DELIMITER $$

CREATE TRIGGER trg_before_insert_client
BEFORE INSERT ON T_CLIENT_TRI
FOR EACH ROW
BEGIN
    DECLARE user_name VARCHAR(20);

    SELECT current_user() INTO user_name;

    INSERT INTO T_LOG_TRI (timestamp_log, msg_log)
    VALUES (
        NOW(),
        CONCAT(
            'Insertion table client Id et valeur ',
            NEW.id_client, ' - ',
            NEW.Nom_client, ' - ',
            NEW.type_client, ' - Auteur : ',
            user_name
        )
    );
END$$

DELIMITER ;

-- ============================================
-- Trigger AFTER INSERT sur T_CLIENT_TRI
-- ============================================
DELIMITER $$

CREATE TRIGGER trg_after_insert_client
AFTER INSERT ON T_CLIENT_TRI
FOR EACH ROW
BEGIN
    DECLARE user_name VARCHAR(20);

    SELECT current_user() INTO user_name;

    INSERT INTO T_LOG_TRI (timestamp_log, msg_log)
    VALUES (
        NOW(),
        CONCAT(
            'Insertion table client Id et valeur ',
            NEW.id_client, ' - ',
            NEW.Nom_client, ' - ',
            NEW.type_client, ' - Auteur : ',
            user_name
        )
    );
END$$

DELIMITER ;

-- ============================================
-- Trigger BEFORE INSERT avec ROLLBACK sur T_EMPRUNT_TRI
-- ============================================
DELIMITER $$

CREATE TRIGGER TRG_INS_EMPRUNT
BEFORE INSERT ON T_EMPRUNT_TRI
FOR EACH ROW
BEGIN
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

-- ============================================
-- Trigger BEFORE UPDATE sur T_CLIENT_TRI
-- ============================================
USE comprendreSQL;

DROP TRIGGER IF EXISTS before_update_client;

DELIMITER $$

CREATE TRIGGER before_update_client
BEFORE UPDATE ON T_CLIENT_TRI
FOR EACH ROW
BEGIN
    INSERT INTO T_LOG_TRI (timestamp_log, msg_log)
    VALUES (
        NOW(),
        CONCAT('Modification table client sur client ', NEW.id_client)
    );

    IF NEW.type_client IS NOT NULL
       AND NEW.type_client != 'P' -- Type de client Personne
       AND NEW.type_client != 'E' -- Type de client Entreprise
    THEN
        SET NEW.type_client = 'P';
        INSERT INTO T_ERREUR_TRI (lib_error)
        VALUES (CONCAT('Erreur de type client pour le client ', NEW.id_client));
    END IF;
END$$

DELIMITER ;

-- ============================================
-- Autre Trigger BEFORE UPDATE avec SIGNAL pour annulation
-- ============================================
DELIMITER $$

CREATE TRIGGER before_update_client_signal
BEFORE UPDATE ON T_CLIENT_TRI
FOR EACH ROW
BEGIN
    INSERT INTO T_LOG_TRI (timestamp_log, msg_log)
    VALUES (
        NOW(),
        CONCAT('Modification table client sur client ', NEW.id_client)
    );

    IF NEW.type_client IS NOT NULL
       AND NEW.type_client != 'P' -- Type de client Personne
       AND NEW.type_client != 'E' -- Type de client Entreprise
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Modification annulée ! Erreur de type client pour le client';
    END IF;
END$$

DELIMITER ;

-- ============================================
-- Affichage des processus en cours
-- ============================================
SHOW PROCESSLIST;

-- Requêtes d'affichage des utilisateurs
SELECT current_user();
SELECT USER();

-- Insertion de données dans T_CLIENT_TRI
INSERT INTO T_CLIENT_TRI (Nom_client, type_client)
VALUES ('Peter', 'E');

INSERT INTO T_CLIENT_TRI (Nom_client, type_client)
VALUES ('Mary', 'E');

-- Sélection des données des tables
SELECT * FROM T_CLIENT_TRI;
SELECT * FROM T_LOG_TRI;

-- Mise à jour pour tester le trigger BEFORE UPDATE
UPDATE T_CLIENT_TRI
SET type_client = 'X'
WHERE Nom_client = 'Mary';
