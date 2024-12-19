/*=============================================================
|                   ✈️ QUERY Vol_Client                       |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Create database, manage flights, 		  |	
	client reservations.                                      |
|                                                             |
|                                                             |
|                                                             |
|  🗄️ DATABASE    : Comprendre SQL                            |
=============================================================*/



-- Drop the 'ComprendreSQL' database if it already exists
DROP DATABASE IF EXISTS `ComprendreSQL`;

-- Create a new database named 'ComprendreSQL'
CREATE DATABASE `ComprendreSQL`;

-- Use the 'ComprendreSQL' database for the following queries
USE ComprendreSQL;

-- Create the 'T_VOL' table to store flight information
CREATE TABLE T_VOL (
    VOL_ID INTEGER,              -- Unique identifier for the flight
    VOL_REFERENCE CHAR(6),       -- Flight reference (6 characters)
    VOL_PLACES_LIBRES INTEGER    -- Number of available seats on the flight
);

-- Create the 'T_CLIENT_VOL' table to manage client reservations
CREATE TABLE T_CLIENT_VOL (
    CLI_ID INTEGER,              -- Client identifier
    VOL_ID INTEGER,              -- Flight identifier for the reservation
    VOL_PLACE_PRISE INTEGER      -- Number of seats reserved by the client
);

-- Create the 'T_CLIENT' table to store client information
CREATE TABLE T_CLIENT (
    CLI_ID INTEGER,              -- Unique identifier for the client
    CLI_NOM VARCHAR(50)          -- Client's name (up to 50 characters)
);

-- Insert data into the 'T_CLIENT' table
INSERT INTO T_CLIENT VALUES (1, 'Mickey');
INSERT INTO T_CLIENT VALUES (2, 'Donald');
INSERT INTO T_CLIENT VALUES (4, 'Goofy');
INSERT INTO T_CLIENT VALUES (5, 'Pluto');

-- Insert data into the 'T_VOL' table
INSERT INTO T_VOL VALUES (1, 'AF 714', 7);   -- Flight AF 714 with 7 available seats
INSERT INTO T_VOL VALUES (2, 'AF 812', 6);   -- Flight AF 812 with 6 available seats
INSERT INTO T_VOL VALUES (4, 'AF 325', 258); -- Flight AF 325 with 258 available seats

-- Insert data into the 'T_CLIENT_VOL' table (client reservations)
INSERT INTO T_CLIENT_VOL VALUES (7, 1, 2);   -- Client 7 reserved 2 seats on flight 1
INSERT INTO T_CLIENT_VOL VALUES (82, 4, 1);  -- Client 82 reserved 1 seat on flight 4

-- Select all records from the 'T_CLIENT_VOL' table
SELECT * FROM T_CLIENT_VOL;

-- Select all records from the 'T_VOL' table
SELECT * FROM T_VOL;

-- Select all records from the 'T_CLIENT' table
SELECT * FROM T_CLIENT;

-- Insert another record for Pluto (client ID 5) into the 'T_CLIENT' table
INSERT INTO T_CLIENT VALUES (5, 'Pluto');

-- Retrieve client details and their flight reservations for client ID 4
SELECT 
    a.`CLI_ID`,                 -- Client ID
    a.`CLI_NOM`,                -- Client name
    c.`VOL_REFERENCE`,          -- Flight reference
    b.`VOL_PLACE_PRISE`         -- Number of seats reserved
FROM 
    T_CLIENT a
JOIN 
    T_CLIENT_VOL b ON a.`CLI_ID` = b.`CLI_ID`
JOIN 
    T_VOL c ON b.`VOL_ID` = c.`VOL_ID`
WHERE 
    a.CLI_ID = 4;

-- Joining the table T_CLIENT_VOL with alias b to T_CLIENT with the CLI_ID from the two tables
-- Joining the table T_VOL with alias c to T_CLIENT with the VOL_ID from the two tables  

-- Retrieve the number of available seats for flight ID 4
SELECT VOL_PLACES_LIBRES FROM T_VOL WHERE VOL_ID = 4;

-- Call a stored procedure 'ReservationVol' to make a reservation (parameters: client ID 5, flight ID 2, 1 seat)
CALL ReservationVol(5, 2, 1);

-- Drop the 'test' user if it exists on the localhost server
DROP USER 'test'@'localhost';
