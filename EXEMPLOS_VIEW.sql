select 
su.id_system_user, 
su.first_name, 
co.id_game,
com.commentary 
from `system_user`su
left join comment co
on su.id_system_user = co.id_system_user
left join commentary com
on com.id_game = co.id_game

create view vw_commentary as
select su.id_system_user,
su.first_name,
co.id_game,
com.commentary
from `system_user`su
left join comment co
on su.id_system_user = co.id_system_user
left join commentary com
on com.id_game = com.id_game

select *
from vw_commentary vc 

create view apagar_dados1 as
select *
from dim_customer dc 



alter table dim_customer drop column id_cliente;

select *
from nome_view



create or replace view vw_id_level as
select
p.*,
g.id_level 
from play p 
left join game g on p.id_game = g.id_game


select
* 
from vw_id_level vw
left join level_game lg on vw.id_level = lg.id_level 




-- que mostre first_name e last_name dos usuários que tenham e-mail ‘webnode.com’;
create view first_question as
select 
su.first_name ,
su.last_name
from `system_user` su
where su.email like '%webnode.com%';


select *from first_question


-- que mostre todos os dados dos jogos que tenham sido finalizados;



select *from play p
where p.completed = 1

create view second_question as
select
g.id_game,
g.name,
g.description
from game g 
where id_game in (
	select distinct p.id_game
	from play p
	where p.completed = 1)
	
select *from second_question



-- que mostre os diferentes jogos que tiveram uma votação maior que 9;

select * from vote

select
g.id_game,
g.name,
g.description
from game g 
where id_game in (
	select distinct v.id_game
	from vote v
	where v.value >= 9)
	
	
-- que mostre nome, sobrenome e e-mail dos usuários que jogam o jogo FIFA 22.
create view name_players_fifa as
select 
su.first_name ,
su.last_name ,
su.email
from `system_user` su 
where su.id_system_user in (
	select p.id_system_user	from play p
	where p.id_game in (
		select g.id_game from game g 
		where g.name like '%Fifa 22%')
)

select * from name_players_fifa

---------------------------------------------------------------------------------------------

-- Mostrar first_name e last_name dos usuários que tenham e-mail ‘webnode.com’;
CREATE VIEW name_email_webnode AS
SELECT 
    su.first_name,
    su.last_name
FROM `system_user` su
WHERE su.email LIKE '%webnode.com%';

SELECT * FROM name_email_webnode;

-- Mostrar todos os dados dos jogos que tenham sido finalizados;
CREATE VIEW games_finalized AS
SELECT 
    g.id_game,
    g.name,
    g.description
FROM game g
WHERE g.id_game IN (
    SELECT DISTINCT p.id_game
    FROM play p
    WHERE p.completed = 1
);

SELECT * FROM games_finalized;

-- Mostrar os diferentes jogos que tiveram uma votação maior que 9;

CREATE VIEW high_rated_games AS
SELECT 
    g.id_game,
    g.name,
    g.description
FROM game g
WHERE g.id_game IN (
    SELECT DISTINCT v.id_game
    FROM vote v
    WHERE v.value >= 9
);

select * from high_rated_games


-- Mostrar nome, sobrenome e e-mail dos usuários que jogam o jogo FIFA 22;
CREATE VIEW names_players_fifa AS
SELECT 
    su.first_name,
    su.last_name,
    su.email
FROM `system_user` su 
WHERE su.id_system_user IN (
    SELECT p.id_system_user 
    FROM play p
    WHERE p.id_game IN (
        SELECT g.id_game 
        FROM game g 
        WHERE g.name LIKE '%Fifa 22%'
    )
);

SELECT * FROM names_players_fifa;


create view vwvote9_1 as
select distinct g.id_game, g.name, g.description
from game g join vote v on (g.id_game = v.id_game)
where v.value >= 9;

select * from vwvote9_1 v 


se bike;

-- 1) Pedidos por dia
create view pedidos_dia as
(select order_date, count(*) as 'Quantidade_Pedidos' from orders group by order_date);


select * from pedidos_dia;


-- 2) Estoque por Produto
create view estoque_produto as
(select 
products.product_name,
stocks.quantity 
from products 
inner join stocks
on products.product_id = stocks.product_id);


select * from estoque_produto;

-- 3) Vendas por região
CREATE VIEW VendasPorRegiao AS
SELECT 
    c.city, 
    c.state, 
    SUM(oi.quantity * oi.list_price) AS total_vendas
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.city, c.state
ORDER BY total_vendas DESC;


select * from vendasporregiao;




-- 4) Vendas totais por ano, segmentadas por categoria
CREATE VIEW VendasPorCategoriaAnual as
SELECT 
    YEAR(order_date) AS ano, 
    c.category_name AS categoria, 
    SUM(oi.quantity * oi.list_price) AS total_vendas
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY YEAR(order_date), c.category_name;

select * from vendasporcategoriaanual;

-- 5) Clientes com mais compras
CREATE VIEW TopClientes AS
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(o.order_id) AS total_pedidos, 
    SUM(oi.quantity) AS total_produtos
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_produtos DESC;
select * from topclientes;

-- 6) Pedidos por funcionári
create or replace view pedidos_funcionario as
(SELECT 
    YEAR(order_date) AS ano,
    MONTH(order_date) AS mes,
    staffs.first_name,
    staffs.last_name,
    COUNT(*) AS total_pedidos
FROM 
    orders
INNER JOIN 
    staffs ON orders.staff_id = staffs.staff_id
GROUP BY 
    ano, mes, staffs.first_name, staffs.last_name
ORDER BY 
    ano, mes, staffs.first_name, staffs.last_name);


select * from pedidos_funcionario;


use bike_store;

--1) Pedidos por dia--
create view pedidos_dia as
(select order_date, count(*) as 'Quantidade_Pedidos' from orders group by order_date);


select * from pedidos_dia;

--2) Estoque por Produto--
create view estoque_produto as
(select 
products.product_name,
stocks.quantity 
from products 
inner join stocks
on products.product_id = stocks.product_id);

select * from estoque_produto;

--3) Pedidos por Funcionário--
create or replace view pedidos_funcionario as
(SELECT 
    YEAR(order_date) AS ano,
    MONTH(order_date) AS mes,
    staffs.first_name,
    staffs.last_name,
    COUNT(*) AS total_pedidos
FROM 
    orders
INNER JOIN 
    staffs ON orders.staff_id = staffs.staff_id
GROUP BY 
    ano, mes, staffs.first_name, staffs.last_name
ORDER BY 
    ano, mes, staffs.first_name, staffs.last_name);

select * from pedidos_funcionario;

--4) Pedidos por CLiente--
create view pedidos_clientes as
(SELECT 
    o.customer_id, 
    COUNT(*) AS quantidade_pedido,
    c.first_name, 
    c.last_name
FROM 
    orders o
INNER JOIN 
    customers c ON o.customer_id = c.customer_id
GROUP BY 
    o.customer_id, c.first_name, c.last_name
order by
quantidade_pedido desc);


select * from pedidos_clientes;

--5) Pedidos por Estado--
create view pedidos_estado as
(select
    c.state,
    COUNT(*) AS qts_pedido_estado
FROM
    orders o
INNER JOIN 
    customers c ON o.customer_id = c.customer_id
GROUP BY 
    c.state
order by
    c. state desc);


select * from pedidos_estado;

--6) Receita por Loja--
create view receita_loja as
(SELECT 
    YEAR(o.order_date) AS ano,
    MONTH(o.order_date) AS mes,
    s.store_name,
    SUM(oi.list_price * oi.quantity) AS receita_total
FROM 
    orders o
INNER JOIN 
    order_items oi ON o.order_id = oi.order_id
INNER JOIN 
    stores s ON o.store_id = s.store_id
GROUP BY 
    YEAR(o.order_date), MONTH(o.order_date), s.store_name
ORDER BY 
    ano, mes, s.store_name);
   
select * from receita_loja;





	
