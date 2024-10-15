select * from athletes24 a 




CREATE TABLE dim_customer AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY nome, telefone) AS id_cliente,  -- Gera um ID único para cada cliente
    nome, 
    telefone
FROM 
    (SELECT DISTINCT nome, telefone FROM fact_sales) AS unique_customers;
    
   
   
   
   -- Criar a tabela de vendas fact_sales
CREATE TABLE fact_sales (
    sale_id INT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20),
    produto VARCHAR(100),
    quantidade INT,
    valor DECIMAL(10, 2)
);

-- Inserir dados na tabela fact_sales
INSERT INTO fact_sales (sale_id, nome, telefone, produto, quantidade, valor)
VALUES
(1, 'Alice', '123456789', 'Laptop', 1, 1000.00),
(2, 'Bob', '987654321', 'Phone', 2, 500.00),
(3, 'Alice', '123456789', 'Tablet', 1, 300.00);




-- Criar a tabela de clientes únicos dim_customer com um ID gerado automaticamente
CREATE TABLE dim_customer AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY nome, telefone) AS id_cliente,  -- Gera um ID único para cada cliente
    nome, 
    telefone
FROM 
    (SELECT DISTINCT nome, telefone FROM fact_sales) AS unique_customers;

   
select * from dim_customer dc 
select * from fact_sales fs 


CREATE TABLE hosts (
    host_id INT PRIMARY KEY,
    host_name VARCHAR(100),
    host_contact VARCHAR(100),
    listing_id INT);
    FOREIGN KEY (listing_id) REFERENCES listings(id)
);