/*=============================================================
|                   🖼️ QUERY Affichage1.sql                   | 
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Create SP Affichage1                      |	
|                                                             |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

/* ------------------------------------------------------------
|  DROP PROCEDURE IF IT EXISTS
|  ------------------------------------------------------------
|  Drop the procedure 'Affichage1' if it already exists to avoid any conflicts.
*/
DROP PROCEDURE IF EXISTS `Affichage1`;

-- ------------------------------------------------------------
-- CREATE PROCEDURE: Affichage1
-- ------------------------------------------------------------

-- Change the delimiter to $$ to allow the definition of the procedure
DELIMITER $$

CREATE PROCEDURE Affichage1 (  
    OUT texte1 VARCHAR(200),  -- OUT parameter 'texte1' (will store a string of up to 200 characters)
    OUT texte2 VARCHAR(200),  -- OUT parameter 'texte2' (will store a string of up to 200 characters)
    OUT texte3 VARCHAR(200)   -- OUT parameter 'texte3' (will store a string of up to 200 characters)
)    
BEGIN
    -- Declare a local variable 'var1' of type INT and set its default value to 1
    DECLARE var1 INT DEFAULT 1;

    -- The first SELECT statement assigns the string 'texte1' to the OUT parameter 'texte1'
    SELECT 'texte1' INTO texte1;    

    -- Begin a nested block (optional for scope control)
    BEGIN
        -- Declare a second local variable 'var2' of type INT and set its default value to 2
        DECLARE var2 INT DEFAULT 2;

        -- The second SELECT statement assigns the string 'texte2' to the OUT parameter 'texte2'
        SELECT 'texte2' INTO texte2;   

        -- Selects the values of the local variables 'var1' and 'var2'
        -- This will display the current values of 'var1' and 'var2' within the nested block
        SELECT var1 AS 'var1', var2 AS 'var2'; 
    END;  -- End of the nested BEGIN block

    -- The third SELECT statement assigns the string 'texte3' to the OUT parameter 'texte3'
    SELECT 'texte3' INTO texte3;

    -- Selects the value of 'var1' outside the nested block to demonstrate that 'var1' 
    -- remains accessible in the outer scope, as it was declared in the outer block.
    SELECT var1 AS 'var1'; 

END$$

-- Reset the delimiter back to semicolon (default)
DELIMITER ;

-- ------------------------------------------------------------
-- CALL THE PROCEDURE: Affichage1
-- ------------------------------------------------------------

-- Call the procedure 'Affichage1' and pass the OUT parameters
-- The OUT parameters will be populated with the values assigned inside the procedure
CALL Affichage1(@parm1, @parm2, @parm3);

-- ------------------------------------------------------------
-- SELECT TO DISPLAY THE OUT PARAMETERS
-- ------------------------------------------------------------

-- Display the values of the OUT parameters '@parm1', '@parm2', and '@parm3' to verify the output
SELECT @parm1, @parm2, @parm3;

-- ------------------------------------------------------------
-- CHECK THE AUTOCOMMIT STATUS
-- ------------------------------------------------------------

-- Retrieve the current status of the autocommit mode. 
-- Returns '1' if autocommit is enabled (default mode) or '0' if disabled.
SELECT @@autocommit;
