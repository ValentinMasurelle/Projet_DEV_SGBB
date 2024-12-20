/*=============================================================
|                   📝 livres.php                            |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                       |
|  📅 DATE        : 2024-12-20                                |
|  📝 DESCRIPTION : This script lists the books available in 
|                  the library. It uses output buffering to 
|                  manage dynamic content and includes a 
|                  template for consistent page layout.       |
|                                                             |
=============================================================*/

<?php ob_start() ?>
<!-- Starts output buffering. All output between ob_start() and ob_get_clean() is captured in the buffer. -->

ici le contenu de ma page listant les livres

<?php
$content = ob_get_clean(); 
// Ends output buffering and returns the buffered content as a string. The buffer is then cleaned (erased).

$titre = "Les livres de la bibliothèque";
// Sets the title of the page to "Les livres de la bibliothèque".

require "template.php";
// Includes the 'template.php' file, which likely contains the layout structure for the page.
?>
