-- Create view statement
-- CREATE [OR REPLACE] VIEW [db_name.]view_name [(column_list)]
-- AS
--   select-statement;
-- Dans cette syntaxe, on retrouve les mots clès CREATE VIEW, le nom donné à la view sera unique dans la base de données.
-- L'option OR REPLACE permet de remplacer une view existante, si la view n'existe pas cette option n'a pas d'effet.
-- Le mot clès SELECT permet de selectionné les données d'une ou plusieurs tables, avec toutes les options que l'on trouve dans un SELECT.

DROP TABLE IF EXISTS `orderdetails`;

CREATE TABLE `orderdetails` (
  `orderNumber` int(11) NOT NULL,
  `productCode` varchar(15) NOT NULL,
  `quantityOrdered` int(11) NOT NULL,
  `priceEach` decimal(10,2) NOT NULL,
  `orderLineNumber` smallint(6) NOT NULL,
  PRIMARY KEY (`orderNumber`,`productCode`),
  KEY `productCode` (`productCode`)  
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE VIEW 'ComprendreSQL'.'salePerOrder' AS
    SELECT 
        orderNumber, 
        SUM(quantityOrdered * priceEach) total
    FROM
        orderdetails
    GROUP by orderNumber
    ORDER BY total DESC;
    
-- Si je fais un SHOW TABLES; je peux constater que la view sera display comme une table traditionnel. 
-- Mais avec un SHOW FULL TABLES, on constate que le table_type est VIEW.  
-- Une VIEW ne prend pas de paramétres.

