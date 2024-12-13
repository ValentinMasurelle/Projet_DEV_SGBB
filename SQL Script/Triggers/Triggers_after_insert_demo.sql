DROP TRIGGER IF EXISTS trg_after_insert_client;

DELIMITER $$ 
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

END;$$

 DELIMITER;