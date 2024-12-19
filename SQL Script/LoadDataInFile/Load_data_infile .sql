--LOAD DATA
--    [LOW_PRIORITY | CONCURRENT] [LOCAL]
--    INFILE 'file_name'
--    [REPLACE | IGNORE]
--    INTO TABLE tbl_name
--    [PARTITION (partition_name [, partition_name] ...)]
--    [CHARACTER SET charset_name]
--    [{FIELDS | COLUMNS}
--        [TERMINATED BY 'string']
--        [[OPTIONALLY] ENCLOSED BY 'char']
--        [ESCAPED BY 'char']
--    ]
--    [LINES
--        [STARTING BY 'string']
--        [TERMINATED BY 'string']
--    ]
--    [IGNORE number {LINES | ROWS}]
--    [(col_name_or_user_var
--        [, col_name_or_user_var] ...)]
--    [SET col_name={expr | DEFAULT}
--        [, col_name={expr | DEFAULT}] ...]
-- Lors du chargement il peut-être nécessaire de dissocier les foreign key
-- SET FOREIGN_KEY_CHECKS=0; dissocier
-- SET FOREIGN_KEY_CHECKS=1; associer
-- Autre attention, pour importer des données, avec MYSQL docker, il est nécessaire de configurer la mise en oeuvre du container Mysql comme suit :
-- Dans le fichier docker-compose.yml on y ajouter les paramètres :
--
---- Files
--      - ./data_files:/data_files  le montange de ce volume est nécessaire pour déposer les fichiers sources
---- Config
--		Lorsque on installe un container Mysql, les options de configuration sont localisées dans /etc/mysql.my.cnf.d
--		Mais on l'a dèjà mentionné, une fois un container fermé, rien n'est persisté !
--		On va donc mapper un répertoire sur la machone hôte et le containeur, comme si dessus.
--		Dans le répertoire (hôte) locale, on va y mettre un fichier de configuration, avec les options à ajouter.conf
--		Dans notre cas, il est nécessaire de stipuler à mysql que le répertoire de chargement pour l'exécution de LOAD DATA FILE.conf
--		Cette spécification est indiquée dans l'option secure-file-priv
--		[mysqld]
--		secure-file-priv = "/data_files"
--		Pour contrôler l'option : SHOW VARIABLES LIKE "secure_file_priv";
--      - /home/xavier/Docker/web_php/mysql8/conf.d:/etc/mysql/conf.d
--
--      -- Dirs
--
-- Remarque : avant de charger une table avec un AUTO_INCRFEMENT, il faut s'assurer de partir de zéro
-- Comment faire ...
-- 1. ALTER TABLE nomDeLaTable AUTO_INCREMENT=0
-- 2. A la création de la table mettre l'option AUTO_INCREMENT=0
--
-- Commençons par dissocier les foreign keys
SHOW VARIABLES LIKE 'local_infile';

SHOW VARIABLES LIKE "secure_file_priv";
SET
  FOREIGN_KEY_CHECKS = 0;
-- 1. Chargement de la table client
LOAD DATA INFILE "/var/lib/mysql-files/Client.csv" 
INTO TABLE `Bank`.`T_CLIENT`
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
(CLIENT_Lastname, CLIENT_Firstname, CLIENT_City, CLIENT_ZipCode);

SELECT
  *
FROM
  `Bank`.`T_CLIENT`;
-- 2. Chargement de la table agence
  LOAD DATA INFILE "/var/lib/mysql-files/agence.csv" INTO TABLE `Bank`.`agence` FIELDS TERMINATED BY ';' ENCLOSED BY '' LINES TERMINATED BY '\n' (nom, actif);
SELECT
  *
FROM
  `Bank`.`agence`;
-- 3. Chargement de la table compte
  LOAD DATA INFILE "/var/lib/mysql-files/compte.csv" INTO TABLE `Bank`.`compte` FIELDS TERMINATED BY ';' ENCLOSED BY '' LINES TERMINATED BY '\n' (
    numclient,
    numagence,
    numcompte,
    solde
  );
SELECT
  *
FROM
  `Bank`.`compte`;
-- 4.Chargement de la table numemprunt
  LOAD DATA INFILE "/var/lib/mysql-files/emprunt.csv" INTO TABLE `Bank`.`emprunt` FIELDS TERMINATED BY ';' ENCLOSED BY '' LINES TERMINATED BY '\n' (
    numagence,
    numclient,
    numemprunt,
    montant
  );
SELECT
  *
FROM
  `Bank`.`emprunt`;
-- Une fois les chargements effectués, on peut réactiver les foreign key. Et si les données sont correctes, cela ne doit pas pas poser de problèmes
SET
  FOREIGN_KEY_CHECKS = 1;