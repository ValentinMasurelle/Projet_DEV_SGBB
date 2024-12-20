<?php ob_start() ?>

ici le contenu de la page d'accueil

<?php
phpinfo();
$content = ob_get_clean();
$titre = "Bibliothèque MGA";
require "template.php";
?>