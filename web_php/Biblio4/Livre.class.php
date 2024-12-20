/*=============================================================
|                   📝 CLASS: Livre                           |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                      |
|  📅 DATE        : 2024-12-20                                |
|  📝 DESCRIPTION : This class represents a book entity with 
|                  properties for ID, title, number of pages, 
|                  and an image. It includes a constructor and 
|                  getter/setter methods for each property.   |
=============================================================*/

/* ==============================
   SECTION: Class Functionality
   ==============================

1. **Properties**:
   - `$id` : Unique identifier for the book.
   - `$titre` : Title of the book.
   - `$nbPages` : Number of pages in the book.
   - `$image` : Image associated with the book.

2. **Constructor**:
   - Initializes the class properties when a `Livre` object is created.

3. **Getter and Setter Methods**:
   - `getId()` / `setId($id)`: Access and modify the book ID.
   - `getTitre()` / `setTitre($titre)`: Access and modify the book title.
   - `getNbPages()` / `setNbPages($nbPages)`: Access and modify the number of pages.
   - `getImage()` / `setImage($image)`: Access and modify the book image.
*/

<?php
class Livre {
    // Properties to hold the book details
    private $id;
    private $titre;
    private $nbPages;
    private $image;

    // Constructor to initialize properties
    public function __construct($id, $titre, $nbPages, $image) {
        $this->id = $id;
        $this->titre = $titre;
        $this->nbPages = $nbPages;
        $this->image = $image;
    }

    // Getter and setter for 'id'
    public function getId() { 
        return $this->id; 
    }
    public function setId($id) { 
        $this->id = $id; 
    }

    // Getter and setter for 'titre'
    public function getTitre() { 
        return $this->titre; 
    }
    public function setTitre($titre) { 
        $this->titre = $titre; 
    }

    // Getter and setter for 'nbPages'
    public function getNbPages() { 
        return $this->nbPages; 
    }
    public function setNbPages($nbPages) { 
        $this->nbPages = $nbPages; 
    }

    // Getter and setter for 'image'
    public function getImage() { 
        return $this->image; 
    }
    public function setImage($image) { 
        $this->image = $image; 
    }
}
