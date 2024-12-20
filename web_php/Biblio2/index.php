/*=============================================================
|                   📝 index.php                             |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                       |
|  📅 DATE        : 2024-12-20                                |
|  📝 DESCRIPTION : This PHP script serves as the homepage for
|                  the banking website. It displays server 
|                  information and uses output buffering to 
|                  manage dynamic content rendering.          |
|                                                             |
=============================================================*/

-- ==============================
-- SECTION 1: Output Buffering Setup
-- ==============================

<?php ob_start() ?>

-- ==============================
-- SECTION 2: Homepage Content
-- ==============================
<p>Welcome to the MGA Library Banking System</p>

-- ==============================
-- SECTION 3:  PHP Server Information & 
   Buffer Content and Template Inclusion
-- ==============================

<?php
phpinfo();
$content = ob_get_clean();
$titre = "Bibliothèque MGA";
require "template.php";
?>
