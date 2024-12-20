/*=============================================================
|                   📝 CLASS: LivreManager                     |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                      |
|  📅 DATE        : 2024-12-20                                |
|  📝 DESCRIPTION : This class manages a collection of books 
|                  (`Livre` objects). It provides methods 
|                  to add books to the collection and retrieve 
|                  the list of books.                         |
=============================================================*/

/* ==============================
   SECTION: Class Functionality
   ==============================

1. **Properties**:
   - `$livres` : An array to store the collection of `Livre` objects.

2. **Methods**:
   - `ajoutLivre($livre)`:
     - Adds a `Livre` object to the `$livres` array.
     - Accepts a single parameter `$livre` which should be an instance of the `Livre` class.
     
   - `getLivres()`:
     - Returns the array `$livres` containing all the added `Livre` objects.
*/

<?php

class LivreManager {
    private $livres;  // Collection of Livre objects

    // Adds a Livre object to the livres collection
    public function ajoutLivre($livre) {
        $this->livres[] = $livre;  // Append the Livre object to the livres array
    }

    // Returns the collection of Livre objects
    public function getLivres() {
        return $this->livres;  // Return the array of Livre objects
    }
}

?>
