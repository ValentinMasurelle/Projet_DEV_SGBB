<?php
// Including the database connection file to establish a connection to the database
require "connect.php";

// Preparing the SQL statement to insert data into the 'inscription' table
// The statement uses placeholders '?' to prevent SQL injection
$stmt = $conn->prepare("INSERT INTO `inscription` (`nom`, `motdepasse`) VALUES (?, ?)");

// Binding parameters to the prepared statement
// 'ss' indicates that both parameters are of type string ('s')
$stmt->bind_param("ss", $nom, $password);

/*
The bind_param function accepts four types of variables:
- i   - integer
- d   - double
- s   - string
- b   - BLOB (binary large object)

In this case, we use 'ss' for two string parameters (name and password).
*/

// Inserting the first user
$password = md5("password1");  // Encrypting the password with MD5 (Note: MD5 is not recommended for security)
$nom = "Joe";                  // Setting the name for the first user
$stmt->execute();              // Executing the statement to insert the data

// Inserting the second user
$password = md5("password2");  // Encrypting the second password
$nom = "Jack";                 // Setting the name for the second user
$stmt->execute();              // Executing the statement to insert the data

// Inserting the third user
$password = md5("password3");  // Encrypting the third password
$nom = "William";              // Setting the name for the third user
$stmt->execute();              // Executing the statement to insert the data

// Inserting the fourth user
$password = md5("password4");  // Encrypting the fourth password
$nom = "Averell";              // Setting the name for the fourth user
$stmt->execute();              // Executing the statement to insert the data

// Displaying a success message after all records are inserted
echo "New records created successfully";

// Closing the prepared statement and the database connection
$stmt->close(); 
$conn->close();
?>
