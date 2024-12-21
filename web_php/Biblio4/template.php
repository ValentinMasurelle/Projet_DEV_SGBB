<?php
/*=============================================================
|                   📝 PHP TEMPLATE: Book Management Layout    |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                      |
|  📅 DATE        : 2024-12-21                                |
|  📝 DESCRIPTION : This PHP template dynamically generates an
|                  HTML page that displays a navigation bar, 
|                  a dynamic page title, and dynamic content 
|                  related to book management. It utilizes 
|                  the Bootstrap framework for styling and 
|                  responsiveness. The `$titre` and `$content`
|                  variables are used to render the page's 
|                  title and main content dynamically.         |
=============================================================*/

/* ==============================
   SECTION: PHP and HTML Structure
   ==============================

1. **Dynamic Variables**:
   - `$titre` : A PHP variable that sets the page's title dynamically.
   - `$content` : A PHP variable that holds the main content to be displayed on the page.

2. **HTML Document Structure**:
   - The structure includes:
     - `<head>`: Contains meta tags for responsive design and links to external Bootstrap stylesheets.
     - `<body>`: Contains the navbar and a container for the main content.
   - Dynamic content is injected using PHP's `<?= ?>` shorthand.

3. **Navbar**:
   - The navbar contains links for navigating between the "Accueil" (Home) and "Livres" (Books) pages.
   - It uses Bootstrap classes for responsiveness and style.

4. **Main Content**:
   - The page title and content are dynamically generated based on `$titre` and `$content`.
*/
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Charset and viewport meta tags for responsive design -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($titre) ?></title> <!-- Dynamically set page title -->
    
    <!-- Link to Bootstrap theme from Bootswatch -->
    <link rel="stylesheet" href="https://bootswatch.com/4/sketchy/bootstrap.min.css">
</head>
<body>
    <!-- Navigation bar using Bootstrap classes -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" 
                aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar links that allow navigation between pages -->
        <div class="collapse navbar-collapse" id="navbarColor01">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.php">Accueil</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="livres.php">Livres</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Main content container -->
    <div class="container">
        <!-- Page title with dynamic content based on PHP variable $titre -->
        <h1 class="rounded border border-dark p-2 m-2 text-center text-white bg-info">
            <?= htmlspecialchars($titre) ?>
        </h1>
        
        <!-- Dynamic content will be injected here -->
        <?= $content ?>
    </div>
    
    <!-- Include necessary JavaScript libraries for Bootstrap functionality -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
