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
    ACCOUNT_ID INTEGER AUTO_INCREMENT PRIMARY KEY,
    CONSTRAINT FK_BANK PRIMARY KEY(BANK_ID)
) 

