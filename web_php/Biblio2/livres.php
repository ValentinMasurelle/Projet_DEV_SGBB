/*=============================================================
|                   📝 SCRIPT: Gestion de livres              |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                      |
|  📅 DATE        : 2024-12-20                                |
|  📝 DESCRIPTION : This script displays a list of books using
|                  the 'Livre' class. The book data is shown 
|                  in an HTML table with options to modify or
|                  delete each entry, and a button to add new
|                  entries.                                   |
=============================================================*/

/* ==============================
   SECTION: Code Explanation
   ==============================

1. **Include Class File**:
   - `require_once "Livre.class.php";`
   - Imports the `Livre` class definition to create book objects.

2. **Create Book Instances**:
   - `$l1`, `$l2`, `$l3`, and `$l4` are instances of the `Livre` class with attributes:
     - **ID**: Unique identifier.
     - **Title**: Book title.
     - **Number of Pages**: Total pages in the book.
     - **Image**: Filename of the book cover image.

3. **Array of Books**:
   - `$livres = [$l1, $l2, $l3, $l4];`
   - Stores all book instances in an array for easy iteration.

4. **Output Buffering**:
   - `ob_start();`
   - Starts buffering the output, allowing content to be stored and manipulated before sending it to the template.

5. **HTML Table**:
   - Displays book details (Image, Title, Number of Pages) and provides buttons for actions (`Modifier` and `Supprimer`).

6. **Loop through Books**:
   - `for($i = 0; $i < count($livres); $i++) :`
   - Iterates through the `$livres` array to generate a table row for each book.

7. **Table Content**:
   - **Image**: Displays the book's image.
   - **Title**: Displays the book title.
   - **Number of Pages**: Displays the page count.
   - **Actions**: Provides buttons to modify or delete the book entry.

8. **Add Button**:
   - `<a href="" class="btn btn-success d-block">Ajouter</a>`
   - A button to add a new book entry.

9. **Content Storage and Template Inclusion**:
   - `$content = ob_get_clean();`
     - Stores the buffered content in the `$content` variable.
   - `$titre = "Les livres de la bibliothèque";`
     - Sets the title for the page.
   - `require "template.php";`
     - Includes the template file to render the final page.
*/

<?php 
require_once "Livre.class.php";

// Create book instances
$l1 = new Livre(1, "Algorithmique selon H2PROG", 300, "algo.png");
$l2 = new Livre(2, "Le virus Asiatique", 200, "virus.png");
$l3 = new Livre(3, "La France du 19ème", 100, "france.png");
$l4 = new Livre(4, "Le JavaScript Client", 500, "JS.png");

// Array of book instances
$livres = [$l1, $l2, $l3, $l4];

ob_start(); 
?>

<!-- HTML Table for Displaying Books -->
<table class="table text-center">
    <tr class="table-dark">
        <th>Image</th>
        <th>Titre</th>
        <th>Nombre de pages</th>
        <th colspan="2">Actions</th>
    </tr>
    <?php for ($i = 0; $i < count($livres); $i++) : ?>
        <tr>
            <td class="align-middle">
                <img src="public/images/<?= $livres[$i]->getImage(); ?>" width="60px;">
            </td>
            <td class="align-middle"><?= $livres[$i]->getTitre(); ?></td>
            <td class="align-middle"><?= $livres[$i]->getNbPages(); ?></td>
            <td class="align-middle">
                <a href="" class="btn btn-warning">Modifier</a>
            </td>
            <td class="align-middle">
                <a href="" class="btn btn-danger">Supprimer</a>
            </td>
        </tr>
    <?php endfor; ?>
</table>

<!-- Button to Add a New Book -->
<a href="" class="btn btn-success d-block">Ajouter</a>

<?php
$content = ob_get_clean();
$titre = "Les livres de la bibliothèque";
require "template.php";
?>
