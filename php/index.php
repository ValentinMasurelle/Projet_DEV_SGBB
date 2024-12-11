<?php


$message = "Hello KEVIN, tu as mis des moullures au plafond ?";

// Encadrer le message
$border = str_repeat("-", strlen($message) + 2);
$cowsay = <<<EOT
 $border
< $message >
 $border
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
EOT;

// Afficher dans le terminal ou dans une page web
echo "<pre>$cowsay</pre>";
 echo "Mon premier message en PHP : HELLO WOLRD"; 
 phpinfo();

?>