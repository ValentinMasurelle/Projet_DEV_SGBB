
DROP TABLE IF EXISTS `db_1`.`users`;
CREATE TABLE IF NOT EXISTS `db_1`.`users` (
  `id` int(11) AUTO_INCREMENT NOT NULL,
  `name` varchar(30) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `db_2`.`users`;
CREATE TABLE IF NOT EXISTS `db_2`.`users` (
  `id` int(11) AUTO_INCREMENT NOT NULL,
  `name` varchar(30) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `db_1`.`errors`;
CREATE TABLE IF NOT EXISTS `db_1`.`errors` (
  `id` int(11) AUTO_INCREMENT NOT NULL,
  `code` varchar(30) NOT NULL,
  `message` TEXT NOT NULL,
  `query_type` varchar(50) NOT NULL,
  `record_id` int(11) NOT NULL,
  `on_db` varchar(50) NOT NULL,
  `on_table` varchar(50) NOT NULL,
  `emailed` TINYINT DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


DELIMITER $$

DROP TRIGGER IF EXISTS `db_1`.`test_db1_users_ai`;
CREATE TRIGGER `db_1`.`test_db1_users_ai` AFTER INSERT ON `db_1`.`users` FOR EACH ROW 
BEGIN

    DECLARE errorCode CHAR(5) DEFAULT '00000';
    DECLARE errorMessage TEXT DEFAULT '';


    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
      GET DIAGNOSTICS CONDITION 1
        errorCode = RETURNED_SQLSTATE, errorMessage = MESSAGE_TEXT;
    END;


    INSERT INTO `db_2`.`users` (id, name, age) VALUES (NEW.id, NEW.name, NEW.age);


    IF errorCode != '00000' THEN
        INSERT INTO `errors` (code, message, query_type, record_id, on_db, on_table) 
        VALUES (errorCode, errorMessage, 'insert', NEW.id, 'test_db2', 'users');
    END IF;
END; $$
DELIMITER ;


DROP TRIGGER IF EXISTS `db_1`.`test_db1_users_au`;
DELIMITER $$
CREATE TRIGGER `db_1`.`test_db1_users_au` AFTER UPDATE ON `users` FOR EACH ROW 
BEGIN 

    DECLARE errorCode CHAR(5) DEFAULT '00000';
    DECLARE errorMessage TEXT DEFAULT '';


    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
      GET DIAGNOSTICS CONDITION 1
        errorCode = RETURNED_SQLSTATE, errorMessage = MESSAGE_TEXT;
    END;


    UPDATE `db_2`.`users`
        SET name = NEW.name,
            age = NEW.age
        WHERE id = NEW.id;


    IF errorCode != '00000' THEN
        INSERT INTO `errors` (code, message, query_type, record_id, on_db, on_table) 
        VALUES (errorCode, errorMessage, 'update', NEW.id, 'test_db2', 'users');
    END IF;
END; $$
DELIMITER ;

DROP TRIGGER IF EXISTS `db_1`.`test_db1_users_ad`;
DELIMITER $$
CREATE TRIGGER `db_1`.`test_db1_users_ad` AFTER DELETE ON `users` FOR EACH ROW 
BEGIN

    DECLARE errorCode CHAR(5) DEFAULT '00000';
    DECLARE errorMessage TEXT DEFAULT '';


    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
      GET DIAGNOSTICS CONDITION 1
        errorCode = RETURNED_SQLSTATE, errorMessage = MESSAGE_TEXT;
    END;

    DELETE FROM `db_2`.`users`
        WHERE id = OLD.id;

    IF errorCode != '00000' THEN
        INSERT INTO `errors` (code, message, query_type, record_id, on_db, on_table) 
        VALUES (errorCode, errorMessage, 'delete', OLD.id, 'db_2', 'users');
    END IF;
END; $$

 DELIMITER;

 INSERT INTO `db_1`.`users` (name,age)
 VALUES('Alan',25) ;
 INSERT INTO `db_1`.`users` (name,age)
 VALUES('Norah',17) ;

 UPDATE `db_1`.`users` 
 SET age = 26
 WHERE name = 'Alan' ;

 DELETE FROM `db_1`.`users`
 WHERE `db_1`.`users`.id = 1 ;

 SELECT CONCAT('db_1','.','users'), id,name,age FROM `db_1`.`users`;
 SELECT CONCAT('db_2','.','users'), id,name,age FROM `db_2`.`users`;