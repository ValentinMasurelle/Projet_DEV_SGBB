/*=============================================================
|                   🏦 QUERY Bank.sql                       |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-17                                |
|  📝 DESCRIPTION : This script creates and manages a banking 
|                  database including clients, banks, accounts, 
|                  and loans. It also contains various queries 
|                  for extracting and analyzing data.          |
|                                                             |
|  📅 DATE_MODIFIED : 2024-12-19                              |
|                                                             |
|  🗄️ DATABASE    : BANK                                     |
=============================================================*/

-- ------------------------------------------------------------
-- 📂 SECTION 1: DATABASE AND TABLE CREATION
-- ------------------------------------------------------------

/* 
   📌 DESCRIPTION:
   This section creates the BANK database and defines four tables:
   1. T_CLIENT: Stores client information.
   2. T_BANK: Stores bank information.
   3. T_ACCOUNT: Stores account details linking clients and banks.
   4. T_LOAN: Stores loan details linking clients and banks.
*/

-- Drop the BANK database if it exists and create a new one
DROP DATABASE IF EXISTS BANK;
CREATE DATABASE IF NOT EXISTS `BANK`;
USE BANK;

-- -----------------------------------
-- 🗂️ Table: T_CLIENT
-- Stores client details.
-- -----------------------------------
DROP TABLE IF EXISTS T_CLIENT;

CREATE TABLE T_CLIENT (
    CLIENT_ID INTEGER PRIMARY KEY AUTO_INCREMENT,              
    CLIENT_Lastname VARCHAR(50),       
    CLIENT_Firstname VARCHAR(50),
    CLIENT_City VARCHAR(50),
    CLIENT_ZipCode VARCHAR(20)
);

ALTER TABLE T_CLIENT AUTO_INCREMENT = 0;

-- -----------------------------------
-- 🗂️ Table: T_BANK
-- Stores bank details.
-- -----------------------------------
CREATE TABLE T_BANK (
    BANK_ID INTEGER AUTO_INCREMENT PRIMARY KEY,              
    BANK_Name VARCHAR(50),
    BANK_Ammount BIGINT
);

ALTER TABLE T_BANK AUTO_INCREMENT = 0;

-- -----------------------------------
-- 🗂️ Table: T_ACCOUNT
-- Stores account details, linking each account to a bank and a client.
-- -----------------------------------
DROP TABLE IF EXISTS T_ACCOUNT;

CREATE TABLE T_ACCOUNT (
    ACCOUNT_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    BANK_ID INTEGER,
    CONSTRAINT FK_BANK FOREIGN KEY (BANK_ID) REFERENCES T_BANK (BANK_ID),
    CLIENT_ID INTEGER,
    CONSTRAINT FK_CLIENT FOREIGN KEY (CLIENT_ID) REFERENCES T_CLIENT (CLIENT_ID),
    ACCOUNT_BankNumber VARCHAR(19),
    ACCOUNT_Amount DECIMAL(15, 2)
);

ALTER TABLE T_ACCOUNT AUTO_INCREMENT = 0;

-- -----------------------------------
-- 🗂️ Table: T_LOAN
-- Stores loan details, linking each loan to a bank and a client.
-- -----------------------------------
CREATE TABLE T_LOAN (
    LOAN_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    
    BANK_ID INTEGER,
    CONSTRAINT FK_T_LOAN_BANK FOREIGN KEY (BANK_ID) REFERENCES T_BANK (BANK_ID),
    
    CLIENT_ID INTEGER,
    CONSTRAINT FK_T_LOAN_CLIENT FOREIGN KEY (CLIENT_ID) REFERENCES T_CLIENT (CLIENT_ID),
    
    LOAN_Account VARCHAR(19),
    LOAN_Amount DECIMAL(15, 2)
);

ALTER TABLE T_LOAN AUTO_INCREMENT = 0;


-- ------------------------------------------------------------
-- 📂 SECTION 2: DATA QUERIES
-- ------------------------------------------------------------

/* 
   📌 DESCRIPTION:
   This section contains SQL queries to retrieve and analyze data from the BANK database.
*/

-- -----------------------------------
-- 🔍 QUERY 1: SELECT CLIENTS WITH ACCOUNT AMOUNTS LESS THAN 1000 OR GREATER THAN 10000
-- -----------------------------------
/*
   📌 DESCRIPTION:
   Retrieve the unique client IDs where the account amount is either less than 1000 or greater than 10000.
*/

SELECT 
    client.CLIENT_ID 
FROM 
    T_CLIENT AS client 
INNER JOIN 
    T_ACCOUNT AS ac 
ON 
    ac.CLIENT_ID = client.CLIENT_ID
WHERE 
    ac.ACCOUNT_Amount < 1000 OR ac.ACCOUNT_Amount > 10000;

-- -----------------------------------
-- 🔍 QUERY 2: AVERAGE ACCOUNT BALANCE FOR BANKS WITH AVERAGE BALANCE OVER 10000
-- -----------------------------------
/*
   📌 DESCRIPTION:
   Retrieve the average account balance for each bank where the average balance exceeds 10000.
   The result includes the bank name and the calculated average balance.
*/

SELECT 
    T_BANK.BANK_Name AS nomagence,
    AVG(T_ACCOUNT.ACCOUNT_Amount) AS Solde_Moyen
FROM 
    T_BANK
INNER JOIN 
    T_ACCOUNT ON T_BANK.BANK_ID = T_ACCOUNT.BANK_ID
GROUP BY 
    T_BANK.BANK_Name
HAVING 
    AVG(T_ACCOUNT.ACCOUNT_Amount) > 10000;

-- -----------------------------------
-- 🔍 QUERY 3: CLIENTS WHO DO NOT HAVE ACCOUNTS IN THE SAME BANK AS 'COUDERC'
-- -----------------------------------
/*
   📌 DESCRIPTION:
   Retrieve the clients who do not have any accounts in the same bank as the client with the last name 'COUDERC'.
*/

SELECT DISTINCT 
    C.CLIENT_ID, 
    C.CLIENT_Lastname, 
    C.CLIENT_Firstname
FROM 
    T_CLIENT C
WHERE 
    C.CLIENT_ID NOT IN (
        SELECT DISTINCT 
            A.CLIENT_ID
        FROM 
            T_ACCOUNT A
        INNER JOIN 
            T_CLIENT C2 ON A.CLIENT_ID = C2.CLIENT_ID
        WHERE 
            C2.CLIENT_Lastname = 'COUDERC'
    );

-- -----------------------------------
-- 🔍 QUERY 4: CLIENTS WITH ACCOUNTS IN MORE THAN ONE BANK
-- -----------------------------------
/*
   📌 DESCRIPTION:
   Retrieve clients who have accounts in more than one bank. The result includes client details and the names of the banks.
*/

SELECT 
    C.CLIENT_ID,
    C.CLIENT_Lastname,
    C.CLIENT_Firstname,
    B.BANK_Name
FROM 
    T_CLIENT C
INNER JOIN 
    T_ACCOUNT A ON C.CLIENT_ID = A.CLIENT_ID
INNER JOIN 
    T_BANK B ON A.BANK_ID = B.BANK_ID
WHERE 
    C.CLIENT_ID IN (
        SELECT 
            CLIENT_ID
        FROM 
            T_ACCOUNT
        GROUP BY 
            CLIENT_ID
        HAVING 
            COUNT(DISTINCT BANK_ID) > 1
    )
ORDER BY 
    C.CLIENT_ID, B.BANK_Name;
