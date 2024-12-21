/*===================================================================
|                     📝 SQL SCRIPT: Table and Data Setup            |
|-------------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                             |
|  📅 DATE        : 2024-12-20                                       |
|  📝 DESCRIPTION : This SQL script sets up a database table for 
|                  storing book information (livres) in a library 
|                  system. It includes the creation of the table, 
|                  inserting initial data, and modifying the table 
|                  to include an auto-incrementing primary key.     |
====================================================================*/

CREATE TABLE `editeur` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,  -- Primary key for the editor
  `nomEditeur` VARCHAR(100) NOT NULL,   -- Editor's name
  `livre_id` INT(11),                   -- Foreign key to reference a book
  PRIMARY KEY (`id`),                   -- Defining the primary key
  CONSTRAINT `FK_livre_editeur`         -- Foreign key constraint name
    FOREIGN KEY (`livre_id`)            -- Foreign key column in editeur
    REFERENCES `livres` (`id`)          -- References livres(id)
    ON DELETE CASCADE                   -- Delete editor if related book is deleted
    ON UPDATE CASCADE                   -- Update editor if related book is updated
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Insertion des éditeurs
INSERT INTO `editeur` (`nomEditeur`, `livre_id`) VALUES
('Editeur1', 1),
('Editeur1', 3),
('Editeur2', 2),
('Editeur2', 4);
