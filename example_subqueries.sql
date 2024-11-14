-- Script Name: SQL_Queries_For_Tables_And_Updates

/*Explanation of Commands Used

- **CREATE TABLE**: Creates new tables with defined columns.
- **PRIMARY KEY**: Defines the primary key for the table, ensuring uniqueness.
- **FOREIGN KEY**: Sets a relationship between columns from different tables.
- **INSERT INTO**: Adds new rows of data into a table.
- **SELECT INTO**: Copies data into a new table from an existing table.
- **UPDATE**: Modifies existing records in a table based on a condition.
- **SET SQL_SAFE_UPDATES**: Disables safety checks for updating data.
- **SELECT**: Retrieves data from a table.
- **WHERE**: Filters records based on specific conditions.

This script demonstrates how to create tables, insert data, and update records. It includes operations like creating new classes, games, and managing relationships between them using foreign keys.

*/

-- Creating table for new class and levels
CREATE TABLE new_class(
    id_Level int,
    id_class int,
    description varchar(50),
    PRIMARY KEY (id_class, id_level)
);

-- Creating table for new levels of games
CREATE TABLE new_level_game(
    id_Level int,
    description varchar(50)
);

-- Inserting values into new_class table
INSERT INTO new_class (id_level, id_class, description) 
VALUES 
(17, 10, 'Adventure Other'),
(15, 1, 'Spy Other'),
(17, 20, 'British Comedy'),
(17, 30, 'Adventure'),
(14, 1, ''),
(18, 1, '');

-- Inserting values into new_level_game table, selecting distinct levels not in level_game
INSERT INTO new_level_game (id_level, description)
(
    SELECT DISTINCT id_level, 'New level' 
    FROM new_class 
    WHERE id_level NOT IN (
        SELECT id_level 
        FROM level_game
    )
);

-- Creating a table to store incomplete plays
CREATE TABLE PLAY_INCOMPLETED AS
SELECT * FROM play WHERE play.completed = 0;

-- Selecting data from PLAY_INCOMPLETED
SELECT * FROM PLAY_INCOMPLETED;

-- Updating new_class table, setting id_level to 20 for certain levels
UPDATE new_class
SET id_level = 20
WHERE id_level IN (
    SELECT id_level FROM new_level_game
);

-- Selecting updated data from new_class
SELECT * FROM new_class;

-- Creating table for advertisement games
CREATE TABLE advergame(
    id_Level int,
    id_class int,
    description varchar(50)
);

-- Creating GAME_NEW table with foreign key relationship to CLASS
CREATE TABLE `GAME_NEW` (
  `id_game` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `id_level` int NOT NULL,
  `id_class` int NOT NULL,
  PRIMARY KEY (`id_game`),
  KEY `GAME_CLASS` (`id_class`, `id_level`),
  CONSTRAINT `GAME_CLASS_NEW` FOREIGN KEY (`id_class`, `id_level`) REFERENCES `CLASS` (`id_class`, `id_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting data into GAME_NEW table from the GAME table where commentary date is after '2021-01-01'
INSERT INTO GAME_NEW (id_game, name, description, id_level, id_class)
(
    SELECT id_game, name, description, id_level, id_class 
    FROM GAME G 
    WHERE id_game IN (
        SELECT id_game 
        FROM COMMENTARY 
        WHERE comment_date > '2021-01-01'
    )
);

-- Selecting data from the GAME_NEW table
SELECT * FROM game_new;

-- Creating game_new2 table, filtering based on commentaries after '2021-01-01'
CREATE TABLE game_new2 AS 
SELECT * 
FROM game 
WHERE id_game IN (
    SELECT id_game 
    FROM commentary 
    WHERE comment_date > '2021-01-01'
);

-- Updating GAME_NEW table with descriptions from the CLASS table based on matching id_class and id_level
UPDATE game_new gn
SET description = (
    SELECT description 
    FROM class 
    WHERE id_class = gn.id_class 
    AND id_level = gn.id_level
);

-- Disabling SQL safe updates and updating descriptions again
SET SQL_SAFE_UPDATES = 0;

UPDATE GAME_NEW GN 
SET description = (
    SELECT description 
    FROM CLASS 
    WHERE id_class = GN.id_class 
    AND id_level = GN.id_level
);

-- Selecting data from various tables to verify changes
SELECT * FROM game_new;
SELECT * FROM game;
SELECT * FROM class;
SELECT * FROM commentary;
