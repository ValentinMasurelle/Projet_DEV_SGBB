DELIMITER $$
CREATE PROCEDURE Affichage (OUT texte VARCHAR(200), OUT texte2
VARCHAR(200),OUT texte VARCHAR(200))
SELECT ‘texte0’ INTO texte ;
BEGIN
SELECT ‘texte1’ INTO texte 1;
END ;
SELECT ‘texte2’ INTO texte3 ;
$$
DELIMITER ;

CALL Affichage(@texte,@texte1,@texte2)
SELECT @texte,@texte1,@texte2