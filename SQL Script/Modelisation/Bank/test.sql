-- Le chargeent doit se faire en root 
-- docker exec -it mysql bash 
-- cd data files --> on a les fichiers csv 
-- le script load in files en privilèges  

SHOW VARIABLES LIKE 'secure_file_priv';

SELECT CURRENT_USER

SHOW COLUMNS FROM `Bank`.`T_CLIENT`;

