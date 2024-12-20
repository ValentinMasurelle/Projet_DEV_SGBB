/*===================================================================
|                     📝 SQL SCRIPT: Table and Data Setup            |
|-------------------------------------------------------------------|
|  👨‍💻 AUTHOR      : Masurelle Valentin                             |
|  📅 DATE        : 2024-12-20                                       |
|  📝 DESCRIPTION : This SQL script sets up a database table for 
|                  storing book information (livres) in a library 
|                  system. It includes the creation of the table, 
|                  inserting initial data, and modifying the table 
|                  to include an auto-incrementing primary key.     |
====================================================================*/

/* ==============================
   SECTION 1: Database Connection Information
   ==============================
   The SQL script assumes the following active connection:
   - Host: 127.0.0.1 (Localhost)
   - Port: 3306 (default MySQL port)
   - Database: `Biblio` (library database)
*/

-- Active: 1733476523797@@127.0.0.1@3306@Biblio
-- Active: 1733476523797@@127.0.0.1@3306

/* ==============================
   SECTION 2: Table Creation
   ==============================

1. **Table Definition (`livres`)**:
   - The `livres` table is created to store book information with the following columns:
     - `id`: Integer field to uniquely identify each book (primary key).
     - `titre`: A string (varchar) field for the book title (up to 150 characters).
     - `nbPages`: Integer field to store the number of pages in the book.
     - `image`: A string (varchar) field to store the filename of the book's cover image (up to 150 characters).

2. **Table Engine and Charset**:
   - The table uses the **InnoDB** engine for support of transactions and foreign keys.
   - The character set for the table is set to `latin1`, which is compatible with Western European characters.

3. **Table Creation SQL**:
*/



CREATE TABLE `livres` (
  `id` int(11) NOT NULL,           -- Primary key column, auto-incremented
  `titre` varchar(150) NOT NULL,    -- Book title
  `nbPages` int(11) NOT NULL,       -- Number of pages
  `image` varchar(150) NOT NULL     -- Image filename for book cover
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Comments on the table creation:
-- The table is set to use the `InnoDB` engine for transaction support and foreign key constraints.
-- The `latin1` character set is used, which might be replaced with UTF-8 for wider international character support.


/* ==============================
   SECTION 3: Data Insertion
   ==============================

1. **Inserting Initial Data**:
   - Four rows are inserted into the `livres` table. Each row contains data for a book:
     - `id`: Unique identifier for the book.
     - `titre`: Title of the book.
     - `nbPages`: Number of pages in the book.
     - `image`: Filename for the book’s cover image.

2. **Data Insertion SQL**:
*/

INSERT INTO `livres` (`id`, `titre`, `nbPages`, `image`) VALUES
(1, 'L\'algorithmique selon H2PROG', 300, 'algo.png'),
(2, 'Le virus Asiatique 2', 20, 'virus.png'),
(3, 'La France du 19ème', 22, 'france.png'),
(4, 'Le JavaScript Client', 500, 'JS.png');

-- Comments on data insertion:
-- Four sample books are added to the `livres` table. Each entry includes the book’s `id`, `titre`, `nbPages`, and `image`.
-- The apostrophe in the title of the first book (`L'algorithmique`) is escaped using a backslash (`\'`).

/* ==============================
   SECTION 4: Indexing
   ==============================

1. **Primary Key Index**:
   - A primary key index is created on the `id` column. This ensures that each record in the table has a unique identifier.

2. **Primary Key Index SQL**:
*/

ALTER TABLE `livres`
  ADD PRIMARY KEY (`id`);

-- Comments on indexing:
-- The `id` column is set as the primary key of the `livres` table, ensuring that no two books have the same `id`.


/* ==============================
   SECTION 5: Auto-Increment Setup
   ==============================

1. **Auto-Increment for `id` Column**:
   - The `id` column is modified to use **auto-increment**, which automatically generates a unique value for new records.
   - The auto-increment start value is set to `5` to ensure that the next inserted record will have `id = 5`.

2. **Auto-Increment Modification SQL**:
*/

ALTER TABLE `livres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- Comments on auto-increment:
-- This modification makes the `id` column auto-increment, meaning new books inserted will automatically receive a unique `id`.
-- The auto-increment counter is set to 5, which means the next inserted book will have `id = 5`.

-- The `COMMIT` statement finalizes the transaction and ensures all changes are saved to the database.

COMMIT;

-- Comments on COMMIT:
-- The `COMMIT` statement ensures that all modifications to the database (such as table creation, data insertion, and index changes) are permanently saved.


