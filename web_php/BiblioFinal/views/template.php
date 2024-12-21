<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Metadata for character encoding and responsive design -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Title of the page, dynamically set via PHP -->
    <title>Document</title>
    
    <!-- External Bootstrap CSS for styling (from Bootswatch, Sketchy theme) -->
    <link rel="stylesheet" href="https://bootswatch.com/4/sketchy/bootstrap.min.css">
</head>
<body>
    <!-- Navbar with Bootstrap classes, collapsible on smaller screens -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <!-- Navbar toggler for mobile views (hamburger icon) -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar links (expanded when on larger screens) -->
        <div class="collapse navbar-collapse" id="navbarColor01">
            <ul class="navbar-nav mr-auto">
                <!-- Home link -->
                <li class="nav-item">
                    <a class="nav-link" href="accueil">Accueil</a>
                </li>
                
                <!-- Books list link -->
                <li class="nav-item">
                    <a class="nav-link" href="livres">Livres</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Main content container -->
    <div class="container">
        <!-- Page title displayed in a styled header with dynamic content from PHP -->
        <h1 class="rounded border border-dark p-2 m-2 text-center text-white bg-info"><?= $titre ?></h1>
        
        <!-- The main content of the page is dynamically inserted from PHP -->
        <?= $content ?>
    </div>
    
    <!-- External scripts for jQuery, Popper.js, and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
