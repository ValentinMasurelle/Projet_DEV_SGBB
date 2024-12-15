/*=============================================================
|                   ☔QUERY Archivage.sql                    | 
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Create SP ArchivageIF to archive albums   |	
|                    on a specified day using IF logic       |
|                                                             |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

-- ------------------------------------------------------------
-- DROP TABLES IF THEY EXIST
-- ------------------------------------------------------------

-- Drop the 'album' table if it already exists to avoid conflicts
DROP TABLE IF EXISTS album;

-- Drop the 'album_archive' table if it already exists to avoid conflicts
DROP TABLE IF EXISTS album_archive;

-- ------------------------------------------------------------
-- CREATE TABLE: album
-- ------------------------------------------------------------

-- Create the 'album' table to store album information
CREATE TABLE album (
    id_album INT,              -- Unique identifier for each album
    Nom_album VARCHAR(150)     -- Name of the album (including release year)
);

-- ------------------------------------------------------------
-- CREATE TABLE: album_archive
-- ------------------------------------------------------------

-- Create the 'album_archive' table to store archived albums
CREATE TABLE album_archive (
    id_album INT,              -- Unique identifier for each archived album
    Nom_album VARCHAR(150)     -- Name of the archived album (including release year)
);

-- ------------------------------------------------------------
-- INSERT DATA INTO album TABLE
-- ------------------------------------------------------------

-- Insert sample albums into the 'album' table
INSERT INTO album VALUES (1, 'Sgt. Pepper’s Lonely Hearts Club Band (1967)');
INSERT INTO album VALUES (2, 'Whatever People Say I Am, That’s What I’m Not (2006)');
INSERT INTO album VALUES (3, 'OK Computer (1997)');

-- ------------------------------------------------------------
-- DROP PROCEDURE IF IT EXISTS
-- ------------------------------------------------------------

-- Drop the procedure 'ArchivageIF' if it already exists to avoid conflicts
DROP PROCEDURE IF EXISTS `ArchivageIF`; 

-- ------------------------------------------------------------
-- CREATE PROCEDURE: ArchivageIF
-- ------------------------------------------------------------

-- Create a stored procedure 'ArchivageIF' that archives albums if the current day matches the specified day
DELIMITER $$

CREATE PROCEDURE ArchivageIF (IN jour INT) 
    BEGIN
        -- Declare a variable 'v_jour' to store the current day (as an integer)
        DECLARE v_jour INT DEFAULT DATE_FORMAT(CURRENT_DATE(), '%d');

        -- Check if the current day matches the specified 'jour' parameter
        IF (v_jour = jour) THEN
            -- If the condition is true, clear the 'album_archive' table
            DELETE FROM album_archive;

            -- Insert all records from the 'album' table into the 'album_archive' table
            INSERT INTO album_archive (SELECT * FROM album);
        END IF;
    END;
$$

DELIMITER ;  -- Reset the delimiter back to semicolon (default)

-- ------------------------------------------------------------
-- CHECK CURRENT DATE
-- ------------------------------------------------------------

-- Display the current date to verify the context for running the procedure
SELECT CURRENT_DATE();

-- Display the day of the current date in two-digit format (e.g., '14' for the 14th)
SELECT DATE_FORMAT(CURRENT_DATE(), '%d');

-- ------------------------------------------------------------
-- CALL THE PROCEDURE: ArchivageIF
-- ------------------------------------------------------------

-- Call the 'ArchivageIF' procedure, specifying '13' as the day for archiving
CALL `ArchivageIF`(13);

-- ------------------------------------------------------------
-- DISPLAY DATA FROM TABLES
-- ------------------------------------------------------------

-- Display all records from the 'album' table
SELECT * FROM album;

-- Display all records from the 'album_archive' table to check if archiving was successful
SELECT * FROM album_archive;

-- ------------------------------------------------------------
-- CLEAN UP ARCHIVE TABLE
-- ------------------------------------------------------------

-- Delete all records from the 'album_archive' table to reset it
DELETE FROM album_archive WHERE 1=1;
