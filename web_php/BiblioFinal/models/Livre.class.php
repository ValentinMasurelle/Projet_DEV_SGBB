<?php
/*=============================================================
|                   📝 CLASS: Livre                            |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-21                                |
|  📝 DESCRIPTION : This class represents a book (`Livre`) 
|                  with various attributes like id, title, 
|                  number of pages, image, and publisher (editor). 
|                  It includes getter and setter methods for 
|                  each attribute to manage book information.   |
=============================================================*/

/**
 * Livre Class
 * 
 * This class models a book with essential attributes such as id, title,
 * number of pages, image, and publisher (editeur). It includes getter 
 * and setter methods for each attribute to manipulate book data.
 */
class Livre {
    /**
     * @var int $id The ID of the book.
     */
    private $id;

    /**
     * @var string $titre The title of the book.
     */
    private $titre;

    /**
     * @var int $nbPages The number of pages in the book.
     */
    private $nbPages;

    /**
     * @var string $image The image (cover) of the book.
     */
    private $image;

    /**
     * @var string $editeur The publisher (editor) of the book.
     */
    private $editeur;

    /**
     * Constructor to initialize a book object.
     *
     * This constructor sets the initial values for the book's id, title,
     * number of pages, image, and publisher (editor) upon creation.
     *
     * @param int $id The ID of the book.
     * @param string $titre The title of the book.
     * @param int $nbPages The number of pages in the book.
     * @param string $image The image (cover) of the book.
     * @param string $editeur The publisher (editor) of the book.
     */
    public function __construct($id, $titre, $nbPages, $image, $editeur) {
        $this->id = $id;
        $this->titre = $titre;
        $this->nbPages = $nbPages;
        $this->image = $image;
        $this->editeur = $editeur;
    }

    /**
     * Getter for the book's ID.
     *
     * @return int The ID of the book.
     */
    public function getId() {
        return $this->id;
    }

    /**
     * Setter for the book's ID.
     *
     * @param int $id The new ID to set for the book.
     * @return void
     */
    public function setId($id) {
        $this->id = $id;
    }

    /**
     * Getter for the book's title.
     *
     * @return string The title of the book.
     */
    public function getTitre() {
        return $this->titre;
    }

    /**
     * Setter for the book's title.
     *
     * @param string $titre The new title to set for the book.
     * @return void
     */
    public function setTitre($titre) {
        $this->titre = $titre;
    }

    /**
     * Getter for the book's number of pages.
     *
     * @return int The number of pages in the book.
     */
    public function getNbPages() {
        return $this->nbPages;
    }

    /**
     * Setter for the book's number of pages.
     *
     * @param int $nbPages The new number of pages to set for the book.
     * @return void
     */
    public function setNbPages($nbPages) {
        $this->nbPages = $nbPages;
    }

    /**
     * Getter for the book's image (cover).
     *
     * @return string The image (cover) of the book.
     */
    public function getImage() {
        return $this->image;
    }

    /**
     * Setter for the book's image (cover).
     *
     * @param string $image The new image (cover) to set for the book.
     * @return void
     */
    public function setImage($image) {
        $this->image = $image;
    }

    /**
     * Getter for the book's publisher (editor).
     *
     * @return string The publisher (editor) of the book.
     */
    public function getEditeur() {
        return $this->editeur;
    }

    /**
     * Setter for the book's publisher (editor).
     *
     * @param string $editeur The new publisher (editor) to set for the book.
     * @return void
     */
    public function setEditeur($editeur) {
        $this->editeur = $editeur;
    }
}
?>
