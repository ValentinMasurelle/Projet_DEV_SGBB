<?php
/*=============================================================
|                   🖼️ SCRIPT: connectPDO.php                |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Establishes a PDO connection to a MySQL |
|                  database using provided credentials.      |
|                                                             |
|  🗄️ DATABASE    : demo                                      |
=============================================================*/

/* ------------------------------------------------------------
|  🔄 DATABASE CREDENTIALS
|  ------------------------------------------------------------
|  Define the necessary credentials for the database connection.
|  These include the server name, database name, username,
|  and password. These values should be kept secure.
*/
$servername = "db";    // Name of the database server
$username = "test";    // Username for database connection
$password = "pass";    // Password for the database user
$dbname = "demo";      // Database name to connect to

/* ------------------------------------------------------------
|  🌐 CREATE PDO CONNECTION
|  ------------------------------------------------------------
|  Attempt to establish a connection to the database using 
|  the PDO (PHP Data Objects) extension. The connection 
|  string includes the server name and database name.
|  The connection is wrapped in a try-catch block to handle 
|  potential exceptions.
*/
try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    
    /* ------------------------------------------------------------
    |  ⚙️ SET PDO ERROR MODE
    |  ------------------------------------------------------------
    |  Configure the PDO object to throw exceptions when an 
    |  error occurs. This ensures that errors are handled 
    |  properly and can be caught in the catch block.
    */
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    /* ------------------------------------------------------------
    |  ✅ CONNECTION SUCCESS
    |  ------------------------------------------------------------
    |  If the connection is successful, a success message is 
    |  displayed. This confirms that the connection was made 
    |  without issues.
    */
    echo "PDO Connected successfully";
} catch(PDOException $e) {
    /* ------------------------------------------------------------
    |  ⚠️ HANDLE CONNECTION ERROR
    |  ------------------------------------------------------------
    |  If an error occurs during the connection attempt, 
    |  catch the exception and display the error message.
    */
    echo "Connection failed: " . $e->getMessage();
}

/* ------------------------------------------------------------
|  🔒 CLOSE DATABASE CONNECTION
|  ------------------------------------------------------------
|  Although PDO does not require manually closing the 
|  connection, it's a good practice to nullify the connection 
|  object when done to free up resources.
*/
$conn = null;
?>
