<?php 

require_once "LivreManager.class.php";
$livreManager = new LivreManager;
# Appel de la fonction chargement livres et visualisation du resultat du query
$livreManager->chargementLivres();


ob_start(); 
?>

<?php
$content = ob_get_clean();
$titre = "Les livres de la bibliothèque";
require "template.php";
?>