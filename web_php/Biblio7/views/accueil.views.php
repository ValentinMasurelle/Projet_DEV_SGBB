<?php 
ob_start(); 
?>

Ici la page d'accueil in views

<?php
$content = ob_get_clean();
$titre = "Bibliothèque MGA";
require "template.php";
?>