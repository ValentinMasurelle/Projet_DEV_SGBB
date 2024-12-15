<?php
/*=============================================================
|                   🖼️ SCRIPT: insertUsers.php               |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Inserts multiple users into the 'inscription'|
|                  table, encrypting their passwords with MD5.|
|                                                             |
|  🗄️ DATABASE    : demo                                      |
=============================================================*/

/* ------------------------------------------------------------
|  🔄 INCLUDE DATABASE CONNECTION
|  ------------------------------------------------------------
|  Include the 'connect.php' file to establish a connection 
|  to the MySQL database. The $conn variable will be used 
|  to interact with the database throughout this script.
*/
require "connect.php";

/* ------------------------------------------------------------
|  📝 PREPARE SQL STATEMENT
|  ------------------------------------------------------------
|  Prepare an SQL statement to insert data into the 'inscription' 
|  table. The placeholders '?' are used to prevent SQL injection 
|  by safely binding user input values later.
*/
$stmt = $conn->prepare("INSERT INTO `inscription` (`nom`, `motdepasse`) VALUES (?, ?)");

/* ------------------------------------------------------------
|  🔗 BIND PARAMETERS
|  ------------------------------------------------------------
|  Bind the parameters to the prepared statement. The 'ss' 
|  indicates that both parameters are strings ('nom' and 'password').
|  This helps prevent SQL injection by ensuring safe insertion 
|  of user data.
*/
$stmt->bind_param("ss", $nom, $password);

/*
The bind_param function accepts four types of variables:
- i   - integer
- d   - double
- s   - string
- b   - BLOB (binary large object)

In this case, we use 'ss' for two string parameters (name and password).
*/

/* ------------------------------------------------------------
|  📝 INSERT FIRST USER
|  ------------------------------------------------------------
|  Assign the values for the first user. The password is encrypted 
|  using MD5 (Note: MD5 is not recommended for secure password storage).
|  Execute the prepared statement to insert the user into the database.
*/
$password = md5("password1");  // Encrypting the first user's password with MD5
$nom = "Joe";                  // Setting the name for the first user
$stmt->execute();              // Executing the statement to insert the data

/* ------------------------------------------------------------
|  📝 INSERT SECOND USER
|  ------------------------------------------------------------
|  Assign the values for the second user. Again, encrypt the 
|  password with MD5 and execute the insertion.
*/
$password = md5("password2");  // Encrypting the second user's password with MD5
$nom = "Jack";                 // Setting the name for the second user
$stmt->execute();              // Executing the statement to insert the data

/* ------------------------------------------------------------
|  📝 INSERT THIRD USER
|  ------------------------------------------------------------
|  Assign the values for the third user, encrypt the password, 
|  and execute the query to insert the data into the table.
*/
$password = md5("password3");  // Encrypting the third user's password with MD5
$nom = "William";              // Setting the name for the third user
$stmt->execute();              // Executing the statement to insert the data

/* ------------------------------------------------------------
|  📝 INSERT FOURTH USER
|  ------------------------------------------------------------
|  Assign the values for the fourth user, encrypt the password, 
|  and insert the data into the database.
*/
$password = md5("password4");  // Encrypting the fourth user's password with MD5
$nom = "Averell";              // Setting the name for the fourth user
$stmt->execute();              // Executing the statement to insert the data

/* ------------------------------------------------------------
|  ✅ SUCCESS MESSAGE
|  ------------------------------------------------------------
|  After all users are inserted, display a success message to 
|  confirm that the records were created successfully.
*/
echo "New records created successfully";

/* ------------------------------------------------------------
|  🔒 CLOSE RESOURCES
|  ------------------------------------------------------------
|  Close the prepared statement and the database connection 
|  to release any resources held during the script execution.
*/
$stmt->close(); 
$conn->close();
?>

