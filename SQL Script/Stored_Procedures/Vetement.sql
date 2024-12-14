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
DELIMITER $$  -- Change the delimiter to $$ to allow the definition of the procedure

CREATE PROCEDURE Vetement (
    IN p_tp INT,              -- IN parameter 'p_tp' (temperature in Celsius)
    IN p_temps VARCHAR(50),   -- IN parameter 'p_temps' (weather condition such as 'Beau', 'Pluvieux', etc.)
    OUT p_vet VARCHAR(50)     -- OUT parameter 'p_vet' (suggested item of clothing based on the conditions)
)    
BEGIN
    -- Use a CASE statement to determine the appropriate clothing based on temperature and weather conditions
    CASE 
        -- If temperature is below 5°C and the weather is 'Beau' or 'Nuageux' (Clear or Cloudy),
        -- suggest 'Manteau' (coat) as the appropriate clothing.
        WHEN p_tp < 5 AND (p_temps = 'Beau' OR p_temps = 'Nuageux') THEN
            SELECT 'Manteau' INTO p_vet;
        
        -- If temperature is below 20°C and the weather is 'Pluvieux' (Rainy),
        -- suggest 'Impermeable' (raincoat) as the appropriate clothing.
        WHEN p_tp < 20 AND p_temps = 'Pluvieux' THEN
            SELECT 'Impermeable' INTO p_vet;
        
        -- If temperature is 20°C or higher and the weather is 'Pluvieux' (Rainy),
        -- suggest 'Parapluie' (umbrella) as the appropriate clothing.
        WHEN p_tp >= 20 AND p_temps = 'Pluvieux' THEN
            SELECT 'Parapluie' INTO p_vet;
        
        -- If temperature is between 5°C and 20°C and the weather is 'Nuageux' (Cloudy),
        -- suggest 'Veste' (jacket) as the appropriate clothing.
        WHEN p_tp >= 5 AND p_tp < 20 AND p_temps = 'Nuageux' THEN
            SELECT 'Veste' INTO p_vet;
        
        -- For all other conditions, suggest 'Casquette' (cap) as the default item of clothing.
        ELSE
            SELECT 'Casquette' INTO p_vet;
    END CASE;
END;  -- End of procedure definition

DELIMITER ;  -- Reset the delimiter back to semicolon (default)

-- ------------------------------------------------------------
-- CALL THE PROCEDURE: Vetement
-- ------------------------------------------------------------

-- Call the procedure 'Vetement' with two input parameters: a temperature of 22°C and the weather condition 'Beau'.
-- The OUT parameter '@vet' will be populated with the appropriate clothing suggestion based on the logic in the procedure.
CALL `Vetement`(22, 'Beau', @vet);

-- ------------------------------------------------------------
-- DISPLAY THE OUT PARAMETER VALUE
-- ------------------------------------------------------------

-- Select the value of the OUT parameter '@vet' to display the result of the procedure's logic.
SELECT @vet;
