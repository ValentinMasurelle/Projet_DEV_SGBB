/*=============================================================
|                   📝 QUERY: trg_before_insert_client.sql    |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                     |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Trigger to log before inserting a client |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

-- This command is used to select the database ComprendreSQL
USE ComprendreSQL;

-- Retrieve the current user's name who is using the database
SELECT CURRENT_USER();

-- Delete existing trigger if it already exists 
DROP TRIGGER IF EXISTS trg_before_insert_client;

-- Set delimiter to allow use of ';' in trigger
DELIMITER $$

-- Creation of the trg_before_insert_client trigger
-- This trigger is triggered before an insertion into the T_CLIENT_TRI table.
CREATE TRIGGER trg_before_insert_client BEFORE INSERT
    ON T_CLIENT_TRI
    FOR EACH ROW  -- Execute the trigger once for each affected row during an event
    BEGIN 
        -- Declaration of a variable to store the user's name with max 20 characters 
        DECLARE user_name VARCHAR(20);

        -- Retrieve current user name and store it in the variable user_name 
        SELECT current_user() INTO user_name;

        -- Save the change in T_LOG_TRI
        -- Inserts the current time and a message detailing the insertion into T_LOG_TRI 
        INSERT INTO
            T_LOG_TRI (timestamp_log, msg_log)
        VALUES
            (
                now(),  -- Inserts the current time of the insertion
                CONCAT (  -- Concatenates a detailed log message
                    'Insertion table client Id et valeur ',
                    NEW.id_client,  -- ID of the client inserted
                    ' - ', NEW.Nom_client,  -- Name of the client
                    ' - ', NEW.type_client,  -- Type of the client
                    ' - Auteur : ', user_name  -- Username that executed the insertion 
                )
            );
    END $$

-- Return to the standard delimiter
DELIMITER ;
