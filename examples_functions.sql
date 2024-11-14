/* Explanation of Commands Used

- **CREATE FUNCTION**: Used to define a new function in SQL. It specifies input parameters, the return type, and the logic within the function.
  
- **DETERMINISTIC**: Indicates that the function will return the same result for the same input values, making it suitable for optimization by the database.
  
- **NO SQL**: Specifies that the function doesn't contain any SQL queries that modify data.
  
- **SELECT INTO**: This syntax is used to retrieve data and store the result into a variable.

- **DECLARE**: Declares local variables to be used within the function.

- **JOIN**: Combines data from two or more tables based on a related column between them.

- **RETURN**: Specifies the value that the function will return.

*/


-- 1. Basic Function Example: Multiplies two numbers
CREATE FUNCTION nome_da_funcao (param1 INT, param2 INT) RETURNS CHAR(60)
DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    SET resultado = (param1 * param2);
    RETURN resultado;
END;

-- 2. Function for Calculating Liters of Paint
CREATE FUNCTION calcular_litros_de_tinta (largura INT, altura INT, total_demaos INT) RETURNS FLOAT
NO SQL
BEGIN
    DECLARE resultado FLOAT;
    DECLARE litro_x_m2 FLOAT;
    SET litro_x_m2 = 0.10;
    SET resultado = ((largura * altura) * total_demaos) * litro_x_m2;
    RETURN resultado;
END;

-- 3. Using the Paint Calculation Function
SELECT calcular_litros_de_tinta(22, 5, 3) AS total_tinta;

-- 4. Function to Retrieve Game Name by Game ID
CREATE FUNCTION get_game(id_game INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE game_name VARCHAR(100);
    
    -- Get the game name from the id_game
    SELECT name INTO game_name
    FROM game
    WHERE game.id_game = id_game;

    -- Return the game name
    RETURN game_name;
END;

-- 5. Using the get_game Function
SELECT get_game(5) AS name;

-- 6. Function to Retrieve Product Name from Order ID with JOIN
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

    -- Return the product name
    RETURN nome_produto;
END;
$$

-- 7. Example: Count Games by Level
CREATE FUNCTION count_games_by_level (p_id_level INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE game_count INT;
    -- Count the number of games at a specific level
    SELECT COUNT(*) INTO game_count
    FROM game 
    WHERE id_level = p_id_level;

    -- Return the count of games
    RETURN game_count;
END;

-- 8. Example: Filter by Game Name
CREATE FUNCTION filtro (param1 INT)
RETURNS varchar(40)
DETERMINISTIC
BEGIN
    DECLARE resultado varchar(40);
    SELECT name INTO resultado
    FROM game
    WHERE id_game = param1;

    -- Return the game name
    RETURN resultado;
END;

-- Example Queries to Test the Functions:

-- Retrieve game name for game with ID 5
SELECT get_game(5) AS name;

-- Count number of games at level 1
SELECT count_games_by_level(1) AS games_at_level_1;

-- Get product name for order ID 100
SELECT obtem_nome_produto(100) AS product_name;

-- Use the filtro function to get the game name for game ID 73
SELECT filtro(73) AS game_name;

-- Calculate the total liters of paint required for a wall with dimensions 22x5 meters and 3 coats
SELECT calcular_litros_de_tinta(22, 5, 3) AS total_tinta;