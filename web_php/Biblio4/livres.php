/*=============================================================
|                   📝 PHP SCRIPT: Book Management             |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                      |
|  📅 DATE        : 2024-12-20                                |
|  📝 DESCRIPTION : This script manages the collection of 
|                  books (`Livre` objects) using the 
|                  `LivreManager` class. It creates instances 
|                  of the `Livre` class, adds them to the 
|                  manager, and dynamically displays the 
|                  list of books in a table format using 
|                  HTML. It includes functionality to display
|                  book images, titles, and page counts.       |
=============================================================*/

/* ==============================
   SECTION: Script Overview
   ==============================

1. **Livre Creation**:
   - Four `Livre` objects are created with specific details (ID, title, page count, image).
   
2. **LivreManager**:
   - A `LivreManager` object is instantiated to manage the collection of `Livre` objects.
   - The `ajoutLivre()` method is used to add the `Livre` objects to the manager.

3. **HTML Table**:
   - An HTML table is used to display the list of books stored in the `LivreManager`.
   - The table dynamically renders the book's image, title, and number of pages.
   - Action buttons for "Modify" and "Delete" are also included (though not yet functional).

4. **Dynamic Content Rendering**:
   - The `$livres` array, retrieved from `getLivres()`, is looped through to populate the table rows.

5. **Template Inclusion**:
   - The HTML content is captured and passed to a template (`template.php`) for rendering with a page title (`$titre`).
*/

<?php 
// Including the Livre class to create Livre objects
require_once "Livre.class.php";

// Creating instances of the Livre class
$l1 = new Livre(1, "Algorithmique selon H2PROG", 300, "algo.png");
$l2 = new Livre(2, "Le virus Asiatique", 200, "virus.png");
$l3 = new Livre(3, "La France du 19ème", 100, "france.png");
$l4 = new Livre(4, "Le JavaScript Client", 500, "JS.png");

// Including the LivreManager class to manage the collection of livres
require_once "LivreManager.class.php";

// Creating an instance of LivreManager
$livreManager = new LivreManager;

// Adding Livre objects to the LivreManager
$livreManager->ajoutLivre($l1);
$livreManager->ajoutLivre($l2);
$livreManager->ajoutLivre($l3);
$livreManager->ajoutLivre($l4);

// Start output buffering to capture dynamic content
ob_start(); 
?>

<!-- HTML Table to display the books dynamically -->
<table class="table text-center">
    <tr class="table-dark">
        <th>Image</th>
        <th>Titre</th>
        <th>Nombre de pages</th>
        <th>Editeur</th>
        <th colspan="2">Actions</th>
    </tr>
    
    <?php 
    // Retrieving the list of livres from the LivreManager
    $livres = $livreManager->getLivres();
    
    // Looping through the livres array and generating table rows
    for($i = 0; $i < count($livres); $i++) : 
    ?>
    <tr>
        <td class="align-middle">
            <!-- Displaying book image -->
            <img src="public/images/<?= $livres[$i]->getImage(); ?>" width="60px;">
        </td>
        <td class="align-middle"><?= $livres[$i]->getTitre(); ?></td>
        <td class="align-middle"><?= $livres[$i]->getNbPages(); ?></td>
        <td class="align-middle">
            <!-- Modify button (currently no functionality) -->
            <a href="" class="btn btn-warning">Modifier</a>
        </td>
        <td class="align-middle">
            <!-- Delete button (currently no functionality) -->
            <a href="" class="btn btn-danger">Supprimer</a>
        </td>
    </tr>
    <?php endfor; ?>
</table>

<!-- Add book button (currently no functionality) -->
<a href="" class="btn btn-success d-block">Ajouter</a>

<?php
// Capturing the HTML content into the $content variable
$content = ob_get_clean();

// Setting the page title dynamically
$titre = "Les livres de la bibliothèque";

// Including the template for page rendering
require "template.php";
?>
