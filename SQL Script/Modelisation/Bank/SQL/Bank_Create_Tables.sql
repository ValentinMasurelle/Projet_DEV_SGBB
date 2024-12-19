/*=============================================================
|                   🏦 QUERY Bank_Create_Tables.sql           |
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
    CLIENT_ZipCode VARCHAR(4)
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


