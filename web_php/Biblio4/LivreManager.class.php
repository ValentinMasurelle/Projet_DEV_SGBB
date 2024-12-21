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
     * @param Livre $livre The book object to be added.
     * @return void
     */
    public function ajoutLivre($livre) {
        $this->livres[] = $livre;  // Append the Livre object to the livres array.
    }

    /**
     * Retrieves the collection of books (`Livre` objects).
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
        // Prepare and execute the SQL query
        $req = $this->getBdd()->prepare("SELECT * FROM v_livres");
        $req->execute();

        // Fetch the results as an associative array
        $mesLivres = $req->fetchAll(PDO::FETCH_ASSOC);

        // Close the cursor to free database resources
        $req->closeCursor();

        // Loop through each book data and add to the collection
        foreach ($mesLivres as $livre) {
            $l = new Livre(
                $livre['id'], 
                $livre['titre'], 
                $livre['nbPages'], 
                $livre['image']
            );
            $this->ajoutLivre($l);  // Add the Livre object to the collection
        }
    }
}
?>
