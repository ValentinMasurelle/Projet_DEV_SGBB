/*=============================================================
|                   🗑️ QUERY testtriggers.sql                | 
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Perform deletion, insertion, and          |
|                  selection operations on T_CLIENT_TRI and   |
|                  T_LOG_TRI tables.                          |
|                                                             |
|                  - Delete all rows in specified tables.     |
|                  - Insert new client records.               |
|                  - Verify data with SELECT statements.      |
|                  - Show existing triggers.                  |
|                                                             |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

-- Delete all rows from the T_CLIENT_TRI table
-- This command removes all entries from the T_CLIENT_TRI table.
DELETE FROM `T_CLIENT_TRI` WHERE 1=1;

-- Delete all rows from the T_LOG_TRI table
-- This command removes all entries from the T_LOG_TRI table.
DELETE FROM `T_LOG_TRI` WHERE 1=1;

-- Insert a new row into the T_CLIENT_TRI table
-- This command adds a client named 'Gatean' with client type 'G'.
INSERT INTO
    T_CLIENT_TRI (nom_client, type_client)
VALUES
    ('Gatean', 'G');
    
-- Insert a new row into the T_CLIENT_TRI table
-- This command adds a client named 'Yvette' with client type 'Y'.
INSERT INTO
    T_CLIENT_TRI (nom_client, type_client)
VALUES
    ('Yvette', 'Y');

-- Select all entries from the T_LOG_TRI table
-- This command displays all entries in the T_LOG_TRI table for verification.
SELECT * FROM `T_LOG_TRI`;

-- Select all entries from the T_CLIENT_TRI table
-- This command displays all entries in the T_CLIENT_TRI table for verification.
SELECT * FROM `ComprendreSQL`.`T_CLIENT_TRI`;

-- Show existing triggers in the database
-- This command lists all triggers associated with the current database.
SHOW TRIGGERS;
