/*=============================================================
|                   📝 HTML TEMPLATE: Book Management Layout   |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                      |
|  📅 DATE        : 2024-12-20                                |
|  📝 DESCRIPTION : This HTML template is used to render a 
|                  webpage that displays a navigation bar, 
|                  a dynamic page title, and dynamic content 
|                  related to book management. It uses the 
|                  Bootstrap framework for responsive design 
|                  and styling. The template is intended to 
|                  display the content passed from a PHP 
|                  script, such as a list of books.            |
=============================================================*/

/* ==============================
   SECTION: HTML Structure
   ==============================

1. **Head Section**:
   - The `<meta charset="UTF-8">` and `<meta name="viewport" content="width=device-width, initial-scale=1.0">` tags ensure proper character encoding and responsive design for mobile devices.
   - A link to the **Bootswatch Sketchy Bootstrap theme** is included to style the page with a clean and simple design.

2. **Navbar**:
   - A Bootstrap-powered **navbar** is included at the top of the page, providing navigation links for "Accueil" (Home) and "Livres" (Books).
   - The navbar is responsive, with a hamburger menu on smaller screens.

3. **Main Content Area**:
   - The content section includes a dynamic page title, which is set via the `$titre` variable in the PHP script.
   - The dynamic content is inserted via the `<?= $content ?>` placeholder. This allows for flexible content rendering (such as a list of books) from PHP.

4. **JavaScript and Bootstrap**:
   - Three essential JavaScript files are included to ensure that the Bootstrap framework’s interactive components, such as the collapsible navbar, function correctly.
   - The files are linked from CDN sources for fast delivery.

*/

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Charset and viewport meta tags for responsive design -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
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
        <h1 class="rounded border border-dark p-2 m-2 text-center text-white bg-info"><?= $titre ?></h1>
        
        <!-- Dynamic content will be injected here -->
        <?= $content ?>
    </div>
    
    <!-- Include necessary JavaScript libraries for Bootstrap functionality -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
