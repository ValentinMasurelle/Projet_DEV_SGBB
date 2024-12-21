<?php
/*=============================================================
|                   📝 CLASS: LivreManager                     |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-21                                |
|  📝 DESCRIPTION : This class manages a collection of books 
|                  (`Livre` objects). It provides methods 
|                  to add books to the collection, retrieve 
|                  the list of books, and load books from the 
|                  database into the collection.              |
=============================================================*/
require_once "Model.class.php";
require_once "Livre.class.php";
/**
 * LivreManager Class
 * 
 * This class handles the management of a collection of `Livre` objects.
 * It provides functionality to add books, retrieve them, and populate
 * the collection from the database using a view (`v_livres`).
 */
class LivreManager extends Model {
    /**
     * @var Livre[] $livres Collection of Livre objects.
     */
    private $livres;

    /**
     * Adds a `Livre` object to the collection.
     *
     * This method appends the provided `Livre` object to the internal array
     * of books (`$livres`).
     *
     * @param Livre $livre The book object to be added.
     * @return void
     */
    public function ajoutLivre($livre) {
        $this->livres[] = $livre;  // Append the Livre object to the livres array.
    }

    /**
     * Retrieves the collection of books (`Livre` objects).
     *
     * This method returns the current list of `Livre` objects that are 
     * stored in the `$livres` property.
     *
     * @return Livre[] Array of Livre objects.
     */
    public function getLivres() {
        return $this->livres;  // Return the array of Livre objects.
    }

    /**
     * Loads books from the database and populates the collection.
     * 
     * This method executes a SQL query to fetch book data from the view 
     * `v_livres`. It creates `Livre` objects for each row and adds them 
     * to the `$livres` collection.
     *
     * @return void
     * @throws Exception If database access fails.
     */
    public function chargementLivres() {
        // Prepare and execute the SQL query to fetch book data
        $req = $this->getBdd()->prepare("SELECT * FROM v_livres");
        $req->execute();

        // Fetch all books as an associative array
        $mesLivres = $req->fetchAll(PDO::FETCH_ASSOC);

        // Close the cursor to free up the database resources
        $req->closeCursor();

        // Loop through each row of the fetched book data
        foreach ($mesLivres as $livre) {
            // Create a new Livre object using the fetched data
            $l = new Livre(
                $livre['id'],    // Book ID
                $livre['titre'], // Book title
                $livre['nbPages'], // Number of pages
                $livre['image'],  // Book image
                $livre['nomEditeur'] // Book editor (from the database column 'editeur')
            );
            // Add the created Livre object to the collection
            $this->ajoutLivre($l);  // Add the Livre object to the collection
        }
    }
}
?>
