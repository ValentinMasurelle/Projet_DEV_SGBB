-- Suppression de toutes les lignes de la table T_CLIENT_TRI
-- Cette commande supprime toutes les entrées de la table T_CLIENT_TRI.
DELETE FROM `T_CLIENT_TRI` WHERE 1=1;

-- Suppression de toutes les lignes de la table T_LOG_TRI
-- Cette commande supprime toutes les entrées de la table T_LOG_TRI.
DELETE FROM `T_LOG_TRI` WHERE 1=1;

-- Insertion d'une nouvelle ligne dans la table T_CLIENT_TRI
-- Cette commande ajoute un client nommé 'Gatean' avec un type de client 'G'.
INSERT INTO
    T_CLIENT_TRI (nom_client, type_client)
VALUES
    ('Gatean', 'G');
    
-- Insertion d'une nouvelle ligne dans la table T_CLIENT_TRI
-- Cette commande ajoute un client nommé 'Yvette' avec un type de client 'Y'.
INSERT INTO
    T_CLIENT_TRI (nom_client, type_client)
VALUES
    ('Yvette', 'Y');

-- Sélection de toutes les entrées dans la table T_LOG_TRI
-- Cette commande affiche toutes les entrées de la table T_LOG_TRI pour vérification.
SELECT * FROM `T_LOG_TRI`;

-- Sélection de toutes les entrées dans la table T_CLIENT_TRI
-- Cette commande affiche toutes les entrées de la table T_CLIENT_TRI pour vérification.
SELECT * FROM `ComprendreSQL`.`T_CLIENT_TRI`;

-- Affichage des triggers existants dans la base de données
-- Cette commande affiche la liste des triggers associés à la base de données actuelle.
SHOW TRIGGERS;
