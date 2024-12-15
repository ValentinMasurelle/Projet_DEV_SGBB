/*=============================================================
|                   🖼️ QUERY: triggersCreateTables.sql        |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Drop existing tables and create tables    |
|                  for client management, loan tracking,      |
|                  logging, and error handling.               |
|                                                             |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

-- ------------------------------------------------------------
-- USE THE TARGET DATABASE
-- ------------------------------------------------------------
-- 📄 Description: Ensure the operations are executed within the
-- `comprendreSQL` database.

USE comprendreSQL;

-- ------------------------------------------------------------
-- DROP TABLES IF THEY EXIST
-- ------------------------------------------------------------
-- 📄 Description: Drop existing tables to prevent conflicts and
-- allow for fresh table creation. This ensures a clean slate.

-- Drop the `T_CLIENT_TRI` table if it already exists.
DROP TABLE IF EXISTS `T_CLIENT_TRI`;

-- Drop the `T_LOG_TRI` table if it already exists.
DROP TABLE IF EXISTS `T_LOG_TRI`;

-- Drop the `T_ERROR_LOG` table if it already exists.
DROP TABLE IF EXISTS `T_ERROR_LOG`;

-- Drop the `T_EMPRUNT_TRI` table if it already exists.
DROP TABLE IF EXISTS `T_EMPRUNT_TRI`;

-- ------------------------------------------------------------
-- CREATE TABLE: T_CLIENT_TRI
-- ------------------------------------------------------------
-- 📄 Description: This table stores information about clients. It includes:
-- - `id_client`: A unique identifier for each client (auto-incremented).
-- - `Nom_client`: The name of the client.
-- - `type_client`: The type of client ('P' for Person, 'E' for Enterprise).

CREATE TABLE `T_CLIENT_TRI` (
    id_client INT AUTO_INCREMENT,       -- Unique, auto-incrementing client ID.
    Nom_client VARCHAR(50),             -- Client's name (up to 50 characters).
    type_client CHAR(1),                -- Client type ('P' or 'E').
    PRIMARY KEY (id_client)             -- Set `id_client` as the primary key.
);

-- ------------------------------------------------------------
-- CREATE TABLE: T_EMPRUNT_TRI
-- ------------------------------------------------------------
-- 📄 Description: This table tracks loan (emprunt) information. It includes:
-- - `id_emprunt`: A unique identifier for each loan (auto-incremented).
-- - `id_client`: The ID of the client who took the loan (foreign key reference).
-- - `type_emprunt`: The type of loan.

CREATE TABLE `T_EMPRUNT_TRI` (
    id_emprunt INT AUTO_INCREMENT,      -- Unique, auto-incrementing loan ID.
    id_client INT,                      -- Client ID associated with the loan.
    type_emprunt CHAR(1),               -- Type of loan (single character).
    PRIMARY KEY (id_emprunt)            -- Set `id_emprunt` as the primary key.
);

-- ------------------------------------------------------------
-- CREATE TABLE: T_LOG_TRI
-- ------------------------------------------------------------
-- 📄 Description: This table stores log entries for auditing purposes. It includes:
-- - `id_log`: A unique identifier for each log entry (auto-incremented).
-- - `timestamp_log`: The timestamp when the log entry was created.
-- - `msg_log`: The message detailing the logged action.

CREATE TABLE `T_LOG_TRI` (
    id_log INT AUTO_INCREMENT,          -- Unique, auto-incrementing log ID.
    timestamp_log DATETIME,             -- Timestamp of the log entry.
    msg_log VARCHAR(200),               -- Log message (up to 200 characters).
    PRIMARY KEY (id_log)                -- Set `id_log` as the primary key.
);

-- ------------------------------------------------------------
-- CREATE TABLE: T_ERREUR_TRI
-- ------------------------------------------------------------
-- 📄 Description: This table stores error messages encountered during operations. 
-- It includes:
-- - `id_error`: A unique identifier for each error (auto-incremented).
-- - `lib_error`: The error message description.

CREATE TABLE `T_ERREUR_TRI` (
    id_error INT AUTO_INCREMENT,        -- Unique, auto-incrementing error ID.
    lib_error VARCHAR(200),             -- Error message description (up to 200 characters).
    PRIMARY KEY (id_error)              -- Set `id_error` as the primary key.
);

-- ------------------------------------------------------------
-- SUMMARY OF TABLE RELATIONSHIPS
-- ------------------------------------------------------------
/* 📄 Description of Table Relationships:
   1. `T_CLIENT_TRI`:
      - Stores client information.
   2. `T_EMPRUNT_TRI`:
      - Tracks loans associated with clients.
      - `id_client` can reference `id_client` in `T_CLIENT_TRI`.
   3. `T_LOG_TRI`:
      - Logs all significant operations (e.g., inserts and updates).
   4. `T_ERREUR_TRI`:
      - Captures error messages when data integrity issues occur.
*/

-- ------------------------------------------------------------
-- SCRIPT COMPLETION MESSAGE
-- ------------------------------------------------------------
-- 📄 Description: Indicates the script has executed successfully.
SELECT 'Table creation completed successfully' AS status_message;
