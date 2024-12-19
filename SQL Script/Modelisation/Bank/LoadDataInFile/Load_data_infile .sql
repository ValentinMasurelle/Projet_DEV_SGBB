/*=============================================================
|                   🏦 DATA LOAD Bank.sql                    |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-17                                |
|  📝 DESCRIPTION : This script loads data into the BANK 
|                  database from CSV files into the tables:
|                  - T_CLIENT (Clients)
|                  - T_BANK (Banks)
|                  - T_ACCOUNT (Accounts)
|                  - T_LOAN (Loans)                           |
|                                                             |
|  📅 DATE_MODIFIED : 2024-12-19                              |
|                                                             |
|  🗄️ DATABASE    : BANK                                     |
=============================================================*/

-- ------------------------------------------------------------
-- 📂 SECTION 1: CHECKING AND CONFIGURING VARIABLES
-- ------------------------------------------------------------

/*
   📌 DESCRIPTION:
   Check the MySQL server variables related to file loading and ensure the `local_infile` option is enabled.
*/

-- Check if 'local_infile' is enabled
SHOW VARIABLES LIKE 'local_infile';

-- Check the path allowed for secure file loading
SHOW VARIABLES LIKE 'secure_file_priv';

-- Temporarily disable foreign key checks to avoid constraint errors during data loading
SET FOREIGN_KEY_CHECKS = 0;

-- ------------------------------------------------------------
-- 📂 SECTION 2: LOADING DATA INTO TABLES
-- ------------------------------------------------------------

/* 
   📌 DESCRIPTION:
   This section loads data from CSV files into the respective tables in the BANK database.
*/

-- -----------------------------------
-- 🗂️ 2.1 Load Data into T_CLIENT Table
-- -----------------------------------
/*
   📌 DESCRIPTION:
   Load client data from `Client.csv` into the `T_CLIENT` table.
   The fields in the CSV are terminated by commas and enclosed by double quotes.
*/

LOAD DATA INFILE "/var/lib/mysql-files/Client.csv" 
INTO TABLE `Bank`.`T_CLIENT`
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
(CLIENT_Lastname, CLIENT_Firstname, CLIENT_City, CLIENT_ZipCode);

-- Verify the data loaded into T_CLIENT
SELECT * FROM `Bank`.`T_CLIENT`;

-- -----------------------------------
-- 🗂️ 2.2 Load Data into T_BANK Table
-- -----------------------------------
/*
   📌 DESCRIPTION:
   Load bank data from `Agence.csv` into the `T_BANK` table.
   The fields in the CSV are terminated by semicolons.
*/

LOAD DATA INFILE "/var/lib/mysql-files/Agence.csv" 
INTO TABLE `Bank`.`T_BANK`
FIELDS TERMINATED BY ';' 
ENCLOSED BY '' 
LINES TERMINATED BY '\n'
(BANK_Name, BANK_Ammount);

-- Verify the data loaded into T_BANK
SELECT * FROM `Bank`.`T_BANK`;

-- -----------------------------------
-- 🗂️ 2.3 Load Data into T_ACCOUNT Table
-- -----------------------------------
/*
   📌 DESCRIPTION:
   Load account data from `compte.csv` into the `T_ACCOUNT` table.
   The fields in the CSV are terminated by semicolons.
*/

LOAD DATA INFILE "/var/lib/mysql-files/compte.csv" 
INTO TABLE `Bank`.`T_ACCOUNT`
FIELDS TERMINATED BY ';' 
ENCLOSED BY '' 
LINES TERMINATED BY '\n'
(
    BANK_ID,
    CLIENT_ID,
    ACCOUNT_BankNumber,
    ACCOUNT_Amount
);

-- Verify the data loaded into T_ACCOUNT
SELECT * FROM `Bank`.`T_ACCOUNT`;

-- -----------------------------------
-- 🗂️ 2.4 Load Data into T_LOAN Table
-- -----------------------------------
/*
   📌 DESCRIPTION:
   Load loan data from `emprunt.csv` into the `T_LOAN` table.
   The fields in the CSV are terminated by semicolons.
*/

LOAD DATA INFILE "/var/lib/mysql-files/emprunt.csv" 
INTO TABLE `Bank`.`T_LOAN`
FIELDS TERMINATED BY ';' 
ENCLOSED BY '' 
LINES TERMINATED BY '\n'
(
    BANK_ID,
    CLIENT_ID,
    LOAN_Account,
    LOAN_Amount
);

-- Verify the data loaded into T_LOAN
SELECT * FROM `Bank`.`T_LOAN`;

-- ------------------------------------------------------------
-- 📂 SECTION 3: REACTIVATING FOREIGN KEY CHECKS
-- ------------------------------------------------------------

/*
   📌 DESCRIPTION:
   After data loading, re-enable foreign key checks. If the data is correct, this should not cause any issues.
*/

SET FOREIGN_KEY_CHECKS = 1;


