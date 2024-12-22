<?php 
/*=============================================================
|                   📝 PHP CODE: Books List View              |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-21                                |
|  📝 DESCRIPTION : This code generates an HTML table displaying 
|                  a list of books. It uses output buffering 
|                  to capture the content of the table and then 
|                  passes it to a template for rendering with 
|                  a dynamic title.                            |
=============================================================*/

/**
 * Start output buffering.
 * 
 * Output buffering allows us to capture the HTML content generated
 * by the page and store it in a variable, which will then be used 
 * in the template for rendering.
 */
ob_start(); 
?>

<!-- HTML Table displaying books -->
<table class="table text-center">
    <!-- Table header with column titles -->
    <tr class="table-dark">
        <th>Image</th>
        <th>Titre</th>
        <th>Nombre de pages</th>
        <th>Editeur</th>
        <th colspan="2">Actions</th>
    </tr>

    <?php 
    // Loop through each book in the $livres array
    // The $livres array contains book objects, and we use a for loop to iterate through them
    for($i = 0; $i < count($livres); $i++) : 
    ?>
    
    <!-- Table row displaying the book's details -->
    <tr>
        <!-- Display the book's image -->
        <td class="align-middle">
            <img src="public/images/<?= $livres[$i]->getImage(); ?>" width="60px;">
        </td>
        
        <!-- Display the book's title -->
        <td class="align-middle"><?= $livres[$i]->getTitre(); ?></td>
        
        <!-- Display the number of pages for the book -->
        <td class="align-middle"><?= $livres[$i]->getNbPages(); ?></td>

        <!-- Display the editeur of the book -->
        <td class="align-middle"><?= $livres[$i]->getEditeur(); ?></td>
        
        <!-- Action buttons for modifying the book -->
        <td class="align-middle">
            <a href="" class="btn btn-warning">Modifier</a>
        </td>
        
        <!-- Action buttons for deleting the book -->
        <td class="align-middle">
            <a href="" class="btn btn-danger">Supprimer</a>
        </td>
    </tr>
    
    <?php endfor; ?>
</table>

<!-- Button to add a new book -->
<a href="" class="btn btn-success d-block">Ajouter</a>

<?php
// Capture the content from the output buffer and store it in the $content variable
$content = ob_get_clean();

/**
 * Set the title for the page.
 * 
 * The title is passed to the template and will be used to set the page's 
 * title dynamically.
 */
$titre = "Les livres de la bibliothèque";

/**
 * Include the template to render the full page.
 * 
 * The template is responsible for rendering the complete HTML page, 
 * including the book list and the dynamic title.
 */
require "template.php";
?>
