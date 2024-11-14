/* Explanation of Commands Used

- CREATE DATABASE: Creates a new database where tables and data can be stored.
- USE: Selects the specified database for use in the subsequent commands.
- CREATE TABLE: Defines a new table with specified columns and constraints.
- PRIMARY KEY: A unique identifier for each record in the table.
- AUTO_INCREMENT: Automatically generates a unique, sequential value, useful for primary keys.
- FOREIGN KEY: Establishes a relationship between two tables; can be configured to enforce referential integrity with constraints like ON DELETE CASCADE or ON UPDATE CASCADE.
- UNIQUE: Ensures the values in a column are unique within the table.
- ALTER TABLE: Modifies an existing table, allowing the addition or removal of constraints and columns.
- SHOW CREATE TABLE: Displays the SQL command used to create a specified table, showing its structure.
- SELECT: Retrieves data from a table.
- DROP FOREIGN KEY: Removes a foreign key constraint from a table.
- MODIFY COLUMN: Changes the definition of an existing column in the table.
- SHOW INDEX: Lists indexes for a specified table, providing information on unique and primary keys.
- DROP INDEX: Removes an index from a table.
- ADD CONSTRAINT: Adds a specified constraint to enforce rules like uniqueness and referential integrity.
- DISTINCT: Selects unique values from a specified column.
*/

/* Database and Table Creation */
CREATE DATABASE teste2;
USE teste2;

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

/* Viewing Table Structure and Data */
SHOW CREATE TABLE clientes;
SELECT * FROM pedidos;

/* Alterations on Tables */
ALTER TABLE pedidos DROP FOREIGN KEY pedidos_ibfk_1;
ALTER TABLE pedidos DROP PRIMARY KEY;
ALTER TABLE pedidos MODIFY COLUMN id_pedido INT;

SHOW INDEX FROM itens_pedido;
DROP INDEX id_pedido ON itens_pedido;

/* Adding Primary Keys and Foreign Keys Again */
ALTER TABLE clientes ADD PRIMARY KEY (id_cliente);
ALTER TABLE itens_pedido ADD PRIMARY KEY (id_item_pedido);
ALTER TABLE pedidos ADD PRIMARY KEY (id_pedido);

/* Adding Constraints for Foreign Keys */
ALTER TABLE itens_pedido 
ADD CONSTRAINT fk_itenspedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido);

ALTER TABLE pedidos 
ADD CONSTRAINT fk_pedidos FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);

/* Query and Unique Constraint */
SELECT DISTINCT coluna1 FROM tabela;
ALTER TABLE tabela ADD CONSTRAINT nome_constraint UNIQUE (coluna1);