DELIMITER $$

CREATE PROCEDURE ArchivageIF ()
    BEGIN 
        DECLARE v_jour INT DEFAULT DATE_FORMAT(CURRENT_DATE(), "%d");
        IF(v_jour = 13) THEN
        DELETE FROM album_archive
        INSERT INTO album_archive(SELECT * FROM album)
        END IF;
    END;

$$

DELIMITER ;

SELECT CURRENT_DATE();
SELECT DATE_FORMAT(CURRENT_DATE(),"d%");

CALL ARCHIVAGE_IF;


