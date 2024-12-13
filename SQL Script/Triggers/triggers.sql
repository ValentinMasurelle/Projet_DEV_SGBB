use comprendreSQL;
DROP TABLE IF EXISTS T_CLIENT_TRI;

DROP TABLE IF EXISTS T_LOG_TRI;

DROP TABLE IF EXISTS T_ERROR_LOG;

drop table if exists T_EMPRUNT_TRI;

CREATE TABLE T_CLIENT_TRI (
	id_client INT AUTO_INCREMENT,
	Nom_client VARCHAR(50),
	type_client CHAR(1),
	PRIMARY KEY (id_client)
);
CREATE TABLE T_EMPRUNT_TRI (
	id_emprunt INT AUTO_INCREMENT,
	id_client INT,
	type_emprunt CHAR(1),
	PRIMARY KEY (id_emprunt)
);

CREATE TABLE T_LOG_TRI (
	id_log INT AUTO_INCREMENT,
	timestamp_log DATETIME,
	msg_log VARCHAR(200),
	PRIMARY KEY (id_log)
);

CREATE TABLE T_ERREUR_TRI (
	id_error INT AUTO_INCREMENT,
	lib_error VARCHAR(200),
	PRIMARY KEY (id_error)
);

INSERT INTO
	T_EMPRUNT_TRI (id_client, type_emprunt)
VALUES
	(1, 'D');
    
-- Trigger INSERT BEFORE et AFTER de id_log
DROP TRIGGER trg_before_insert_client;

DROP TRIGGER trg_before_update_client;

--
-- BEFORE INSERT--
--
DELIMITER / / CREATE TRIGGER trg_before_insert_client BEFORE
INSERT
	ON T_CLIENT_TRI FOR EACH ROW BEGIN DECLARE user_name VARCHAR(20);

SELECT
	current_user() INTO user_name;

INSERT INTO
	T_LOG_TRI (timestamp_log, msg_log)
VALUES
	(
		now(),
		CONCAT (
			'Insertion table client Id et valeur',
			NEW.id_client,
			' - ',
			NEW.Nom_client,
			' - ',
			NEW.type_client,
			' - Auteur : ',
			user_name
		)
	);

END;

/ / DELIMITER;

--
-- AFTER INSERT
--
DELIMITER / / 
CREATE TRIGGER trg_after_insert_client AFTER INSERT	ON T_CLIENT_TRI 
FOR EACH ROW 
BEGIN 
DECLARE user_name VARCHAR(20);

SELECT
	current_user() INTO user_name;

INSERT INTO
	T_LOG_TRI (timestamp_log, msg_log)
VALUES
	(
		now(),
		CONCAT (
			'Insertion table client Id et valeur',
			NEW.id_client,
			' - ',
			NEW.Nom_client,
			' - ',
			NEW.type_client,
			' - Auteur : ',
			user_name
		)
	);

END;

/ / DELIMITER;
--
-- Invocation d'un ROLLBACK avec un trigger INSERT
--
DELIMITER //
CREATE TRIGGER TRG_INS_EMPRUNT
BEFORE INSERT 
ON T_EMPRUNT_TRI
FOR EACH ROW
BEGIN
	IF EXISTS(SELECT 1 FROM T_EMPRUNT_TRI A JOIN NEW N ON A.id_client = N.id_client HAVING COUNT(*) = 3) THEN
		ROLLBACK;
    END IF;    
END //
DELIMITER ;


-- TRIGGER BEFORE UPDATE
--
USE ComprendreSQL;

DROP TRIGGER IF EXISTS before_update_client;


 DELIMITER / / 
 CREATE TRIGGER before_update_client BEFORE UPDATE ON T_CLIENT_TRI 
 FOR EACH ROW BEGIN
 INSERT INTO
 T_LOG_TRI (timestamp_log, msg_log)
 VALUES
 (now(),	CONCAT ('modification table client sur client ',NEW.id_client));
 
 IF NEW.type_client IS NOT NULL
 AND NEW.type_client != 'P' -- type de client Personne
 AND NEW.type_client != 'E' -- type de client Entreprise
 THEN
 SET	NEW.type_client = 'P';
 INSERT INTO	T_ERREUR_TRI (lib_error) VALUES
 (CONCAT ('Erreur de type client pour le client ',NEW.id_client));
 END IF;
 
 END / / 
 DELIMITER ;
 
DELIMITER / / 
CREATE TRIGGER before_update_client BEFORE UPDATE ON T_CLIENT_TRI 
FOR EACH ROW 
BEGIN
	INSERT INTO
		T_LOG_TRI (timestamp_log, msg_log)
	VALUES
		(
			now(),
			CONCAT (
				'modification table client sur client ',
				NEW.id_client
			)
		);

	IF NEW.type_client IS NOT NULL
		AND NEW.type_client != 'P' -- type de client Personne
		AND NEW.type_client != 'E' -- type de client Entreprise
		THEN 
        SIGNAL sqlstate '45000'	
        SET	MESSAGE_TEXT = 'Modification annulée ! Erreur de type client pour le client ';
	END IF;
END / / 
DELIMITER;

show processlist;

SELECT
	current_user;

SELECT
	USER();

INSERT INTO
	T_CLIENT_TRI (nom_client, type_client)
VALUES
	('Peter', 'E');

INSERT INTO
	T_CLIENT_TRI (nom_client, type_client)
VALUES
	('Mary', 'E');

SELECT
	*
FROM
	`T_CLIENT_TRI`;

SELECT
	*
FROM
	`T_LOG_TRI`;

UPDATE
	`T_CLIENT_TRI`
SET
	type_client = 'X'
WHERE
	Nom_client = 'Mary';