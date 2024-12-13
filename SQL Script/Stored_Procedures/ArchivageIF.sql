DELIMITER $$

CREATE PROCEDURE ArchivageIF ()
    BEGIN 
        DECLARE v_jour INT DEFAULT DATE_FORMAT(CURRENT_DATE(), "%d");
        IF(v_jour)