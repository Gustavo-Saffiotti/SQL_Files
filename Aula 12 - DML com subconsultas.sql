CREATE TABLE new_class(
id_Level int,
id_class int,
description varchar(50))
primary key (id_class,id_level;


create table new_level_game(
id_Level int,
description varchar(50));




INSERT INTO new_class (id_level, id_class, description) VALUES 
(17, 10, 'Adventure Other'),
(15, 1, 'Spy Other'),
(17, 20, 'British Comedy'),
(17, 30, 'Adventure'),
(14, 1, ''),
(18, 1, '');






INSERT INTO new_level_game (id_level, description)  
(
SELECT DISTINCT id_level, 'New level' 
FROM new_class 
WHERE id_level NOT IN (
                   SELECT id_level 
				  FROM level_game)
);



CREATE TABLE PLAY_INCOMPLETED
(SELECT * FROM play WHERE play.completed = 0);




SELECT * from PLAY_INCOMPLETED


UPDATE new_class
SET id_level = 20
WHERE id_level in (
	SELECT id_level FROM new_level_game);

select*from new_class




create table advergame(
id_Level int,
id_class int,
description varchar(50));



-- EXEMPLO PROFESSOR


CREATE TABLE `GAME_NEW` (
  `id_game` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `id_level` int NOT NULL,
  `id_class` int NOT NULL,
  PRIMARY KEY (`id_game`),
  KEY `GAME_CLASS` (`id_class`,`id_level`),
  CONSTRAINT `GAME_CLASS_NEW` FOREIGN KEY (`id_class`, `id_level`) REFERENCES `CLASS` (`id_class`, `id_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO GAME_NEW (id_game,name,description,id_level,id_class) 
(SELECT id_game,name,description,id_level,id_class FROM GAME G WHERE id_game in 
(select id_game from COMMENTARY where comment_date > '2021-01-01'))


select * from game_new



create table game_new2 ( 
	select * 
	from game 
	where id_game in (	
		select id_game 
		from commentary 
		where comment_date >'2021-01-01')
		
		
		
		

		
		
		
update game_new gn set description = (
	select description 
	from class 
	where id_class = gn.id_class and id_level = gn.id_level)

	
SET SQL_SAFE_UPDATES = 0;



	UPDATE GAME_NEW GN SET description = 
	(select description 
	from CLASS 
	where id_class = GN.id_class and id_level = GN.id_level)
	
	
	
select * from game_new
select * from game
select * from class c
select * from commentary c 












