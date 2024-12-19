<?php
/*=============================================================
|                   🖼️ SCRIPT: formulaire.php                |
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-15                                |
|  📝 DESCRIPTION : Handles user registration by collecting  |
|                  user input, inserting it into the 'inscription'|
|                  table, and encrypting the password.       |
|                                                             |
|  🗄️ DATABASE    : demo                                      |
=============================================================*/

/* ------------------------------------------------------------
|  🔄 GLOBAL DATABASE CONNECTION
|  ------------------------------------------------------------
|  Declare the global database connection variable to be used 
|  within the script. This will be initialized once the 
|  'connect.php' file is included.
*/
global $conn;

/* ------------------------------------------------------------
|  📝 HANDLE FORM SUBMISSION
|  ------------------------------------------------------------
|  Check if the form is submitted using the POST method. If 
|  the 'submit' button is clicked, proceed with data validation 
|  and insertion into the database.
*/
if (isset($_POST['submit'])) {
    /* ------------------------------------------------------------
    |  🔒 VALIDATE FORM FIELDS
    |  ------------------------------------------------------------
    |  Ensure that both the 'nom' (first name) and 'password' 
    |  fields are filled. If either of them is empty, the form 
    |  will not proceed.
    */
    if (!empty($_POST['nom']) && !empty($_POST['password'])) {
      
        /* ------------------------------------------------------------
        |  🔄 INCLUDE DATABASE CONNECTION
        |  ------------------------------------------------------------
        |  Include the 'connect.php' file, which contains the database 
        |  connection details. This file will provide the $conn 
        |  variable for interacting with the database.
        */
        require "connect.php";

        /* ------------------------------------------------------------
        |  🌐 PREPARE SQL STATEMENT
        |  ------------------------------------------------------------
        |  Prepare an SQL statement to insert the user’s data into 
        |  the 'inscription' table. The table has fields for 'nom' 
        |  (first name) and 'motdepasse' (password).
        */
        $stmt = $conn->prepare("INSERT INTO `inscription` (`nom`, `motdepasse`) VALUES (?, ?)");

        /* ------------------------------------------------------------
        |  🔗 BIND PARAMETERS
        |  ------------------------------------------------------------
        |  Bind the form input values to the prepared statement. 
        |  Both the 'nom' and 'password' fields are passed as 
        |  string values ('ss').
        */
        $stmt->bind_param("ss", $nom, $password);

        /* ------------------------------------------------------------
        |  📝 ASSIGN FORM VALUES TO VARIABLES
        |  ------------------------------------------------------------
        |  Assign the form data ('nom' and 'password') to PHP 
        |  variables before inserting them into the database.
        */
        $nom = $_POST['nom'];
        
        /* ------------------------------------------------------------
        |  🔐 ENCRYPT PASSWORD
        |  ------------------------------------------------------------
        |  Encrypt the user's password using MD5 before storing it 
        |  in the database. Note that MD5 is considered insecure 
        |  for password encryption in production environments.
        */
        $password = md5($_POST['password']);

        /* ------------------------------------------------------------
        |  🚀 EXECUTE THE QUERY
        |  ------------------------------------------------------------
        |  Execute the prepared statement to insert the user data 
        |  into the 'inscription' table. If the insertion is 
        |  successful, display a success message.
        */
        $stmt->execute();
        echo "New records created successfully";

        /* ------------------------------------------------------------
        |  🔒 CLOSE RESOURCES
        |  ------------------------------------------------------------
        |  Close the prepared statement and database connection 
        |  to free up resources after the operation.
        */
        $stmt->close();
        $conn->close();
    }
}
?>

<!-- HTML form to gather user input for the registration process -->
<html>    
    <body>
        <!-- The form submits data using POST method -->
        <form method="post">
            <!-- Input field for the user's first name (nom) -->
            <p>First name: <input type="text" name="nom" /></p>
            <!-- Input field for the user's password -->
            <p>Password: <input type="password" name="password" /></p>
            <!-- Submit button to send the form data -->
            <input type="submit" name="submit" value="Submit" />
        </form>
    </body>
</html>
