DROP TRIGGER IF EXISTS before_update_client;
 
DELIMITER $$
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
END $$
DELIMITER;

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
		SET	NEW.type_client = 'P';
		INSERT INTO	T_ERREUR_TRI (lib_error) VALUES
		(CONCAT ('Erreur de type client pour le client ',NEW.id_client));
        
	END IF;
END $$