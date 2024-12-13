<?php
// Declaring the global connection variable
global $conn;

// Checking if the form is submitted via POST method
if (isset($_POST['submit'])) {
    // Ensure that both 'nom' and 'password' fields are not empty
    if (!empty($_POST['nom']) && !empty($_POST['password'])) {
      
        // Including the database connection script (connect.php)
        require "connect.php";

        // Preparing the SQL statement for inserting data into the 'inscription' table
        $stmt = $conn->prepare("INSERT INTO `inscription` (`nom`, `motdepasse`) VALUES (?, ?)");
        
        // Binding the parameters to the prepared statement (both 'nom' and 'password' are strings)
        $stmt->bind_param("ss", $nom, $password);  

        // Assigning form values to variables
        $nom = $_POST['nom'];
        // Encrypting the password using MD5 before storing it (note: MD5 is not secure for passwords in production environments)
        $password = md5($_POST['password']);

        // Executing the prepared statement to insert the values into the database
        $stmt->execute();

        // Output a success message after the record is created
        echo "New records created successfully";

        // Closing the prepared statement and the database connection
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
