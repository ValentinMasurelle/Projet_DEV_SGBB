<?php
# Mise en place du système de routage sur la page d'index
if(empty($_GET['page'])){ # est-ce c'est vide, si oui accès à la page d'accueil
    require "views/accueil.views.php";
} else { # sinon on va tester tout les cas avec un switch
    switch($_GET['page']){
        case "accueil" : require "views/accueil.views.php"; # premier cas, si acceuil alors je renvoi vers views/accueil.views.php
        break;
    }
}
