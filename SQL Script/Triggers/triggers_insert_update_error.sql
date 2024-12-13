-- ==============================
-- Suppression et création des tables `users` dans `db_1` et `db_2`
-- ==============================

-- Supprime la table `users` dans `db_1` si elle existe déjà
DROP TABLE IF EXISTS `db_1`.`users`;

-- Crée la table `users` dans `db_1` avec les champs `id`, `name` et `age`
CREATE TABLE IF NOT EXISTS `db_1`.`users` (
    `id` int(11) AUTO_INCREMENT NOT NULL,     -- Identifiant unique avec auto-incrémentation
    `name` varchar(30) NOT NULL,              -- Nom de l'utilisateur (30 caractères max)
    `age` int(11) NOT NULL,                   -- Âge de l'utilisateur
    PRIMARY KEY (`id`)                        -- Clé primaire sur le champ `id`
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- Supprime la table `users` dans `db_2` si elle existe déjà
DROP TABLE IF EXISTS `db_2`.`users`;

-- Crée la table `users` dans `db_2` avec les mêmes champs que `db_1`.`users`
CREATE TABLE IF NOT EXISTS `db_2`.`users` (
    `id` int(11) AUTO_INCREMENT NOT NULL,     -- Identifiant unique avec auto-incrémentation
    `name` varchar(30) NOT NULL,              -- Nom de l'utilisateur (30 caractères max)
    `age` int(11) NOT NULL,                   -- Âge de l'utilisateur
    PRIMARY KEY (`id`)                        -- Clé primaire sur le champ `id`
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ==============================
-- Création de la table `errors` pour enregistrer les erreurs SQL
-- ==============================

-- Supprime la table `errors` si elle existe déjà
DROP TABLE IF EXISTS `db_1`.`errors`;

-- Crée la table `errors` pour enregistrer les détails des erreurs SQL
CREATE TABLE IF NOT EXISTS `db_1`.`errors` (
    `id` int(11) AUTO_INCREMENT NOT NULL,       -- Identifiant unique pour chaque erreur
    `code` varchar(30) NOT NULL,                -- Code d'erreur SQL
    `message` TEXT NOT NULL,                    -- Message d'erreur détaillé
    `query_type` varchar(50) NOT NULL,          -- Type de requête qui a causé l'erreur (insert, update, delete)
    `record_id` int(11) NOT NULL,               -- ID de l'enregistrement concerné
    `on_db` varchar(50) NOT NULL,               -- Base de données concernée
    `on_table` varchar(50) NOT NULL,            -- Table concernée
    `emailed` TINYINT DEFAULT 0,                -- Indicateur si l'erreur a été signalée par email (0 = non, 1 = oui)
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date et heure de l'erreur
    PRIMARY KEY (`id`)                          -- Clé primaire sur le champ `id`
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ==============================
-- Trigger AFTER INSERT : Synchronisation des données et gestion des erreurs
-- ==============================

DELIMITER $$

-- Supprime le trigger `test_db1_users_ai` s'il existe déjà
DROP TRIGGER IF EXISTS `db_1`.`test_db1_users_ai`;

-- Crée le trigger `test_db1_users_ai` qui s'exécute après l'insertion d'un enregistrement dans `db_1`.`users`
CREATE TRIGGER `db_1`.`test_db1_users_ai`
AFTER INSERT ON `db_1`.`users`
FOR EACH ROW
BEGIN
    -- Variables pour stocker le code et le message d'erreur
    DECLARE errorCode CHAR(5) DEFAULT '00000';
    DECLARE errorMessage TEXT DEFAULT '';

    -- Gestionnaire d'erreurs SQL
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            errorCode = RETURNED_SQLSTATE, errorMessage = MESSAGE_TEXT;
    END;

    -- Insère les données dans `db_2`.`users`
    INSERT INTO `db_2`.`users` (id, name, age)
    VALUES (NEW.id, NEW.name, NEW.age);

    -- Enregistre l'erreur dans `errors` si une erreur survient
    IF errorCode != '00000' THEN
        INSERT INTO `errors` (code, message, query_type, record_id, on_db, on_table)
        VALUES (errorCode, errorMessage, 'insert', NEW.id, 'db_2', 'users');
    END IF;
END; $$

DELIMITER ;

-- ==============================
-- Trigger AFTER UPDATE : Synchronisation des mises à jour et gestion des erreurs
-- ==============================

DELIMITER $$

-- Supprime le trigger `test_db1_users_au` s'il existe déjà
DROP TRIGGER IF EXISTS `db_1`.`test_db1_users_au`;

-- Crée le trigger `test_db1_users_au` qui s'exécute après une mise à jour dans `db_1`.`users`
CREATE TRIGGER `db_1`.`test_db1_users_au`
AFTER UPDATE ON `db_1`.`users`
FOR EACH ROW
BEGIN
    -- Variables pour stocker le code et le message d'erreur
    DECLARE errorCode CHAR(5) DEFAULT '00000';
    DECLARE errorMessage TEXT DEFAULT '';

    -- Gestionnaire d'erreurs SQL
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            errorCode = RETURNED_SQLSTATE, errorMessage = MESSAGE_TEXT;
    END;

    -- Met à jour les données dans `db_2`.`users`
    UPDATE `db_2`.`users`
    SET name = NEW.name,
        age = NEW.age
    WHERE id = NEW.id;

    -- Enregistre l'erreur dans `errors` si une erreur survient
    IF errorCode != '00000' THEN
        INSERT INTO `errors` (code, message, query_type, record_id, on_db, on_table)
        VALUES (errorCode, errorMessage, 'update', NEW.id, 'db_2', 'users');
    END IF;
END; $$

DELIMITER ;

-- ==============================
-- Trigger AFTER DELETE : Synchronisation des suppressions et gestion des erreurs
-- ==============================

DELIMITER $$

-- Supprime le trigger `test_db1_users_ad` s'il existe déjà
DROP TRIGGER IF EXISTS `db_1`.`test_db1_users_ad`;

-- Crée le trigger `test_db1_users_ad` qui s'exécute après la suppression d'un enregistrement dans `db_1`.`users`
CREATE TRIGGER `db_1`.`test_db1_users_ad`
AFTER DELETE ON `db_1`.`users`
FOR EACH ROW
BEGIN
    -- Variables pour stocker le code et le message d'erreur
    DECLARE errorCode CHAR(5) DEFAULT '00000';
    DECLARE errorMessage TEXT DEFAULT '';

    -- Gestionnaire d'erreurs SQL
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            errorCode = RETURNED_SQLSTATE, errorMessage = MESSAGE_TEXT;
    END;

    -- Supprime l'enregistrement correspondant dans `db_2`.`users`
    DELETE FROM `db_2`.`users`
    WHERE id = OLD.id;

    -- Enregistre l'erreur dans `errors` si une erreur survient
    IF errorCode != '00000' THEN
        INSERT INTO `errors` (code, message, query_type, record_id, on_db, on_table)
        VALUES (errorCode, errorMessage, 'delete', OLD.id, 'db_2', 'users');
    END IF;
END; $$

DELIMITER ;

-- ==============================
-- Manipulation des données dans `db_1`.`users`
-- ==============================

-- Insertion de données dans `db_1`.`users`
INSERT INTO `db_1`.`users` (name, age) VALUES ('Alan', 25);
INSERT INTO `db_1`.`users` (name, age) VALUES ('Norah', 17);

-- Mise à jour de l'âge de l'utilisateur 'Alan' à 26 ans
UPDATE `db_1`.`users` SET age = 26 WHERE name = 'Alan';

-- Suppression de l'utilisateur avec l'ID 1
DELETE FROM `db_1`.`users` WHERE `db_1`.`users`.id = 1;

-- ==============================
-- Affichage des données des tables `users`
-- ==============================

-- Sélectionne toutes les données de `db_1`.`users`
SELECT CONCAT('db_1', '.', 'users') AS `table`, id, name, age FROM `db_1`.`users`;

-- Sélectionne toutes les données de `db_2`.`users`
SELECT CONCAT('db_2', '.', 'users') AS `table`, id, name, age FROM `db_2`.`users`;
