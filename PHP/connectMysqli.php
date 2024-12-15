<?php
/*=============================================================
|                   🖼️ SCRIPT: connectMysqli.php              |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : Inserts a new record into the T_CLIENT_TRI|
|                  table and handles success or error cases. |
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
    die("MySQLi Connection failed: " . $conn->connect_error);
}

/* ------------------------------------------------------------
|  📝 DEFINE INSERT QUERY
|  ------------------------------------------------------------
|  Prepare an SQL query to insert a new client record into 
|  the 'T_CLIENT_TRI' table. The query includes placeholders 
|  for the client's name and type.
*/
$sql = "INSERT INTO T_CLIENT_TRI (Nom_client, type_client) VALUES ('John Doe', 'P')";

/* ------------------------------------------------------------
|  🚀 EXECUTE INSERT QUERY
|  ------------------------------------------------------------
|  Execute the SQL query and check if the insertion was 
|  successful. Display appropriate messages for success or 
|  failure.
*/
if ($conn->query($sql) === TRUE) {
    echo "New record inserted successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

/* ------------------------------------------------------------
|  🔒 CLOSE DATABASE CONNECTION
|  ------------------------------------------------------------
|  Close the database connection to free up resources.
*/
$conn->close();

?>