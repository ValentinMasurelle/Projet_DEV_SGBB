CREATE VIEW `v_livres` AS
SELECT 
  livres.titre,
  livres.nbPages,
  livres.image,
  editeur.nomEditeur
FROM 
  livres
INNER JOIN 
  editeur 
ON 
  livres.id = editeur.livre_id;
