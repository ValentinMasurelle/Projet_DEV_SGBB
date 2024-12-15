/*=============================================================
|                   📝 QUERY: triggers_rollback.sql          |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                     |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Synchronizes `users` data between db_1 and db_2 with error logging |
|  🗄️ DATABASE    : ComprendreSQL                            |
=============================================================*/

-- ============================================
-- SECTION 1: SELECT QUERIES FOR CLIENT AND LOAN DATA
-- ============================================

-- ============================================
-- 1. Select All Data from `T_EMPRUNT_TRI`
-- ============================================
-- 📄 Description: Retrieve all records from the `T_EMPRUNT_TRI` table.
SELECT * 
FROM `T_EMPRUNT_TRI`;

-- ============================================
-- 2. Select All Data from `T_CLIENT_TRI`
-- ============================================
-- 📄 Description: Retrieve all records from the `T_CLIENT_TRI` table.
SELECT * 
FROM `T_CLIENT_TRI`;

-- ============================================
-- 3. Count the Number of Loans Per Client (Filter: Exactly 3 Loans)
-- ============================================
-- 📄 Description: Count the number of loans for each client and display clients with exactly 3 loans.
SELECT 
    N.id_client,                     -- Client ID
    COUNT(*) AS total_emprunts       -- Total number of loans for each client
FROM 
    `T_EMPRUNT_TRI` A
JOIN 
    `T_CLIENT_TRI` N ON A.id_client = N.id_client
GROUP BY 
    N.id_client
HAVING 
    COUNT(*) = 3;                    -- Filter clients who have exactly 3 loans

-- ============================================
-- SECTION 2: TRIGGERS FOR DATA INTEGRITY
-- ============================================

-- ============================================
-- 4. Trigger BEFORE INSERT on `T_EMPRUNT_TRI`
-- ============================================
-- 📄 Description: Prevent insertion if a client already has 3 loans.
DELIMITER $$

CREATE TRIGGER `TRG_INS_EMPRUNT`
BEFORE INSERT ON `T_EMPRUNT_TRI`
FOR EACH ROW
BEGIN
    -- Declare a variable to store the total number of loans for the client
    DECLARE total_emprunts INT;

    -- Count the current number of loans for the client
    SELECT COUNT(*) INTO total_emprunts
    FROM `T_EMPRUNT_TRI`
    WHERE id_client = NEW.id_client;

    -- Prevent the insertion if the client already has 3 loans
    IF total_emprunts >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insertion refused: Client already has 3 loans.';
    END IF;
END$$

DELIMITER ;

-- ============================================
-- SECTION 3: DATA MANIPULATION COMMANDS
-- ============================================

-- ============================================
-- 5. Insert Data into `T_EMPRUNT_TRI`
-- ============================================
-- 📄 Description: Insert a new loan for client with ID 9 and loan type 'A'.
INSERT INTO `T_EMPRUNT_TRI` (id_client, type_emprunt)
VALUES (9, 'A');
