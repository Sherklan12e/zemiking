DROP DATABASE IF EXISTS movies;
CREATE DATABASE IF NOT EXISTS movies;

USE movies;

CREATE TABLE `movies` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(150) NULL DEFAULT NULL,
	`year` INT(11) NULL DEFAULT NULL,
	`director` VARCHAR(200) NULL DEFAULT NULL,
	`genre` VARCHAR(200) NULL DEFAULT NULL,
	`principal_actor` VARCHAR(200) NULL DEFAULT NULL,
	`image_url` VARCHAR(255) NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
;

CREATE TABLE IF NOT EXISTS `comments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL DEFAULT 'Anónimo',
  `comment` TEXT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
)
ENGINE=InnoDB;

DESCRIBE movies;

## Datos de prueba
INSERT INTO movies (name, year, director, genre, principal_actor, image_url) values 
  ('Hellboy', 2004 , 'Del Toro', 'Action', 'Ron Perlman', 'uploads/A.png'),
  ('Titanic', 1997 , 'James Cameron', 'Drama', 'Leonardo DiCaprio', 'uploads/mary.png'),
  ('Hooligans', 2008 , 'Green Street Hooligans', 'Action', 'Charlie Hunnam', 'uploads/Emetsuky.png');
INSERT INTO comments (name, comment) VALUES 
  ('Juan', 'Como ese posible gloglo'),
  ('Juanito', 'boeeeeeeeeee');
SELECT * FROM movies;