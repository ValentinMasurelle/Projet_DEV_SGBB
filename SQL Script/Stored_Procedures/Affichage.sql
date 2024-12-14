/*=============================================================
|                   🖼️ QUERY Affichage.sql                    | 
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Create SP Affichage                       |	
	                                                          |
|                                                             |
|                                                             |
|                                                             |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/



-- ------------------------------------------------------------
-- DROP PROCEDURE IF IT EXISTS
-- ------------------------------------------------------------

-- Drop the procedure 'Affichage' if it already exists to avoid any conflicts
DROP PROCEDURE IF EXISTS `Affichage`;

-- ------------------------------------------------------------
-- CREATE PROCEDURE: Affichage
-- ------------------------------------------------------------

-- Create a stored procedure named 'Affichage' that takes 3 OUT parameters
-- The OUT parameters will hold values that can be used outside the procedure.
DELIMITER $$  -- Change the delimiter to $$ to allow the definition of the procedure

CREATE PROCEDURE Affichage (  
    OUT texte1 VARCHAR(200),  -- OUT parameter 'texte1' (will store a string value of up to 200 characters)
    OUT texte2 VARCHAR(200),  -- OUT parameter 'texte2' (will store a string value of up to 200 characters)
    OUT texte3 VARCHAR(200)   -- OUT parameter 'texte3' (will store a string value of up to 200 characters)
)   
BEGIN
    -- The first SELECT statement assigns the string 'texte1' to the OUT parameter 'texte1'
    SELECT 'texte1' INTO texte1;  

    -- Begin a nested block (optional for scope control)
    BEGIN
        -- The second SELECT statement assigns the string 'texte2' to the OUT parameter 'texte2'
        SELECT 'texte2' INTO texte2;   
    END;  -- End of the nested BEGIN block

    -- The third SELECT statement assigns the string 'texte3' to the OUT parameter 'texte3'
    SELECT 'texte3' INTO texte3;
END;  -- End of the procedure definition

DELIMITER ;  -- Reset the delimiter back to semicolon (default)

-- ------------------------------------------------------------
-- CALL THE PROCEDURE: Affichage
-- ------------------------------------------------------------

-- Call the procedure 'Affichage' and pass the OUT parameters
-- The OUT parameters will be populated with the values assigned inside the procedure
CALL Affichage(@tA, @B, @C);

-- ------------------------------------------------------------
-- SELECT TO DISPLAY THE OUT PARAMETERS
-- ------------------------------------------------------------

-- Display the values of the OUT parameters '@tA', '@B', and '@C' to verify the output
SELECT @tA, @B, @C;
