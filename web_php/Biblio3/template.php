/*=============================================================
|                   📝 HTML TEMPLATE: Page Layout              |
|-------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                      |
|  📅 DATE        : 2024-12-20                                |
|  📝 DESCRIPTION : This HTML template provides the layout 
|                  for the web page. It includes a navigation 
|                  bar, a content section, and links to 
|                  external CSS and JavaScript files. The 
|                  template is designed to display dynamic 
|                  content passed from the PHP script.         |
=============================================================*/

/* ==============================
   SECTION: Template Structure
   ==============================

1. **HTML Structure**:
   - **Meta Tags**: Charset and viewport settings for responsiveness.
   - **External Resources**:
     - A Bootstrap 4 theme (`Sketchy`) for styling.
   - **Navbar**: Contains links to the "Accueil" (Home) and "Livres" (Books) pages.
   - **Content Section**: Displays dynamic content passed from the PHP script (stored in `$content`).

2. **Navbar**:
   - Uses the Bootstrap `navbar` component for navigation.
   - Links for home (`index.php`) and books (`livres.php`).
   - A toggle button for collapsing the navbar on mobile devices.

3. **Dynamic Content Rendering**:
   - The page title is dynamically set using the `$titre` variable.
   - The main content of the page is rendered using the `<?= $content ?>` PHP tag, where `$content` is passed from the PHP script.

4. **JavaScript Files**:
   - jQuery, Popper.js, and Bootstrap JS are included for responsive and interactive features such as dropdowns and modals.
*/

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Character encoding and viewport meta tags for responsive design -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Document title -->
    <title>Document</title>
    
    <!-- Link to the Bootstrap 4 Sketchy theme -->
    <link rel="stylesheet" href="https://bootswatch.com/4/sketchy/bootstrap.min.css">
</head>
<body>
    <!-- Navigation bar with links to Home and Books pages -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

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
        <!-- Page title dynamically rendered -->
        <h1 class="rounded border border-dark p-2 m-2 text-center text-white bg-info"><?= $titre ?></h1>
        
        <!-- Dynamic content from PHP script -->
        <?= $content ?>
    </div>
    
    <!-- External JavaScript files for Bootstrap functionality -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
