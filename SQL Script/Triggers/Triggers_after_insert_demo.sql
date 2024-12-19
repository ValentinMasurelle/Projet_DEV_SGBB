/*=============================================================
|                   📝 QUERY: trg_after_insert_client.sql     |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                     |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Trigger to log after inserting a client  |
|                                                         |
|                                                         |
|                                                         |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

-- Drop the existing trigger if it already exists
DROP TRIGGER IF EXISTS trg_after_insert_client;

-- Set the delimiter to allow the use of ';' inside the trigger
DELIMITER $$

-- Create the trigger trg_after_insert_client
-- This trigger fires after a row is inserted into the T_CLIENT_TRI table
CREATE TRIGGER trg_after_insert_client 
AFTER INSERT ON T_CLIENT_TRI
FOR EACH ROW 
BEGIN 
    -- Declare a variable to store the current user's name
    DECLARE user_name VARCHAR(20);

    -- Fetch the current user and store it in the variable
    SELECT current_user() INTO user_name;

    -- Log the modification in the T_LOG_TRI table
    -- Insert the current timestamp and a detailed message about the insertion
    INSERT INTO
        T_LOG_TRI (timestamp_log, msg_log)
    VALUES
        (
            now(),  -- Insert the current timestamp
            CONCAT(  -- Concatenate a detailed message for the log
                'Insertion into client table. ID: ',
                NEW.id_client,       -- ID of the inserted client
                ' - Name: ', NEW.Nom_client,  -- Name of the client
                ' - Type: ', NEW.type_client,  -- Type of the client
                ' - Author: ', user_name       -- User who performed the insertion
            )
        );
END $$

-- Reset the delimiter to the default
DELIMITER ;
