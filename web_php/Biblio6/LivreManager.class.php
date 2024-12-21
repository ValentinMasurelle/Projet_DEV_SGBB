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

    public function chargementLivres(){
        $req = $this->getBdd()->prepare("SELECT * FROM livres");
        $req->execute();
        $mesLivres = $req->fetchAll(PDO::FETCH_ASSOC);
        $req->closeCursor();

        foreach($mesLivres as $livre){
            $l = new Livre($livre['id'],$livre['titre'],$livre['nbPages'],$livre['image']);
            $this->ajoutLivre($l);
        }
    }
}