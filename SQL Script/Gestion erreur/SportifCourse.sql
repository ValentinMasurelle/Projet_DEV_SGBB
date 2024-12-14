/*=============================================================
|                   🏃 QUERY SportifCourse                    | 
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Create tables, manage courses for athletes|	
	using triggers with exceptions to manage errors .         |
|                                                             |
|                                                             |
|                                                             |
|  🗄️ DATABASE    : Comprendre SQL                            |
=============================================================*/


-- ------------------------------------------------------------
-- USE DATABASE
-- ------------------------------------------------------------

-- Switch to the 'ComprendreSQL' database for the following operations
USE ComprendreSQL;

-- ------------------------------------------------------------
-- DROP TABLES IF THEY EXIST (CLEANUP)
-- ------------------------------------------------------------

-- Drop the 'Sportif' table if it already exists
DROP TABLE IF EXISTS Sportif;

-- Drop the 'Course' table if it already exists
DROP TABLE IF EXISTS Course;

-- Drop the 'Participer' table if it already exists
DROP TABLE IF EXISTS Participer;

-- ------------------------------------------------------------
-- CREATE TABLE: Sportif
-- ------------------------------------------------------------

-- Create the 'Sportif' table to store athlete information
CREATE TABLE Sportif (
    numSportif BIGINT AUTO_INCREMENT NOT NULL, -- Unique identifier for the athlete with auto incrmentation and the bigint can't be NULL 
    nomSportif VARCHAR(20) NOT NULL,           -- Athlete's last name (up to 20 characters) and can't be NULL
    prenomSportif VARCHAR(20) NOT NULL,        -- Athlete's first name (up to 20 characters) and can't be NULL
    PRIMARY KEY (numSportif)                   -- Set 'numSportif' as the primary key 
) ENGINE=InnoDB;                               -- Use the InnoDB engine for transactional support

-- ------------------------------------------------------------
-- CREATE TABLE: Course
-- ------------------------------------------------------------

-- Create the 'Course' table to store race information
CREATE TABLE Course (
    numCourse BIGINT AUTO_INCREMENT NOT NULL,       -- Unique identifier for the race with auto incrmentation and the bigint can't be NULL
    libelleCourse VARCHAR(50) NOT NULL,             -- Race name or title (up to 50 characters) and can't be NULL
    dateCourse DATETIME NOT NULL,                   -- Date and time of the race and can't be NULL
    nbMaxParticipant INTEGER NOT NULL,              -- Maximum number of participants allowed and can't be NULL
    PRIMARY KEY (numCourse)                         -- Set 'numCourse' as the primary key and can't be NULL
) ENGINE=InnoDB;                                    -- Use the InnoDB engine for transactional support

-- ------------------------------------------------------------
-- CREATE TABLE: Participer
-- ------------------------------------------------------------

-- Create the 'Participer' table to track athlete participation in races
CREATE TABLE Participer (
    numSportif BIGINT NOT NULL,                     -- Athlete identifier (foreign key) and can't be NULL
    numCourse BIGINT NOT NULL,                      -- Race identifier (foreign key) and can't be NULL
    tempsParticipation FLOAT NULL,                  -- Participation time (optional) and can't be NULL
    PRIMARY KEY (numSportif, numCourse)             -- Composite primary key (athlete and race) 
) ENGINE=InnoDB;                                    -- Use the InnoDB engine for transactional support

-- ------------------------------------------------------------
-- ADD FOREIGN KEYS TO Participer TABLE
-- ------------------------------------------------------------

-- Add foreign key constraints to link 'Participer' to 'Sportif' and 'Course'
ALTER TABLE Participer 
    ADD CONSTRAINT FK_Participer_Sportif FOREIGN KEY (numSportif) REFERENCES Sportif (numSportif),
    ADD CONSTRAINT FK_Participer_Course FOREIGN KEY (numCourse) REFERENCES Course (numCourse);

-- ------------------------------------------------------------
-- INSERT DATA INTO Sportif TABLE
-- ------------------------------------------------------------

-- Insert sample data into the 'Sportif' table (athlete records)
INSERT INTO `Sportif` (`numSportif`, `nomSportif`, `prenomSportif`) 
VALUES 
    (1, 'MARTIN', 'Pierre'),
    (2, 'BERNARD', 'Jean'),
    (3, 'THOMAS', 'Jacques'),
    (4, 'PETIT', 'François'),
    (5, 'DURAND', 'Charles'),
    (6, 'RICHARD', 'Louis'),
    (7, 'DUBOIS', 'Jean-Baptiste'),
    (8, 'ROBERT', 'Joseph'),
    (9, 'LAURENT', 'Nicolas'),
    (10, 'SIMON', 'Antoine'),
    (11, 'MICHEL', 'Marie'),
    (12, 'LEROY', 'Marguerite');

-- ------------------------------------------------------------
-- INSERT DATA INTO Course TABLE
-- ------------------------------------------------------------

-- Insert sample data into the 'Course' table (race records)
INSERT INTO `Course` (`numCourse`, `libelleCourse`, `dateCourse`, `nbMaxParticipant`) 
VALUES 
    (1, 'Pique du Geek', '2009-03-14 08:00:00', 5),
    (2, 'Christmas Race', '2009-12-25 14:30:00', 30),
    (3, 'I Don’t Want to Run!', '2009-06-29 12:00:00', 11);

-- ------------------------------------------------------------
-- INSERT DATA INTO Participer TABLE
-- ------------------------------------------------------------

-- Insert participation records into the 'Participer' table
INSERT INTO `Participer` (`numSportif`, `numCourse`) 
VALUES 
    (1, 1),  -- Athlete 1 participates in race 1
    (4, 1),  -- Athlete 4 participates in race 1
    (5, 1),  -- Athlete 5 participates in race 1
    (8, 1),  -- Athlete 8 participates in race 1
    (9, 1);  -- Athlete 9 participates in race 1

-- ------------------------------------------------------------
-- SELECT QUERIES TO VIEW DATA
-- ------------------------------------------------------------

-- View all records from the 'Participer' table
SELECT * FROM `Participer`;

-- View all records from the 'Course' table
SELECT * FROM `Course`;

-- View all records from the 'Sportif' table
SELECT * FROM `Sportif`;

-- ------------------------------------------------------------
-- DROP TRIGGER IF EXISTS
-- ------------------------------------------------------------

-- Drop the 'tri_insert_participant' trigger if it already exists
DROP TRIGGER IF EXISTS tri_insert_participant;

-- ------------------------------------------------------------
-- CREATE TRIGGER: tri_insert_participant
-- ------------------------------------------------------------

-- Create a trigger to prevent inserting participants if the race is full
DELIMITER $$
CREATE TRIGGER tri_insert_participant BEFORE INSERT ON Participer
FOR EACH ROW
BEGIN
    DECLARE current_nb INT;  -- Current number of participants in the race
    DECLARE max_nb INT;      -- Maximum allowed participants for the race

    -- Get the current number of participants for the specified race
    SELECT COUNT(*) INTO current_nb FROM Participer WHERE numCourse = NEW.numCourse;
    -- Get the maximum allowed participants for the specified race
    SELECT nbMaxParticipant INTO max_nb FROM Course WHERE numCourse = NEW.numCourse;

    -- Log the current and maximum participant numbers (for debugging purposes)
    INSERT INTO T_LOG_TRI (timestamp_log, msg_log) 
    VALUES (NOW(), CONCAT('current_nb: ', current_nb, ' max_nb: ', max_nb));

    -- If the current number of participants reaches or exceeds the limit, raise an error
    IF (current_nb >= max_nb) THEN
        INSERT INTO T_LOG_TRI (timestamp_log, msg_log) 
        VALUES (NOW(), 'Trigger condition met: race is full');

        SIGNAL SQLSTATE '45000'  
        SET MESSAGE_TEXT = 'Insertion canceled! Error: too many participants';
    END IF;
END
$$
DELIMITER ;

-- ------------------------------------------------------------
-- JOIN QUERY TO VIEW PARTICIPATION DETAILS
-- ------------------------------------------------------------

-- Retrieve athlete names, race details, and participation times
SELECT 
    a.`nomSportif`,              -- Athlete's last name
    a.`prenomSportif`,           -- Athlete's first name
    c.`dateCourse`,              -- Race date
    c.`libelleCourse`,           -- Race name
    b.`tempsParticipation`       -- Participation time
FROM 
    `Sportif` a
JOIN 
    `Participer` b ON a.`numSportif` = b.`numSportif`
JOIN 
    `Course` c ON c.`numCourse` = b.`numCourse`;

-- ------------------------------------------------------------
-- ADD NEW ATHLETE AND PARTICIPATION
-- ------------------------------------------------------------

-- Insert a new athlete 'Margot LAREINE' into the 'Sportif' table
INSERT INTO `Sportif` (`numSportif`, `nomSportif`, `prenomSportif`) 
VALUES (13, 'LAREINE', 'Margot');

-- Attempt to insert the new athlete into race 1 (this might trigger the constraint)
INSERT INTO `Participer` (`numSportif`, `numCourse`) 
VALUES (13, 1);
