<?php
/*=============================================================
|                   🖼️ SCRIPT: connect.php                 |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Establishes a connection to the MySQL     |
|                  database using MySQLi and checks the       |
|                  connection status.                         |
|                                                             |
|  🗄️ DATABASE    : demo                                      |
=============================================================*/

/* ------------------------------------------------------------
|  🔄 REQUIRE CONFIGURATION FILE
|  ------------------------------------------------------------
|  Include the external configuration file that contains the
|  database credentials ($servername, $username, $password, 
|  and $database). Ensure that 'config.php' exists in the 
|  same directory or provide the correct path.
*/
require "config.php";

/* ------------------------------------------------------------
|  🌐 CREATE DATABASE CONNECTION
|  ------------------------------------------------------------
|  Use the MySQLi object-oriented approach to establish a 
|  connection to the database with the credentials provided 
|  in 'config.php'.
*/
$conn = new mysqli($servername, $username, $password, $database);

/* ------------------------------------------------------------
|  ⚠️ CHECK DATABASE CONNECTION
|  ------------------------------------------------------------
|  Verify if the connection was successful. If there's an 
|  error, terminate the script and display an error message.
*/
if ($conn->connect_error) {
    // Display an error message and stop script execution
    die("MySQLi Connection failed: " . $conn->connect_error);
}

/* ------------------------------------------------------------
|  ✅ CONNECTION SUCCESS MESSAGE
|  ------------------------------------------------------------
|  If the connection is successful, print a confirmation 
|  message to the browser.
*/
echo "MySQLi Connected successfully" . "<br>";

?>
