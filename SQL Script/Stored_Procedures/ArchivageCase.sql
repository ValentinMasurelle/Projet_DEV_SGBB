INSERT INTO album VALUES(1, "Michael Jackson", "Thriller");
INSERT INTO album VALUES(2, "Daft Punk", "Random Access Memories");
INSERT INTO album VALUES(3, "Abbey Road", "The Beatles");




CREATE PROCEDURE ArchivageCase ()
    BEGIN
        DECLARE v_jour INT DEFAULT DATE_FORMAT(CURRENT_DATE(),"%d");
        CASE v_jour
            WHEN 1 THEN
                DELETE FROM album_archive;
                INSERT INTO album_archive(SELECT * FROM album);
            WHEN 10 THEN
                DELETE FROM album_archive_10;
                INSERT INTO album_archive_10(SELECT * FROM album);
             WHEN 13 THEN
                INSERT INTO album_archive_13(SELECT * FROM album);
        

