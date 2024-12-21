<?php
require_once "models/LivreManager.class.php";

class LivresController{
    private $livreManager;
    # constructeur permettant de faire une instance de ma classe
    public function __construct(){
        $this->livreManager = new LivreManager;
        $this->livreManager->chargementLivres();
    }
    # fonction qui permet de récupéré le template de la vue "views/livres.view.php"
    public function afficherLivres(){
        # la variable $livres va récupérer tout les livres du livres manager
        $livres = $this->livreManager->getLivres();
        require "views/livres.view.php";
    }
}