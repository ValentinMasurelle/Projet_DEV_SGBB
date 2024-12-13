
DELETE FROM `T_CLIENT_TRI` WHERE 1=1;
DELETE FROM `T_LOG_TRI` WHERE 1=1;
INSERT INTO
	T_CLIENT_TRI (nom_client, type_client)
VALUES
	('Gatean', 'G');
    
INSERT INTO
	T_CLIENT_TRI (nom_client, type_client)
VALUES
	('Yvette', 'Y');

SELECT * FROM `T_LOG_TRI`;
SELECT * FROM `ComprendreSQL`.`T_CLIENT_TRI`;
SHOW TRIGGERS;