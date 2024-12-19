/*=============================================================
|                   📦 QUERY ArchivageCase.sql                | 
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Create SP ArchivageCase to archive albums |
|                    on specific days using CASE logic        |
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

-- Drop the 'album_archive_10' table if it already exists to avoid conflicts
DROP TABLE IF EXISTS album_archive_10;

-- Drop the 'album_archive_20' table if it already exists to avoid conflicts
DROP TABLE IF EXISTS album_archive_20;

-- ------------------------------------------------------------
-- CREATE TABLE: album
-- ------------------------------------------------------------

-- Create the 'album' table to store album information
CREATE TABLE album (
    id_album INT,              -- Unique identifier for each album
    Nom_album VARCHAR(150)     -- Name of the album (including release year)
);

-- ------------------------------------------------------------
-- INSERT DATA INTO album TABLE
-- ------------------------------------------------------------

-- Insert sample albums into the 'album' table
INSERT INTO album VALUES (1, 'Sgt. Pepper’s Lonely Hearts Club Band (1967)');
INSERT INTO album VALUES (2, 'Whatever People Say I Am, That’s What I’m Not (2006)');
INSERT INTO album VALUES (3, 'OK Computer (1997)');

-- ------------------------------------------------------------
-- CREATE TABLE: album_archive
-- ------------------------------------------------------------

-- Create the 'album_archive' table to store archived albums for the 1st day of the month
CREATE TABLE album_archive (
    id_album INT,              -- Unique identifier for each archived album
    Nom_album VARCHAR(150)     -- Name of the archived album
);

-- ------------------------------------------------------------
-- CREATE TABLE: album_archive_10
-- ------------------------------------------------------------

-- Create the 'album_archive_10' table to store archived albums for the 10th day of the month
CREATE TABLE album_archive_10 (
    id_album INT,              -- Unique identifier for each archived album
    Nom_album VARCHAR(150)     -- Name of the archived album
);

-- ------------------------------------------------------------
-- CREATE TABLE: album_archive_20
-- ------------------------------------------------------------

-- Create the 'album_archive_20' table to store archived albums for the 20th day of the month
CREATE TABLE album_archive_20 (
    id_album INT,              -- Unique identifier for each archived album
    Nom_album VARCHAR(150)     -- Name of the archived album
);

-- ------------------------------------------------------------
-- DROP PROCEDURE IF IT EXISTS
-- ------------------------------------------------------------

-- Drop the procedure 'ArchivageCase' if it already exists to avoid conflicts
DROP PROCEDURE IF EXISTS `ArchivageCase`; 

-- ------------------------------------------------------------
-- CREATE PROCEDURE: ArchivageCase
-- ------------------------------------------------------------

-- Create a stored procedure 'ArchivageCase' to archive albums based on the current day of the month
DELIMITER $$

CREATE PROCEDURE ArchivageCase () 
    BEGIN
        -- Declare a variable 'v_jour' to store the current day of the month
        DECLARE v_jour INT DEFAULT DATE_FORMAT(CURRENT_DATE(), '%d');
        
        -- Use CASE to determine which table to archive into based on 'v_jour'
        CASE v_jour
            WHEN 1 THEN
                -- Archive albums into 'album_archive' on the 1st of the month
                DELETE FROM album_archive;
                INSERT INTO album_archive (SELECT * FROM album);
            WHEN 10 THEN
                -- Archive albums into 'album_archive_10' on the 10th of the month
                DELETE FROM album_archive_10;
                INSERT INTO album_archive_10 (SELECT * FROM album);
            WHEN 20 THEN
                -- Archive albums into 'album_archive_20' on the 20th of the month
                DELETE FROM album_archive_20;
                INSERT INTO album_archive_20 (SELECT * FROM album);
        END CASE;
    END;
$$

DELIMITER ;

-- ------------------------------------------------------------
-- DISPLAY CURRENT DATE
-- ------------------------------------------------------------

-- Select and display the current day of the month
SELECT DATE_FORMAT(CURRENT_DATE(), '%d');

-- ------------------------------------------------------------
-- CALL PROCEDURE: ArchivageCase
-- ------------------------------------------------------------

-- Call the 'ArchivageCase' procedure to perform archiving based on the current day
CALL `ArchivageCase`();

-- ------------------------------------------------------------
-- VIEW DATA IN TABLES
-- ------------------------------------------------------------

-- Display the contents of the 'album' table
SELECT * FROM album;

-- Display the contents of the 'album_archive' table to check if archiving worked for the 1st
SELECT * FROM album_archive;

-- Display the contents of the 'album_archive_10' table to check if archiving worked for the 10th
SELECT * FROM album_archive_10;

-- Display the contents of the 'album_archive_20' table to check if archiving worked for the 20th
SELECT * FROM album_archive_20;
