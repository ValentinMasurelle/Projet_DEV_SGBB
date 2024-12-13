<?php
// Définition des informations de connexion à la base de données
$servername = "db";    // Nom du serveur de base de données
$username = "test";     // Nom d'utilisateur pour se connecter à la base de données
$password = "pass";     // Mot de passe de l'utilisateur
$dbname = "demo";       // Nom de la base de données à utiliser

try {
    // Tentative de connexion à la base de données avec PDO (PHP Data Objects)
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    
    // Configuration du mode d'erreur de PDO pour qu'il lance une exception en cas d'erreur
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Affichage d'un message de succès si la connexion est établie
    echo "PDO Connected successfully";
} catch(PDOException $e) {
    // En cas d'échec de la connexion, afficher le message d'erreur
    echo "Connection failed: " . $e->getMessage();
}
?>
