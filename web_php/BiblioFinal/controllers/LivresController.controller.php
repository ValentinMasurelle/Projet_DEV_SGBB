<?php
/*=============================================================
|                   📝 CLASS: LivresController                |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-21                                |
|  📝 DESCRIPTION : This class is responsible for handling 
|                  the logic of managing and displaying books 
|                  in the system. It interacts with the 
|                  `LivreManager` class to fetch books and 
|                  displays them using the "livres.view.php" 
|                  template.                                   |
=============================================================*/
require_once "models/LivreManager.class.php";
/**
 * LivresController Class
 * 
 * This class controls the flow of logic for managing books. It interacts
 * with the `LivreManager` class to load books and passes the data to
 * the view for display.
 */
class LivresController {
    /**
     * @var LivreManager $livreManager Instance of the LivreManager class.
     */
    private $livreManager;

    /**
     * Constructor to initialize the controller.
     *
     * The constructor creates an instance of the `LivreManager` class
     * and loads the books from the database by calling the `chargementLivres`
     * method of the `LivreManager`.
     */
    public function __construct() {
        // Create an instance of LivreManager to manage book data
        $this->livreManager = new LivreManager;

        // Load books from the database into the LivreManager
        $this->livreManager->chargementLivres();
    }

    /**
     * Displays the list of books by loading the "livres.view.php" template.
     *
     * This function retrieves the list of books from the `LivreManager` and
     * passes the data to the view (template) to display the books on the page.
     * 
     * @return void
     */
    public function afficherLivres() {
        // Retrieve all books from the LivreManager instance
        $livres = $this->livreManager->getLivres();

        // Include the "livres.view.php" template to display the books
        require "views/livres.view.php";
    }
}
?>
