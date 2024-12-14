-- This commande is use to use the database ComprendreSQL
USE ComprendreSQL;

-- Retrieve current user name who's use the databse
SELECT CURRENT_USER();

-- Delete existing trigger if it already exists 
DROP TRIGGER IF EXISTS trg_before_insert_client;

-- Set delimiter to allow use of ';' in trigger
DELIMITER $$

-- Creation of the trg_before_insert_client trigger
-- This trigger is triggered before an insertion into the T_CLIENT_TRI table.
CREATE TRIGGER trg_before_insert_client BEFORE INSERT
	ON T_CLIENT_TRI
    FOR EACH ROW  -- Is used with triggers and specifies that the trigger should execute once for each affected row when a spécified event occurs 
    BEGIN 
        -- Declaration of a variable to store the user's name with max 20 characters 
        DECLARE user_name VARCHAR(20);

        -- Retrieve current user name and store in variable user_name 
        SELECT current_user() INTO user_name;

        -- Save change in T_LOG_TRI
        -- Inserts the current time and a message detailing the insertion in the table T_LOG_TRI 
        INSERT INTO
            T_LOG_TRI (timestamp_log, msg_log)
        VALUES
            (
                now(),  -- Inserts current time of insertion
                CONCAT (  -- Concatenates a detailed log message
                    'Insertion table client Id et valeur ',
                    NEW.id_client,  -- ID of the client inserted
                    ' - ', NEW.Nom_client,  -- Name of the client
                    ' - ', NEW.type_client,  -- Type og the client
                    ' - Auteur : ', user_name  -- Username that execute the insertion 
                )
            );
    END $$

-- Return to standard delimiter
DELIMITER ;
