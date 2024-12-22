/*===================================================================
|                     📝 SQL SCRIPT: View Creation                  |
|-------------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                             |
|  📅 DATE        : 2024-12-22                                      |
|  📝 DESCRIPTION : This SQL script creates a view named `v_livres` 
|                  that consolidates book information from the 
|                  `livres` table and corresponding editor details 
|                  from the `editeur` table. This view is intended 
|                  for simplified access to combined book and 
|                  editor information in the library system.
====================================================================*/

-- Dropping the view if it already exists to ensure the script is idempotent
DROP VIEW IF EXISTS `v_livres`;

-- Creating the view `v_livres`
CREATE OR REPLACE VIEW `v_livres` AS
SELECT
  livres.id,          -- The unique identifier for the book
  livres.titre,       -- The title of the book
  livres.nbPages,     -- The number of pages in the book
  livres.image,       -- The image or cover associated with the book
  editeur.nomEditeur  -- The name of the editor associated with the book
FROM 
  livres
INNER JOIN 
  editeur 
ON 
  livres.id = editeur.livre_id;  -- Joining books and editors by their relationship