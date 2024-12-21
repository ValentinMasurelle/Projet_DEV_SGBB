<?php 
/*=============================================================
|                   📝 PHP CODE: Homepage View                |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-21                                |
|  📝 DESCRIPTION : This code is responsible for rendering 
|                  the homepage content. It uses output buffering 
|                  to capture the content of the page, assign it 
|                  to a variable, and then includes the template 
|                  to render the full page with a title.        |
=============================================================*/

/**
 * Start output buffering.
 * 
 * This function starts output buffering, which allows us to capture
 * the output (content) of the page into a variable before sending it
 * to the browser. This technique is used to dynamically manage the 
 * content of the page and insert it into a template.
 */
ob_start(); 
?>

<!-- Page content starts here -->
<p>Ici la page d'accueil</p>
<!-- End of page content -->

<?php
// Capture the content from the output buffer and store it in the $content variable
$content = ob_get_clean();

/**
 * Set the title for the page.
 * 
 * This variable holds the title that will be passed to the template for rendering.
 */
$titre = "Bibliothèque MGA";

/**
 * Include the template.
 * 
 * This includes the "template.php" file, which will use the variables 
 * `$content` and `$titre` to render the full page, displaying the 
 * content and setting the page's title.
 */
require "template.php";
?>
