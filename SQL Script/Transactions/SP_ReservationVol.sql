-- Active: 1733476523797@@127.0.0.1@3306@ComprendreSQL
DROP PROCEDURE ReservationVol;
DELIMITER $$
CREATE PROCEDURE ReservationVol(
    IN pClientId INT, 
    IN pVolId INT,
    IN pNbPlacesDemande INT
)
BEGIN
    DECLARE rollback_message VARCHAR(255) DEFAULT 'Transaction rolled back: Insufficient places';
    DECLARE commit_message VARCHAR(255) DEFAULT 'Transaction committed successfully';
    DECLARE NbplacesLibres INT DEFAULT 0;
    
    START TRANSACTION;
        
        SELECT VOL_PLACES_LIBRES INTO NbPlacesLibres FROM T_VOL WHERE VOL_ID = pVolId;

        IF NbPlacesLibres >= pNbPlacesDemande THEN
            UPDATE T_VOL
            SET VOL_PLACES_LIBRES = VOL_PLACES_LIBRES - pNbPlacesDemande
            WHERE VOL_ID = pVolId;
            INSERT INTO T_CLIENT_VOL 
            VALUES (pClientId,pVolId,pNbPlacesDemande);
            COMMIT;
            SELECT commit_message AS 'Result';

        ELSE

            ROLLBACK;
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = rollback_message;

        END IF;
END$$

DELIMITER ;