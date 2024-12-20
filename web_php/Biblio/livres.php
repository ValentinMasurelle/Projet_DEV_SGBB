<?php ob_start() ?>

ici le contenu de ma page listant les livres

<?php
$content = ob_get_clean();
$titre = "Les livres de la bibliothèque";
require "template.php";
?>