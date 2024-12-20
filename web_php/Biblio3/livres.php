/*=============================================================
|                 📝 SCRIPT: Affichage des livres              |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                      |
|  📅 DATE        : 2024-12-20                                |
|  📝 DESCRIPTION : This script creates several instances of 
|                  the `Livre` class, stores them in the static 
|                  `$livres` array, and displays them in a 
|                  table. Each row in the table shows the 
|                  book's image, title, number of pages, and 
|                  action buttons for modifying or deleting 
|                  the book. The page is rendered using a 
|                  template and the content is captured using 
|                  output buffering.                         |
=============================================================*/

/* ==============================
   SECTION: Script Functionality
   ==============================

1. **Book Creation**:
   - Instances of the `Livre` class are created, each representing a book with specific attributes: 
     - `id`, `titre`, `nbPages`, `image`.
   - These instances are automatically added to the static `$livres` property of the `Livre` class.

2. **Output Buffering**:
   - `ob_start()` is used to start output buffering, capturing all HTML output that follows, until `ob_get_clean()` is called to retrieve the content.

3. **HTML Table Display**:
   - A table is created to display the books. For each book in the static `$livres` array, a row is generated displaying the book's:
     - Image
     - Title
     - Number of Pages
     - Action buttons for modifying or deleting the book.
   - The `src` for each book image dynamically uses the value from the `getImage()` method of each `Livre` instance.

4. **Template Rendering**:
   - The content captured by `ob_get_clean()` is stored in the `$content` variable.
   - The page title is set as `$titre = "Les livres de la bibliothèque"`.
   - The final content is rendered using the `template.php` file.
*/

<?php 
require_once "Livre.class.php";

// Create instances of the Livre class
$l1 = new Livre(1, "Algorithmique selon H2PROG", 300, "algo.png");
$l2 = new Livre(2, "Le virus Asiatique", 200, "virus.png");
$l3 = new Livre(3, "La France du 19ème", 100, "france.png");
$l4 = new Livre(4, "Le JavaScript Client", 500, "JS.png");

// Start output buffering to capture HTML content
ob_start(); 
?>

<!-- HTML Table displaying the list of books -->
<table class="table text-center">
    <tr class="table-dark">
        <th>Image</th>
        <th>Titre</th>
        <th>Nombre de pages</th>
        <th colspan="2">Actions</th>
    </tr>
    <!-- Loop through each book in the static Livre::$livres array -->
    <?php for($i = 0; $i < count(Livre::$livres); $i++) : ?>
    <tr>
        <!-- Display book image -->
        <td class="align-middle">
            <img src="public/images/<?= Livre::$livres[$i]->getImage(); ?>" width="60px;">
        </td>
        <!-- Display book title -->
        <td class="align-middle"><?= Livre::$livres[$i]->getTitre(); ?></td>
        <!-- Display number of pages -->
        <td class="align-middle"><?= Livre::$livres[$i]->getNbPages(); ?></td>
        <!-- Modify button (not implemented) -->
        <td class="align-middle">
            <a href="" class="btn btn-warning">Modifier</a>
        </td>
        <!-- Delete button (not implemented) -->
        <td class="align-middle">
            <a href="" class="btn btn-danger">Supprimer</a>
        </td>
    </tr>
    <?php endfor; ?>
</table>

<!-- Add new book button -->
<a href="" class="btn btn-success d-block">Ajouter</a>

<?php
// Capture the generated content and store it in $content
$content = ob_get_clean();
// Set the page title
$titre = "Les livres de la bibliothèque";
// Include the template file to render the final page
require "template.php";
?>
