<?php
/*=============================================================
|                   🖼️ SCRIPT: config.php                  |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Database connection configuration file.   |
|                  Contains credentials for connecting to a   |
|                  MySQL database.                            |
|                                                             |
|  🗄️ DATABASE    : demo                                      |
=============================================================*/

/* ------------------------------------------------------------
|  📄 DATABASE CONFIGURATION VARIABLES
|  ------------------------------------------------------------
|  These variables store the credentials required to connect
|  to the MySQL database. Update these values accordingly
|  based on your environment.
*/

/**
 * 🖥️ Server Name or Host
 * The address of the database server.
 * Default is 'db' when running inside a Docker container.
 */
$servername = "db"; // Change to 'localhost' if not using Docker.

/**
 * 👤 Username
 * The username used to authenticate with the database.
 * Ensure this user has the necessary permissions.
 */
$username = "test"; // Replace with your database username.

/**
 * 🔒 Password
 * The password for the database user.
  */
$password = "pass"; // Replace with your database password.

/**
 * 🗄️ Database Name
 * The specific database to connect to.
 */
$database = "demo"; // Replace with the name of your database.

?>
