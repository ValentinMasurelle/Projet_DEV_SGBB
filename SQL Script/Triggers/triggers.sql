/*=============================================================
|                   🖼️ QUERY: triggers.sql          |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Initialize tables and create triggers     |
|                  to manage client and loan operations,      |
|                  with detailed logging and error handling.  |
|                                                             |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

-- ------------------------------------------------------------
-- USE THE TARGET DATABASE
-- ------------------------------------------------------------
-- Select the `comprendreSQL` database to ensure all operations
-- are performed within this context.
USE comprendreSQL;

-- ------------------------------------------------------------
-- DROP TABLES IF THEY EXIST
-- ------------------------------------------------------------
-- 📄 Description: Drop existing tables to prevent conflicts and 
-- ensure a clean slate before creating new tables.

DROP TABLE IF EXISTS `T_CLIENT_TRI`;
DROP TABLE IF EXISTS `T_LOG_TRI`;
DROP TABLE IF EXISTS `T_ERREUR_TRI`;
DROP TABLE IF EXISTS `T_EMPRUNT_TRI`;

-- ------------------------------------------------------------
-- CREATE TABLE: T_CLIENT_TRI
-- ------------------------------------------------------------
-- 📄 Description: This table stores client information, including:
-- - `id_client`: Unique identifier for each client.
-- - `Nom_client`: The client's name.
-- - `type_client`: The type of client ('P' for Person, 'E' for Enterprise).

CREATE TABLE `T_CLIENT_TRI` (
    id_client INT AUTO_INCREMENT,       -- Auto-incremented primary key.
    Nom_client VARCHAR(50),             -- Client name (up to 50 characters).
    type_client CHAR(1),                -- Client type ('P' or 'E').
    PRIMARY KEY (id_client)             -- Set `id_client` as the primary key.
);

-- ------------------------------------------------------------
-- CREATE TABLE: T_EMPRUNT_TRI
-- ------------------------------------------------------------
-- 📄 Description: This table tracks loan (emprunt) records, including:
-- - `id_emprunt`: Unique identifier for each loan.
-- - `id_client`: References the client who made the loan.
-- - `type_emprunt`: The type of loan.

CREATE TABLE `T_EMPRUNT_TRI` (
    id_emprunt INT AUTO_INCREMENT,      -- Auto-incremented primary key for loans.
    id_client INT,                      -- Foreign key referencing `T_CLIENT_TRI`.
    type_emprunt CHAR(1),               -- Type of loan (single character).
    PRIMARY KEY (id_emprunt)            -- Set `id_emprunt` as the primary key.
);

-- ------------------------------------------------------------
-- CREATE TABLE: T_LOG_TRI
-- ------------------------------------------------------------
-- 📄 Description: This table logs all significant actions, such as
-- insertions and updates, for auditing purposes. Fields include:
-- - `id_log`: Unique identifier for each log entry.
-- - `timestamp_log`: Date and time when the log entry was created.
-- - `msg_log`: Detailed log message.

CREATE TABLE `T_LOG_TRI` (
    id_log INT AUTO_INCREMENT,          -- Auto-incremented primary key for log entries.
    timestamp_log DATETIME,             -- Timestamp for the log entry.
    msg_log VARCHAR(200),               -- Log message (up to 200 characters).
    PRIMARY KEY (id_log)                -- Set `id_log` as the primary key.
);

-- ------------------------------------------------------------
-- CREATE TABLE: T_ERREUR_TRI
-- ------------------------------------------------------------
-- 📄 Description: This table logs error messages encountered during
-- operations. Fields include:
-- - `id_error`: Unique identifier for each error.
-- - `lib_error`: Description of the error.

CREATE TABLE `T_ERREUR_TRI` (
    id_error INT AUTO_INCREMENT,        -- Auto-incremented primary key for error entries.
    lib_error VARCHAR(200),             -- Error message (up to 200 characters).
    PRIMARY KEY (id_error)              -- Set `id_error` as the primary key.
);

-- ------------------------------------------------------------
-- INITIAL DATA INSERTION INTO T_EMPRUNT_TRI
-- ------------------------------------------------------------
-- 📄 Description: Insert an initial record into the `T_EMPRUNT_TRI` table
-- for testing purposes. This represents a loan made by client ID 1.

INSERT INTO `T_EMPRUNT_TRI` (id_client, type_emprunt)
VALUES (1, 'D');                        -- Client 1 has a loan of type 'D'.

-- ------------------------------------------------------------
-- DROP EXISTING TRIGGERS IF THEY EXIST
-- ------------------------------------------------------------
-- 📄 Description: Remove any existing triggers to avoid conflicts
-- when creating new triggers.

DROP TRIGGER IF EXISTS `trg_before_insert_client`;
DROP TRIGGER IF EXISTS `trg_before_update_client`;

-- ------------------------------------------------------------
-- CREATE TRIGGER: BEFORE INSERT ON T_CLIENT_TRI
-- ------------------------------------------------------------
-- 📄 Description: This trigger logs an entry to `T_LOG_TRI` before a new
-- client record is inserted into `T_CLIENT_TRI`. It captures:
-- - The client ID.
-- - The client's name.
-- - The client type.
-- - The current user performing the action.

DELIMITER $$

CREATE TRIGGER `trg_before_insert_client`
BEFORE INSERT ON `T_CLIENT_TRI`
FOR EACH ROW
BEGIN
    DECLARE user_name VARCHAR(20);

    -- Get the current user's name.
    SELECT current_user() INTO user_name;

    -- Insert a log entry with details about the new client.
    INSERT INTO `T_LOG_TRI` (timestamp_log, msg_log)
    VALUES (
        NOW(),  -- Current timestamp.
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

-- ------------------------------------------------------------
-- CREATE TRIGGER: BEFORE INSERT ON T_EMPRUNT_TRI
-- ------------------------------------------------------------
-- 📄 Description: This trigger checks if a client already has 3 loans.
-- If they do, the insertion is rejected with an error message.

DELIMITER $$

CREATE TRIGGER `TRG_INS_EMPRUNT`
BEFORE INSERT ON `T_EMPRUNT_TRI`
FOR EACH ROW
BEGIN
    DECLARE total_emprunts INT;

    -- Count the number of loans for the client.
    SELECT COUNT(*) INTO total_emprunts
    FROM `T_EMPRUNT_TRI`
    WHERE id_client = NEW.id_client;

    -- If the client already has 3 loans, raise an error.
    IF total_emprunts >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insertion refused: Client already has 3 loans.';
    END IF;
END$$

DELIMITER ;

-- ------------------------------------------------------------
-- INSERT SAMPLE DATA INTO T_CLIENT_TRI
-- ------------------------------------------------------------
-- 📄 Description: Insert two sample client records to test triggers.

INSERT INTO `T_CLIENT_TRI` (Nom_client, type_client)
VALUES ('Peter', 'E');                  -- Client 'Peter' of type 'Enterprise'.

INSERT INTO `T_CLIENT_TRI` (Nom_client, type_client)
VALUES ('Mary', 'E');                   -- Client 'Mary' of type 'Enterprise'.

-- ------------------------------------------------------------
-- SELECT DATA FROM TABLES
-- ------------------------------------------------------------
-- 📄 Description: Retrieve and display all data from `T_CLIENT_TRI`
-- and `T_LOG_TRI` to verify the insertions and logging.

SELECT * FROM `T_CLIENT_TRI`;           -- View all clients.
SELECT * FROM `T_LOG_TRI`;              -- View all log entries.

-- ------------------------------------------------------------
-- UPDATE TO TRIGGER BEFORE UPDATE TEST
-- ------------------------------------------------------------
-- 📄 Description: Update `type_client` with an invalid value ('X') for
-- client 'Mary' to test the `BEFORE UPDATE` trigger.

UPDATE `T_CLIENT_TRI`
SET type_client = 'X'
WHERE Nom_client = 'Mary';

-- ------------------------------------------------------------
-- DISPLAY CURRENT PROCESSES AND USER INFORMATION
-- ------------------------------------------------------------
-- 📄 Description: Display information about active processes and
-- the current user.

SHOW PROCESSLIST;                       -- Show currently running processes.

SELECT current_user();                  -- Show the current user.
SELECT USER();                          -- Show the user account.
