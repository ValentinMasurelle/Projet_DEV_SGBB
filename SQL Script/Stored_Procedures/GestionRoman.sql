-- Cette mise en oeuvre est à exécuter dans une DB appelée Biblio
USE Biblio;
DROP TABLE IF EXISTS estDans;
DROP TABLE IF EXISTS serie;
DROP TABLE IF EXISTS roman;
DROP TABLE IF EXISTS lecteur;

CREATE TABLE IF not EXISTS roman
(
	code_ISBN VARCHAR(17) NOT NULL,
	nom VARCHAR(200),
    auteur VARCHAR(200) DEFAULT 'auteur inconnu',
    annee YEAR,
    prix DECIMAL(15,2),
    CONSTRAINT pk_roman PRIMARY KEY(code_ISBN)
);

CREATE TABLE IF not EXISTS serie
(
	code_serie INT NOT NULL AUTO_INCREMENT,
    nom_serie VARCHAR(200),
    CONSTRAINT pk_serie PRIMARY KEY(code_serie)
);

CREATE TABLE IF NOT EXISTS estDans
(
	code_ISBN VARCHAR(17) NOT NULL,
    code_serie INT,
    CONSTRAINT pk_estDans PRIMARY KEY(code_ISBN, code_serie),
    FOREIGN KEY (code_ISBN) REFERENCES roman(code_ISBN),
    FOREIGN KEY (code_serie) REFERENCES serie(code_serie)
);

INSERT INTO serie(code_serie, nom_serie) VALUES (1, "Le Seigneur des anneaux");
INSERT INTO serie(code_serie, nom_serie) VALUES (2, "Harry Potter");
INSERT INTO serie(code_serie, nom_serie) VALUES (3, "Les robots");
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("1", "La Communauté de l'anneau", "JRR Tolkien", "1954", 5.65);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("2", "Les deux tours", "JRR Tolkien", "1954", 7.25);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("3", "Le retour du roi", "JRR Tolkien", "1955", 8.55);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("4", "Harry Potter à l'école des sorciers", "JK Rowling", "1998", 4.75);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("5", "Harry Potter et la chambre des secrets", "JK Rowling", "1999", 5.05);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("6", "Harry Potter et le Prisonnier d'Azkaban", "JK Rowling", "1999", 7.55);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("7", "Neverwhere", "Neil Gaiman", "1996", 8.45);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("8", "Stardust", "Neil Gaiman", "1999", 8.54);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("9", "Les robots", "Isaac Asimov", "1967", 3.25);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("10", "Un défilé de robots", "Isaac Asimov", "1967", 4.85);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("11", "Nous les robots", "Isaac Asimov", "1982", 5.25);
INSERT INTO roman (code_ISBN, nom, auteur, annee, prix) VALUES ("12", "Le robot qui rêvait", "Isaac Asimov", "1988", 8.25);
INSERT INTO estDans(code_ISBN, code_serie) VALUES ("1", 1);
INSERT INTO estDans(code_ISBN, code_serie) VALUES ("2", 1);
INSERT INTO estDans(code_ISBN, code_serie) VALUES ("3", 1);
INSERT INTO estDans(code_ISBN, code_serie) VALUES ("4", 2);
INSERT  INTO estDans(code_ISBN, code_serie) VALUES ("5", 2);
INSERT  INTO estDans(code_ISBN, code_serie) VALUES ("6", 2);
INSERT  INTO estDans(code_ISBN, code_serie) VALUES ("9", 3);
INSERT  INTO estDans(code_ISBN, code_serie) VALUES ("10", 3);
INSERT  INTO estDans(code_ISBN, code_serie) VALUES ("11", 3);
INSERT  INTO estDans(code_ISBN, code_serie) VALUES ("12", 3);

INSERT  INTO roman (code_ISBN, nom, annee, prix) VALUES ("13", "L'incroyable Maurice", "1988", 5.00);

SELECT * FROM roman;


CREATE TABLE IF NOT EXISTS lecteur
(
	code_lecteur int,
    nom_lecteur VARCHAR(200),
    CONSTRAINT pk_lecteur PRIMARY KEY(code_lecteur)
);

INSERT  INTO lecteur (code_lecteur, nom_lecteur) VALUES (1, 'Bob');
INSERT  INTO lecteur (code_lecteur, nom_lecteur) VALUES (2, 'Kim');
INSERT  INTO lecteur (code_lecteur, nom_lecteur) VALUES (3, 'Mike');