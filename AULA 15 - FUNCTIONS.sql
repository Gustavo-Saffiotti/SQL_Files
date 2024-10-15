--- EXAMPLE : FUNCTION

CREATE FUNCTION `nome_da_funcao` (param1 INT, param2 INT) RETURNS CHAR(60)
DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    SET resultado = (param1 * param2);
    RETURN resultado;
END



--- EXAMPLE : FUNCTION

CREATE FUNCTION `calcular_litros_de_tinta` (largura INT, altura INT, total_demaos INT) RETURNS FLOAT
NO SQL
BEGIN
    	DECLARE resultado FLOAT;
    	DECLARE litro_x_m2 FLOAT;
	SET litro_x_m2 = 0.10;
	SET resultado = ((largura * altura) * total_demaos) * litro_x_m2;
RETURN resultado;
END





SELECT calcular_litros_de_tinta(22, 5, 3) AS total_tinta;




--- FUNCTION WITH SELECT
CREATE FUNCTION get_game(id_game INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE game_name VARCHAR(100);
    
    -- Obter o nome do jogo a partir do id_game
    SELECT name INTO game_name
    FROM game
    WHERE game.id_game = id_game;

    -- Retornar o nome do jogo
    RETURN game_name;
END;





select * from game

select get_game(5) as name




--- FUNCTION WITH JOIN
CREATE OR REPLACE FUNCTION obtem_nome_produto(order_id INT)
RETURNS TEXT AS $$
DECLARE
    nome_produto TEXT;
BEGIN
    SELECT p.product_name
    INTO nome_produto
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE o.order_id = order_id;

    RETURN nome_produto;
END;
$$




--- EXAMPLE PROF

CREATE FUNCTION count_games_by_level (p_id_level INT)
RETURNS INT
DETERMINISTIC
BEGIN
	
	DECLARE game_count INT;
	-- Conta o número de jogos em um determinado nível
	SELECT COUNT(*) INTO game_count
	FROM game 
	WHERE id_level = p_id_level;
-- Retorna o número de jogos
RETURN game_count;

END





--- EXAMPLE PROF - 2

create function filtro (param1 INT)
returns varchar(40)
deterministic
begin
declare resultado varchar(40);
select name into resultado
from game
where id_game = param1;

return resultado;
end



