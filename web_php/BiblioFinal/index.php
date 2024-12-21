<?php
# on récupére le fichier  "controllers/LivresController.controller.php"
require_once "controllers/LivresController.controller.php";
# on crée une instance de la classe pour ensuite utiliser la fonction
# afficherLivres()
$livreController = new LivresController;
# La fonction est ensuite implémentée dans le case 'livres"
if(empty($_GET['page'])){
    require "views/accueil.view.php";
} else {
    switch($_GET['page']){
        case "accueil" : require "views/accueil.view.php";
        break;
        case "livres" : $livreController->afficherLivres();
        break;
    }
}
