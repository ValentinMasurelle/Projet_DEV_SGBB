/*=============================================================
|                   ☔QUERY Vetement.sql                     | 
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Create SP Vetement with CASE              |	
	                                                          |
|                                                             |
|                                                             |
|                                                             |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/


-- ------------------------------------------------------------
-- DROP PROCEDURE IF IT EXISTS
-- ------------------------------------------------------------

-- Drop the procedure 'Vetement' if it already exists to avoid any conflicts.
DROP PROCEDURE IF EXISTS `Vetement`; 

-- ------------------------------------------------------------
-- CREATE PROCEDURE: Vetement
-- ------------------------------------------------------------

-- Create a stored procedure named 'Vetement' that takes 2 IN parameters and 1 OUT parameter
-- The procedure will return a suggested item of clothing based on temperature and weather conditions.
DELIMITER $$

CREATE PROCEDURE Vetement (
    IN p_tp INT,              -- IN parameter 'p_tp' (temperature in Celsius)
    IN p_temps VARCHAR(50),   -- IN parameter 'p_temps' (weather condition such as 'Beau', 'Pluvieux', etc.)
    OUT p_vet VARCHAR(50)     -- OUT parameter 'p_vet' (suggested item of clothing based on the conditions)
)    
BEGIN
    -- Initialize the OUT parameter with a default value
    SET p_vet = 'Casquette';  -- Default value (for all other conditions)

    -- Use IF statements to determine the appropriate clothing based on temperature and weather conditions
    IF p_tp < 5 AND (p_temps = 'Beau' OR p_temps = 'Nuageux') THEN
        SET p_vet = 'Manteau';
    ELSEIF p_tp < 20 AND p_temps = 'Pluvieux' THEN
        SET p_vet = 'Impermeable';
    ELSEIF p_tp >= 20 AND p_temps = 'Pluvieux' THEN
        SET p_vet = 'Parapluie';
    ELSEIF p_tp >= 5 AND p_tp < 20 AND p_temps = 'Nuageux' THEN
        SET p_vet = 'Veste';
    END IF;
    
    -- No need for a final ELSE, because 'Casquette' is already the default value

END;  -- End of procedure definition

DELIMITER ;  -- Reset the delimiter back to semicolon (default)

-- ------------------------------------------------------------
-- CALL THE PROCEDURE: Vetement
-- ------------------------------------------------------------

-- Call the procedure 'Vetement' with two input parameters: a temperature of 22°C and the weather condition 'Beau'.
CALL `Vetement`(22, 'Beau', @vet);

-- ------------------------------------------------------------
-- DISPLAY THE OUT PARAMETER VALUE
-- ------------------------------------------------------------

-- Select the value of the OUT parameter '@vet' to display the result of the procedure's logic.
SELECT @vet;
