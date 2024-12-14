/*=============================================================
|                   🏃 QUERY SportifCourse                    | 
|-------------------------------------------------------------|
|  📌 AUTHOR      : Masurelle Valentin                        |
|  📅 DATE        : 2024-12-14                                |
|  📝 DESCRIPTION : GRANT PRIVILEGES TO USER TEST             |	
	                                                          |
|                                                             |
|                                                             |
|                                                             |
|  🗄️ DATABASE    : ALL DATABASES                           |
=============================================================*/



-- ------------------------------------------------------------
-- GRANT PRIVILEGES TO USER
-- ------------------------------------------------------------

-- Grant all privileges on all databases and tables (*) to the user 'test' 
-- from any host ('%'). The user also gets the 'WITH GRANT OPTION' 
-- which allows them to grant privileges to others.
GRANT ALL PRIVILEGES ON *.* TO 'test'@'%' WITH GRANT OPTION;

-- ------------------------------------------------------------
-- FLUSH PRIVILEGES
-- ------------------------------------------------------------

-- Apply the privilege changes by reloading the grant tables
-- This ensures that the changes made by the GRANT command take effect immediately.
FLUSH PRIVILEGES;
