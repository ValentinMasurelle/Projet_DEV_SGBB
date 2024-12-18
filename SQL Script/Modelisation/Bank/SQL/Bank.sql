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

CREATE TABLE T_ACCOUNT (
    -- Primary key: Unique identifier for each account
    ACCOUNT_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    
    -- Foreign key referencing the BANK table (assuming BANK_ID exists in the BANK table)
    BANK_ID INTEGER, -- Add this column to support the BANK foreign key
    CONSTRAINT FK_BANK FOREIGN KEY (BANK_ID) REFERENCES T_BANK (BANK_ID),
    
    -- Foreign key referencing the CLIENT table (assuming CLIENT_ID exists in the CLIENT table)
    CLIENT_ID INTEGER, -- Add this column to support the CLIENT foreign key
    CONSTRAINT FK_CLIENT FOREIGN KEY (CLIENT_ID) REFERENCES T_CLIENT (CLIENT_ID),
    
    -- Bank number for the account (19 characters maximum as specified)
    ACCOUNT_BankNumber VARCHAR(19), -- Max 19 characters because all accounts have 19 characters
    
    -- Account balance or amount (using DECIMAL for more precision)
    ACCOUNT_Amount DECIMAL(15, 2) -- Allows for large amounts with two decimal places for cents
);
 

CREATE TABLE T_LOAN (
    LOAN_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    CONSTRAINT FK_BANK PRIMARY KEY(BANK_ID)
    CONSTRAINT FK_CLIENT PRIMARY KEY(CLIENT_ID),
    LOAN_Account VARCHAR(19),
    LOAN_Amount INT
) 




