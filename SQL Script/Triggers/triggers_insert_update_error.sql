/*=============================================================
|                   📝 QUERY: triggers_insert_update_error    |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                       |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Synchronizes `users` data between db_1 and db_2 with error logging |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

-- ==============================
-- SECTION 1: Users Table Creation in `db_1` and `db_2`
-- ==============================
-- Vérifier si la base de données existe déjà
CREATE DATABASE IF NOT EXISTS `db_1`;

-- Sélectionner la base de données
USE `db_1`;

-- Drop the `users` table in `db_1` if it exists
DROP TABLE IF EXISTS `db_1`.`users`;

-- Create the `users` table in `db_1` with fields `id`, `name`, and `age`
CREATE TABLE IF NOT EXISTS `db_1`.`users` (
    `id` int(11) AUTO_INCREMENT NOT NULL,     -- Unique identifier with auto-increment
    `name` varchar(30) NOT NULL,              -- User's name (max 30 characters)
    `age` int(11) NOT NULL,                   -- User's age
    PRIMARY KEY (`id`)                        -- Primary key on `id` field
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE DATABASE IF NOT EXISTS `db_2`;

-- Sélectionner la base de données
USE `db_2`;

-- Drop the `users` table in `db_2` if it exists
DROP TABLE IF EXISTS `db_2`.`users`;

-- Create the `users` table in `db_2` with the same structure as in `db_1`
CREATE TABLE IF NOT EXISTS `db_2`.`users` (
    `id` int(11) AUTO_INCREMENT NOT NULL,     -- Unique identifier with auto-increment
    `name` varchar(30) NOT NULL,              -- User's name (max 30 characters)
    `age` int(11) NOT NULL,                   -- User's age
    PRIMARY KEY (`id`)                        -- Primary key on `id` field
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ==============================
-- SECTION 2: Creation of `errors` Table for SQL Error Logging
-- ==============================

-- Drop the `errors` table in `db_1` if it exists
DROP TABLE IF EXISTS `db_1`.`errors`;

-- Create the `errors` table to store detailed error information
CREATE TABLE IF NOT EXISTS `db_1`.`errors` (
    `id` int(11) AUTO_INCREMENT NOT NULL,       -- Unique identifier for each error
    `code` varchar(30) NOT NULL,                -- SQL error code
    `message` TEXT NOT NULL,                    -- Detailed error message
    `query_type` varchar(50) NOT NULL,          -- Type of query causing the error (insert, update, delete)
    `record_id` int(11) NOT NULL,               -- ID of the affected record
    `on_db` varchar(50) NOT NULL,               -- Database where the error occurred
    `on_table` varchar(50) NOT NULL,            -- Table where the error occurred
    `emailed` TINYINT DEFAULT 0,                -- Indicator if the error was emailed (0 = no, 1 = yes)
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Timestamp of the error
    PRIMARY KEY (`id`)                          -- Primary key on `id` field
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ==============================
-- SECTION 3: AFTER INSERT Trigger - Synchronization and Error Handling
-- ==============================

DELIMITER $$

-- Drop the `test_db1_users_ai` trigger if it exists
DROP TRIGGER IF EXISTS `db_1`.`test_db1_users_ai`;

-- Create the `test_db1_users_ai` trigger that executes after an insert in `db_1`.`users`
CREATE TRIGGER `db_1`.`test_db1_users_ai`
AFTER INSERT ON `db_1`.`users`
FOR EACH ROW
BEGIN
    -- Declare variables to store error code and message
    DECLARE errorCode CHAR(5) DEFAULT '00000';
    DECLARE errorMessage TEXT DEFAULT '';

    -- SQL exception handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            errorCode = RETURNED_SQLSTATE, errorMessage = MESSAGE_TEXT;
    END;

    -- Insert the new user into `db_2`.`users`
    INSERT INTO `db_2`.`users` (id, name, age)
    VALUES (NEW.id, NEW.name, NEW.age);

    -- Log the error in `errors` table if any error occurs
    IF errorCode != '00000' THEN
        INSERT INTO `errors` (code, message, query_type, record_id, on_db, on_table)
        VALUES (errorCode, errorMessage, 'insert', NEW.id, 'db_2', 'users');
    END IF;
END; $$

DELIMITER ;

-- ==============================
-- SECTION 4: AFTER UPDATE Trigger - Synchronization and Error Handling
-- ==============================

DELIMITER $$

-- Drop the `test_db1_users_au` trigger if it exists
DROP TRIGGER IF EXISTS `db_1`.`test_db1_users_au`;

-- Create the `test_db1_users_au` trigger that executes after an update in `db_1`.`users`
CREATE TRIGGER `db_1`.`test_db1_users_au`
AFTER UPDATE ON `db_1`.`users`
FOR EACH ROW
BEGIN
    -- Declare variables to store error code and message
    DECLARE errorCode CHAR(5) DEFAULT '00000';
    DECLARE errorMessage TEXT DEFAULT '';

    -- SQL exception handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            errorCode = RETURNED_SQLSTATE, errorMessage = MESSAGE_TEXT;
    END;

    -- Update the user in `db_2`.`users`
    UPDATE `db_2`.`users`
    SET name = NEW.name,
        age = NEW.age
    WHERE id = NEW.id;

    -- Log the error in `errors` table if any error occurs
    IF errorCode != '00000' THEN
        INSERT INTO `errors` (code, message, query_type, record_id, on_db, on_table)
        VALUES (errorCode, errorMessage, 'update', NEW.id, 'db_2', 'users');
    END IF;
END; $$

DELIMITER ;

-- ==============================
-- SECTION 5: AFTER DELETE Trigger - Synchronization and Error Handling
-- ==============================

DELIMITER $$

-- Drop the `test_db1_users_ad` trigger if it exists
DROP TRIGGER IF EXISTS `db_1`.`test_db1_users_ad`;

-- Create the `test_db1_users_ad` trigger that executes after a delete in `db_1`.`users`
CREATE TRIGGER `db_1`.`test_db1_users_ad`
AFTER DELETE ON `db_1`.`users`
FOR EACH ROW
BEGIN
    -- Declare variables to store error code and message
    DECLARE errorCode CHAR(5) DEFAULT '00000';
    DECLARE errorMessage TEXT DEFAULT '';

    -- SQL exception handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            errorCode = RETURNED_SQLSTATE, errorMessage = MESSAGE_TEXT;
    END;

    -- Delete the user from `db_2`.`users`
    DELETE FROM `db_2`.`users`
    WHERE id = OLD.id;

    -- Log the error in `errors` table if any error occurs
    IF errorCode != '00000' THEN
        INSERT INTO `errors` (code, message, query_type, record_id, on_db, on_table)
        VALUES (errorCode, errorMessage, 'delete', OLD.id, 'db_2', 'users');
    END IF;
END; $$

DELIMITER ;

-- ==============================
-- SECTION 6: Data Manipulation in `db_1`.`users`
-- ==============================

-- Insert sample data into `db_1`.`users`
INSERT INTO `db_1`.`users` (name, age) VALUES ('Alan', 25);
INSERT INTO `db_1`.`users` (name, age) VALUES ('Norah', 17);

-- Update the age of user 'Alan' to 26
UPDATE `db_1`.`users` SET age = 26 WHERE name = 'Alan';

-- Delete user with ID 1
DELETE FROM `db_1`.`users` WHERE `db_1`.`users`.id = 1;

-- ==============================
-- SECTION 7: Display Data from `users` Tables
-- ==============================

-- Select all data from `db_1`.`users`
SELECT CONCAT('db_1', '.', 'users') AS `table`, id, name, age FROM `db_1`.`users`;

-- Select all data from `db_2`.`users`
SELECT CONCAT('db_2', '.', 'users') AS `table`, id, name, age FROM `db_2`.`users`;
