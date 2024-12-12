-- Active: 1733166735969@@127.0.0.1@3306
--
DROP DATABASE IF EXISTS `ComprendreSQL`;
CREATE DATABASE `ComprendreSQL`;
USE ComprendreSQL;
CREATE TABLE T_VOL (
	VOL_ID INTEGER,
	VOL_REFERENCE CHAR(6),
	VOL_PLACES_LIBRES INTEGER);

CREATE TABLE T_CLIENT_VOL (
	CLI_ID INTEGER,
	VOL_ID INTEGER,
	VOL_PLACE_PRISE INTEGER);

CREATE TABLE T_CLIENT (
	CLI_ID INTEGER,
	CLI_NOM VARCHAR(50));

INSERT INTO
	T_CLIENT
VALUES
	(1, 'Mickey');
	INSERT INTO
	T_CLIENT
VALUES
	(2, 'Donald');
	INSERT INTO
	T_CLIENT
VALUES
	(4, 'Dingo');
INSERT INTO
	T_CLIENT
VALUES
	(5, 'Pluto');

INSERT INTO
	T_VOL
VALUES
	(1, 'AF 714', 7);

INSERT INTO
	T_VOL
VALUES
	(2, 'AF 812', 6);

INSERT INTO
	T_VOL
VALUES
	(4, 'AF 325', 258);

INSERT INTO
	T_CLIENT_VOL
VALUES
	(7, 1, 2);

INSERT INTO
	T_CLIENT_VOL
VALUES
	(82, 4, 1);
SELECT * FROM T_CLIENT_VOL; 
SELECT * FROM T_VOL;
SELECT * FROM T_CLIENT;

INSERT INTO
	T_CLIENT
VALUES
	(5, 'Pluto');
SELECT a.`CLI_ID`,a.`CLI_NOM`,c.`VOL_REFERENCE`,b.`VOL_PLACE_PRISE` FROM T_CLIENT a 
JOIN T_CLIENT_VOL b ON a.`CLI_ID` = b.`CLI_ID` 
JOIN T_VOL c ON b.`VOL_ID` = c.`VOL_ID`
WHERE a.CLI_ID = 4;

SELECT VOL_PLACES_LIBRES FROM T_VOL WHERE VOL_ID = 4;
CALL ReservationVol(5,2,1);
