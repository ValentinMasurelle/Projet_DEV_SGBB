/*=============================================================
|                 ✈️  QUERY ReservationVol.sql                | 
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Creates a stored procedure to manage      |
|                  flight reservations by checking seat       |
|                  availability before committing the         |
|                  transaction.                               |
|                                                             |
|                  The procedure:                             |
|                  - Checks if enough seats are available.    |
|                  - Updates seat count if possible.          |
|                  - Rolls back the transaction if not.       |
|                                                             |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

-- Active: 1734111287231@@127.0.0.1@3306@ComprendreSQL

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS ReservationVol;

DELIMITER $$

-- Create the stored procedure
CREATE PROCEDURE ReservationVol(
    IN pClientId INT,            -- Client ID for the reservation
    IN pVolId INT,               -- Flight ID for the reservation
    IN pNbPlacesDemande INT      -- Number of seats requested
)
BEGIN
    -- Declare messages for rollback and commit scenarios
    DECLARE rollback_message VARCHAR(255) DEFAULT 'Transaction rolled back: Insufficient places';
    DECLARE commit_message VARCHAR(255) DEFAULT 'Transaction committed successfully';
    
    -- Declare a variable to store available seats
    DECLARE NbPlacesLibres INT DEFAULT 0;

    -- Start the transaction
    START TRANSACTION;

        -- Get the number of available seats for the specified flight
        SELECT VOL_PLACES_LIBRES INTO NbPlacesLibres 
        FROM T_VOL 
        WHERE VOL_ID = pVolId;

        -- Check if there are enough available seats
        IF NbPlacesLibres >= pNbPlacesDemande THEN
            -- Update the available seats count in the flight table
            UPDATE T_VOL
            SET VOL_PLACES_LIBRES = VOL_PLACES_LIBRES - pNbPlacesDemande
            WHERE VOL_ID = pVolId;

            -- Insert the reservation details into the client-flight table
            INSERT INTO T_CLIENT_VOL 
            VALUES (pClientId, pVolId, pNbPlacesDemande);

            -- Commit the transaction if the update is successful
            COMMIT;
            SELECT commit_message AS 'Result';

        ELSE
            -- Rollback the transaction if there are not enough available seats
            ROLLBACK;
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = rollback_message;

        END IF;
END$$

DELIMITER ;
