<?php
/*=============================================================
|                   📝 CLASS: Model                           |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-21                                |
|  📝 DESCRIPTION : This is an abstract class that manages 
|                  the database connection using PDO. It 
|                  provides a method (`getBdd`) to retrieve 
|                  the database connection and ensures that 
|                  the connection is established only once.   |
=============================================================*/

/**
 * Model Class
 * 
 * This abstract class is responsible for managing the database connection
 * using PDO. It ensures that the connection is established only once
 * and provides access to the PDO instance to the derived classes.
 * It is intended to be extended by other classes that require database 
 * interactions.
 */
abstract class Model {
    /**
     * @var PDO|null $pdo The PDO instance for the database connection.
     */
    private static $pdo;

    /**
     * Establishes a database connection using PDO.
     *
     * This method creates a new PDO connection to the database with the
     * provided credentials (hostname, database name, username, and password).
     * It also sets the error mode to display warnings for database issues.
     * 
     * @return void
     */
    private static function setBdd() {
        // Initialize the PDO connection with database credentials
        self::$pdo = new PDO("mysql:host=db;dbname=Biblio;charset=utf8", "test", "pass");
        
        // Set the PDO error mode to warning for debugging
        self::$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
    }

    /**
     * Retrieves the PDO database connection.
     *
     * This method checks if the PDO connection is already established.
     * If not, it calls the `setBdd` method to establish the connection
     * and then returns the PDO instance for further database interactions.
     *
     * @return PDO The PDO instance for database interactions.
     */
    protected function getBdd() {
        // If the PDO connection does not exist, establish it
        if (self::$pdo === null) {
            self::setBdd();
        }

        // Return the established PDO instance
        return self::$pdo;
    }
}
?>
