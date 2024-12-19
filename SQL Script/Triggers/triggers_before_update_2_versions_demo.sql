/*=============================================================
|                   📝 QUERY: trg_before_update_client.sql    |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                     |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Trigger to log before updating a client  |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

-- Drop the existing trigger if it exists
DROP TRIGGER IF EXISTS before_update_client;

-- Change the delimiter to allow special characters in the trigger
DELIMITER $$

-- Create the before_update_client trigger
-- This trigger fires before an update on the T_CLIENT_TRI table
CREATE TRIGGER before_update_client BEFORE UPDATE ON T_CLIENT_TRI
FOR EACH ROW 
BEGIN
    -- Log the modification information into the T_LOG_TRI table
    -- Records the timestamp and a message specifying the modified client
    INSERT INTO
        T_LOG_TRI (timestamp_log, msg_log)
    VALUES
        (
            now(),  -- Inserts the current time
            CONCAT (  -- Concatenates the text for the log message
                'Client modification in client table for client ',
                NEW.id_client  -- Retrieves the ID of the modified client
            )
        );

    -- Check the client type
    -- If the client type is different from 'P' (Person) and 'E' (Company)
    -- an error is raised, canceling the modification
    IF NEW.type_client IS NOT NULL
        AND NEW.type_client != 'P' -- Client type Person
        AND NEW.type_client != 'E' -- Client type Company
    THEN 
        -- Raise a custom error
        SIGNAL sqlstate '45000'	
        SET MESSAGE_TEXT = 'Modification canceled! Client type error for client ';
    END IF;
END $$

-- Return to the standard delimiter
DELIMITER ;

-- Second creation of the before_update_client trigger
-- This version modifies the client type to 'P' if an invalid client type is detected
-- It also inserts a record into the T_ERREUR_TRI table to log the error
DELIMITER $$

CREATE TRIGGER before_update_client BEFORE UPDATE ON T_CLIENT_TRI
FOR EACH ROW 
BEGIN
    -- Log the modification into T_LOG_TRI
    INSERT INTO
        T_LOG_TRI (timestamp_log, msg_log)
    VALUES
        (
            now(),  -- Date and time of the modification
            CONCAT (  -- Log message for the modification
                'Client modification in client table for client ',
                NEW.id_client  -- ID of the client involved
            )
        );

    -- Check the client type
    -- If the type is invalid (not 'P' or 'E'), it corrects the value
    IF NEW.type_client IS NOT NULL
        AND NEW.type_client != 'P' -- Client type Person
        AND NEW.type_client != 'E' -- Client type Company
    THEN 
        -- Correct the client type to 'P' (default)
        SET NEW.type_client = 'P';

        -- Log the error in T_ERREUR_TRI for later analysis
        INSERT INTO T_ERREUR_TRI (lib_error) VALUES
        (CONCAT ('Client type error for client ', NEW.id_client));
    END IF;
END $$

-- Return to the standard delimiter
DELIMITER ;
