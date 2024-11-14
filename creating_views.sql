/*Explanation of Commands Used

- CREATE VIEW: Defines a view in the database, which is a virtual table based on the result of a SELECT query. Views are used to simplify complex queries, make them reusable, and encapsulate data logic.
- SELECT: Retrieves data from one or more tables or views based on specified conditions. It can also join multiple tables to present related information.
- LEFT JOIN: Combines rows from two tables based on a related column, returning all rows from the left table and matching rows from the right table, or NULL if there is no match.
- WHERE: Filters records based on specific conditions to narrow down the result set.
- GROUP BY: Groups rows that have the same values in specified columns into summary rows, often used with aggregate functions like SUM, COUNT, AVG, etc.
- SUM(): An aggregate function that calculates the total of a numeric column.
- COUNT(): An aggregate function that counts the number of rows that match the specified condition.
- ORDER BY: Sorts the result set in either ascending or descending order based on one or more columns.
- CREATE OR REPLACE VIEW: Creates a new view or replaces an existing view with a new definition.
This script creates multiple views to extract, manipulate, and aggregate data from various tables, such as system users, games, orders, and sales. These views allow for efficient querying and reporting on topics like game commentary, customer sales by region, order history, and more. Each view is designed to answer specific business questions, enabling better data analysis and decision-making.

*/



-- Creating a view to show system users with their game commentary
CREATE VIEW vw_commentary AS
SELECT 
    su.id_system_user, 
    su.first_name, 
    co.id_game,
    com.commentary
FROM system_user su
LEFT JOIN comment co
    ON su.id_system_user = co.id_system_user
LEFT JOIN commentary com
    ON com.id_game = co.id_game;

-- Displaying all data from the vw_commentary view
SELECT * 
FROM vw_commentary vc;

-- Creating a view to select all data from dim_customer
CREATE VIEW apagar_dados1 AS
SELECT *
FROM dim_customer dc;

-- Dropping the column 'id_cliente' from dim_customer
ALTER TABLE dim_customer 
DROP COLUMN id_cliente;

-- Creating a view to select data from the play table and join it with the game table
CREATE OR REPLACE VIEW vw_id_level AS
SELECT 
    p.*, 
    g.id_level 
FROM play p
LEFT JOIN game g 
    ON p.id_game = g.id_game;

-- Displaying data from vw_id_level and joining with level_game table
SELECT * 
FROM vw_id_level vw
LEFT JOIN level_game lg 
    ON vw.id_level = lg.id_level;

-- Creating a view to show first and last names of users with 'webnode.com' email
CREATE VIEW first_question AS
SELECT 
    su.first_name,
    su.last_name
FROM system_user su
WHERE su.email LIKE '%webnode.com%';

-- Displaying data from first_question view
SELECT * 
FROM first_question;

-- Creating a view to show all data from games that have been completed
CREATE VIEW second_question AS
SELECT 
    g.id_game,
    g.name,
    g.description
FROM game g 
WHERE id_game IN (
    SELECT DISTINCT p.id_game
    FROM play p
    WHERE p.completed = 1
);

-- Displaying data from second_question view
SELECT * 
FROM second_question;

-- Creating a view to show games that have received a rating greater than or equal to 9
CREATE VIEW high_rated_games AS
SELECT 
    g.id_game,
    g.name,
    g.description
FROM game g 
WHERE id_game IN (
    SELECT DISTINCT v.id_game
    FROM vote v
    WHERE v.value >= 9
);

-- Displaying data from high_rated_games view
SELECT * 
FROM high_rated_games;

-- Creating a view to show names, surnames, and emails of users who play FIFA 22
CREATE VIEW name_players_fifa AS
SELECT 
    su.first_name,
    su.last_name,
    su.email
FROM system_user su
WHERE su.id_system_user IN (
    SELECT p.id_system_user
    FROM play p
    WHERE p.id_game IN (
        SELECT g.id_game 
        FROM game g 
        WHERE g.name LIKE '%Fifa 22%'
    )
);

-- Displaying data from name_players_fifa view
SELECT * 
FROM name_players_fifa;

-- Creating a view to show sales by region (city and state)
CREATE VIEW VendasPorRegiao AS
SELECT 
    c.city, 
    c.state, 
    SUM(oi.quantity * oi.list_price) AS total_vendas
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY c.city, c.state
ORDER BY total_vendas DESC;

-- Displaying data from VendasPorRegiao view
SELECT * 
FROM VendasPorRegiao;

-- Creating a view to show sales by category for each year
CREATE VIEW VendasPorCategoriaAnual AS
SELECT 
    YEAR(order_date) AS ano, 
    c.category_name AS categoria, 
    SUM(oi.quantity * oi.list_price) AS total_vendas
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN products p 
    ON oi.product_id = p.product_id
JOIN categories c 
    ON p.category_id = c.category_id
GROUP BY YEAR(order_date), c.category_name;

-- Displaying data from VendasPorCategoriaAnual view
SELECT * 
FROM VendasPorCategoriaAnual;

-- Creating a view to show top customers by total orders and products purchased
CREATE VIEW TopClientes AS
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(o.order_id) AS total_pedidos, 
    SUM(oi.quantity) AS total_produtos
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_produtos DESC;

-- Displaying data from TopClientes view
SELECT * 
FROM TopClientes;

-- Creating a view to show orders by employee, grouped by year and month
CREATE OR REPLACE VIEW pedidos_funcionario AS
SELECT 
    YEAR(order_date) AS ano,
    MONTH(order_date) AS mes,
    staffs.first_name,
    staffs.last_name,
    COUNT(*) AS total_pedidos
FROM orders o
INNER JOIN staffs 
    ON orders.staff_id = staffs.staff_id
GROUP BY ano, mes, staffs.first_name, staffs.last_name
ORDER BY ano, mes, staffs.first_name, staffs.last_name;

-- Displaying data from pedidos_funcionario view
SELECT * 
FROM pedidos_funcionario;

-- Creating a view to show orders by customer
CREATE VIEW pedidos_clientes AS
SELECT 
    o.customer_id, 
    COUNT(*) AS quantidade_pedido,
    c.first_name, 
    c.last_name
FROM orders o
INNER JOIN customers c 
    ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.first_name, c.last_name
ORDER BY quantidade_pedido DESC;

-- Displaying data from pedidos_clientes view
SELECT * 
FROM pedidos_clientes;

-- Creating a view to show orders by state (grouped by customer state)
CREATE VIEW pedidos_estado AS
SELECT 
    c.state,
    COUNT(*) AS qts_pedido_estado
FROM orders o
INNER JOIN customers c 
    ON o.customer_id = c.customer_id
GROUP BY c.state
ORDER BY c.state DESC;

-- Displaying data from pedidos_estado view
SELECT * 
FROM pedidos_estado;

-- Creating a view to show total revenue by store (grouped by year and month)
CREATE VIEW receita_loja AS
SELECT 
    YEAR(o.order_date) AS ano,
    MONTH(o.order_date) AS mes,
    s.store_name,
    SUM(oi.list_price * oi.quantity) AS receita_total
FROM orders o
INNER JOIN order_items oi 
    ON o.order_id = oi.order_id
INNER JOIN stores s 
    ON o.store_id = s.store_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date), s.store_name
ORDER BY ano, mes, s.store_name;

-- Displaying data from receita_loja view
SELECT * 
FROM receita_loja;





	
