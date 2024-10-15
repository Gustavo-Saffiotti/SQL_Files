create DATABASE teste2;
use TESTE2;
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15)
);
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE itens_pedido (
    id_item_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    produto VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);



show create table clientes 
select * from pedidos


ALTER TABLE pedidos
ADD PRIMARY KEY (id_pedido);

ALTER TABLE pedidos 
DROP FOREIGN KEY pedidos_ibfk_1;

ALTER TABLE pedidos DROP PRIMARY KEY;

ALTER TABLE pedidos MODIFY COLUMN id_pedido INT;

SHOW INDEX FROM itens_pedido;

DROP INDEX id_pedido ON itens_pedido;


ALTER TABLE clientes 
ADD PRIMARY KEY (id_cliente)

ALTER TABLE itens_pedido 
ADD PRIMARY KEY (id_item_pedido)

ALTER TABLE pedidos 
ADD PRIMARY KEY (id_pedido)




describe
show create table



ALTER TABLE itens_pedido ADD CONSTRAINT fk_itenspedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido);

ALTER TABLE pedidos ADD CONSTRAINT fk_pedidos FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);



SELECT DISTINCT coluna1
FROM tabela;

ALTER TABLE tabela
ADD CONSTRAINT nome_constraint UNIQUE (coluna1);