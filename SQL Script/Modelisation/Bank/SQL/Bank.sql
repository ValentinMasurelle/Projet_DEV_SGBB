/*=============================================================
|                   🏦 QUERY Bank.sql                       |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-17                                |
|  📝 DESCRIPTION : Create database, manage banks and bank 
| accounts, 			
|	                                                          |
|                                                             |
|  📅 DATE_MODIFIED : 2024-12-17                              |
|                                                             |
|  🗄️ DATABASE    : BANK                                     |
=============================================================*/


CREATE DATABASE `BANK`;
USE BANK;

CREATE TABLE T_CLIENT (
    CLIENT_ID INTEGER AUTO_INCREMENT PRIMARY KEY,              
    CLIENT_Lastname VARCHAR(50),       
    CLIENT_Firstname VARCHAR(50),
    CLIENT_City VARCHAR(50),
    CLIENT_ZipCode VARCHAR(4)
);
CREATE TABLE T_BANK (
    BANK_ID INTEGER AUTO_INCREMENT PRIMARY KEY,              
    BANK_Name VARCHAR(50)
);

-- This table stores account information, linking each account to a bank and a client.
-- It includes an auto-incrementing primary key for the account, foreign keys for the bank and client,
-- a bank account number limited to 19 characters, and the account balance with two decimal places.

CREATE TABLE T_ACCOUNT (
    ACCOUNT_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    BANK_ID INTEGER,
    CONSTRAINT FK_BANK FOREIGN KEY (BANK_ID) REFERENCES T_BANK (BANK_ID),
    CLIENT_ID INTEGER,
    CONSTRAINT FK_CLIENT FOREIGN KEY (CLIENT_ID) REFERENCES T_CLIENT (CLIENT_ID),
    ACCOUNT_BankNumber VARCHAR(19),
    ACCOUNT_Amount DECIMAL(15, 2)
);

-- This table stores loan information, linking each loan to a bank and a client.
-- It includes an auto-incrementing primary key for the loan, foreign keys for the bank and client,
-- a loan account number limited to 19 characters, and the loan amount with two decimal places.

CREATE TABLE T_LOAN (
    LOAN_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    
    BANK_ID INTEGER,
    CONSTRAINT FK_T_LOAN_BANK FOREIGN KEY (BANK_ID) REFERENCES T_BANK (BANK_ID),
    
    CLIENT_ID INTEGER,
    CONSTRAINT FK_T_LOAN_CLIENT FOREIGN KEY (CLIENT_ID) REFERENCES T_CLIENT (CLIENT_ID),
    
    LOAN_Account VARCHAR(19),
    LOAN_Amount DECIMAL(15, 2)
);




