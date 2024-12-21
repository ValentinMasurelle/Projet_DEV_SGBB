<?php
require_once "Model.class.php";
require_once "Livre.class.php";

class LivreManager extends Model{
    private $livres;

    public function ajoutLivre($livre){
        $this->livres[] = $livre;
    }

    public function getLivres(){
        return $this->livres;
    }
# fonction pour récupérer les livres de ma db
    public function chargementLivres(){
        # le select doit être remplacé par une vue
        $req = $this->getBdd()->prepare("SELECT * FROM livres");
        $req->execute();
        # fetchAll permet de récupérer toutes les lignes
        $Livres = $req->fetchAll(PDO::FETCH_ASSOC);
        # Vérifions sur nous obtenons bien nos livres dans une balise pre pour une meilleure 
        # présentation
        echo "<pre>";
            print_r($Livres);
        echo "</prev>";
        $req->closeCursor();

        /* foreach($Livres as $livre){
            $l = new Livre($livre['id'],$livre['titre'],$livre['nbPages'],$livre['image']);
            $this->ajoutLivre($l);
        }*/
    }
}