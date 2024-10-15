
Tipo de dado Date ou DateTime
#SQL atua da mesma forma com os dados provenientes de datas e/ou horas. Para mencioná-los dentro de um operador de comparação, devemos utilizar as mesmas aspas simples que para os dados do tipo String.

#Todos os comentários sobre jogos de 2019 em diante.
SELECT *
FROM commentary
WHERE comment_date >= '2019-01-01'
order by comment_date;

#Todos os comentários sobre jogos anteriores a 2011.
SELECT *
FROM commentary
WHERE comment_date < '2011/01/01'
order BY comment_date DESC;

#Os usuários e o texto dos comentários sobre jogos cujo código de jogo (id_game) seja 73
SELECT 
id_game,
id_system_user,
commentary
FROM commentary
WHERE id_game = 73;

#Os usuários e o texto dos comentários sobre jogos cujo id de jogo não seja 73.
SELECT 
id_game,
id_system_user,
commentary
FROM commentary
WHERE id_game != 73;

#Os jogos de nível 1.
SELECT *
FROM game
WHERE id_level = 1

#Os jogos que sejam nível 14 ou superior.
SELECT *
FROM game
WHERE id_level >= 14

#Os jogos de nome 'Riders Republic’ ou 'The Dark Pictures: House Of Ashes'.

SELECT * 
FROM game
WHERE name IN ('Riders Republic', 'The Dark Pictures: House Of Ashes');

#Os jogos cujo nome comece com 'Grande'.
SELECT *
FROM game 
WHERE name like 'Grand%';

#Os jogos cujo nome contenha 'field'.
SELECT *
FROM game
WHERE name like '%field%';







