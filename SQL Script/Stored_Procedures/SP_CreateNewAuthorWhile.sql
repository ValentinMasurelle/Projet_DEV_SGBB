
DROP TABLE IF EXISTS Author;
CREATE TABLE IF NOT EXISTS Author
(
	id_author int NOT NULL AUTO_INCREMENT,
    name_author VARCHAR(200),
    CONSTRAINT pk_author PRIMARY KEY(id_author)
);
DROP PROCEDURE IF EXISTS createNewAuthor;
DELIMITER $$
CREATE Procedure createNewAuthor(IN p_nbrAuthor INT)
BEGIN
	DECLARE v_indice INT DEFAULT 0;
    delete from Author;
    WHILE v_indice < p_nbrAuthor DO
		INSERT INTO Author (name_author) VALUES (concat('Author_', v_indice));
        SET v_indice = v_indice + 1;
    END WHILE;
END;$$

DELIMITER ;

SET @nbAuthor = 10;

call createNewAuthor(@nbAuthor);

select * from Author;