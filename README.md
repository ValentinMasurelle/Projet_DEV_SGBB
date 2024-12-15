# 🚀 PHP & MySQL Project with Docker and phpMyAdmin

This project provides a fully containerized environment using **Docker** to run a PHP application with a **MySQL** database and **phpMyAdmin** for easy database management. Additionally, it includes SQL scripts for triggers, stored procedures, transactions, and error handling.

---

## 🧐 **Project Components**

1. **PHP**: Backend language for the web application.  
2. **MySQL**: Relational database to store application data.  
3. **phpMyAdmin**: Web-based interface to manage the MySQL database.  
4. **Docker**: Containerizes the entire environment for easy deployment.  
5. **SQL Scripts**: Contains scripts for:
   - **Triggers**  
   - **Stored Procedures**  
   - **Transactions**  
   - **Error Handling**  

---

## 📂 **Project Structure**

```plaintext
PROJET_MYSQL_PHP/
├─ conf.d/
│   └─ my-custom.cnf            # Custom MySQL configuration
├─ data_files/                  # Data files for MySQL
├─ mysql_data/                  # MySQL data directory (persistent volume)
├─ PHP/                         # PHP application code (if applicable)
├─ SQL Script/
│   ├─ Gestion erreur/          # Error handling scripts
│   ├─ Stored Procedures/       # Stored procedures scripts
│   ├─ Transactions/            # Transaction scripts
│   └─ Triggers/                # Trigger scripts
│       ├─ testtriggers.sql
│       ├─ Triggers_after_insert_demo.sql
│       ├─ triggers_before_insert_client_demo.sql
│       ├─ triggers_before_update_2_version.sql
│       ├─ triggers_insert_update_error.sql
│       ├─ triggers_rollback.sql
│       ├─ triggers.sql
│       └─ triggersCreateTables.sql
├─ web_php/                     # PHP source code
│   └─ php.Dockerfile           # Dockerfile for PHP & Apache
├─ .gitignore                   # Git ignore file
├─ docker-compose.yml           # Docker Compose configuration
├─ init.sql                     # Initialization script for MySQL
└─ README.md                    # Project documentation
```

---

## ⚙️ **Setup Instructions**

### 1. **Create the Docker Environment**

Ensure you have the following installed:

- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)  
- **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)

Verify installations:

```bash
docker --version
docker-compose --version
```

### 2. **Docker Compose Configuration**

Here's the `docker-compose.yml` configuration for your services:

```yaml
version: '3.8'

services:
  web:
    build:
      context: ./web_php
      dockerfile: php.Dockerfile
    container_name: PhpApache
    image: php:8.0-apache
    networks:
      - my-network
    depends_on:
      - db
    volumes:
      - ./web_php/:/var/www/html/
    working_dir: /var/www/html
    ports:
      - "8080:80"

  db:
    image: mysql:8.0
    container_name: mysql8
    networks:
      - my-network
    command:
      - '--default-authentication-plugin=caching_sha2_password'
      - '--character-set-server=utf8'
      - '--collation-server=utf8_unicode_ci'
      - '--local-infile=ON'
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_USER: test
      MYSQL_PASSWORD: pass
    ports:
      - "3306:3306"
    volumes:
      - ./data_files:/data_files
      - ./conf.d:/etc/mysql/conf.d
      - ./mysql_data:/var/lib/mysql
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql

  phpmyadmin:
    container_name: phpmyadmin
    image: phpmyadmin/phpmyadmin
    networks:
      - my-network
    links:
      - db
    environment:
      PMA_HOST: db
      PMA_ARBITRARY: 1
      PMA_PORT: 3306
    ports:
      - "8081:80"

volumes:
  mysql_data: {}

networks:
  my-network:
```

---

## 🚀 **Running the Project**

### Start the Containers

To build and start all services:

```bash
docker-compose up --build
```

### Access the Services

- **PHP Application**: [http://localhost:8080](http://localhost:8080)  
- **phpMyAdmin**: [http://localhost:8081](http://localhost:8081)  

  - **Username**: `test`  
  - **Password**: `pass`

### Stop the Containers

```bash
docker-compose down
```

---

## 📂 **Database Initialization**

The `init.sql` file initializes the database and grants necessary privileges to the `test` user. Make sure the file contains the following commands:

```sql
CREATE DATABASE IF NOT EXISTS sample_db;

USE sample_db;

GRANT ALL PRIVILEGES ON sample_db.* TO 'test'@'%';
FLUSH PRIVILEGES;
```

---

## 📊 **SQL Scripts**

### Triggers

Located in `SQL Script/Triggers/`, these scripts create and manage database triggers. Examples include:

- **`triggers_before_insert_client_demo.sql`**: Demonstrates `BEFORE INSERT` triggers.  
- **`triggers_rollback.sql`**: Handles rollback scenarios within transactions.

### Stored Procedures

Stored procedures can be found in `SQL Script/Stored Procedures/`. Use these to automate repetitive tasks and complex queries.

### Transactions

Transactional scripts in `SQL Script/Transactions/` manage data consistency and integrity during operations.

---

## 🔧 **Troubleshooting**

### Common Issues

- **Port Conflicts**: Ensure ports `8080` (PHP) and `8081` (phpMyAdmin) are not in use.
- **Permission Errors**: Ensure appropriate permissions for `mysql_data` and `web_php` directories.
- **Database Connection Issues**: Verify credentials and network settings in `docker-compose.yml`.

### Debugging Containers

View logs with:

```bash
docker-compose logs -f
```

Access the MySQL container:

```bash
docker exec -it mysql8 mysql -u root -p
```

---

## 🎉 **Conclusion**

This setup provides a robust environment for developing PHP applications with MySQL, complete with database management via phpMyAdmin. The inclusion of SQL scripts for triggers, stored procedures, transactions, and error handling supports more advanced database functionality.

Happy coding! 🚀
