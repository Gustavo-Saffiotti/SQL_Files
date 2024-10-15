CREATE TABLE brands (
    brand_id INT PRIMARY KEY,       -- Chave primária para o identificador da marca
    brand_name VARCHAR(50)          -- Nome da marca
);

-- Criar a tabela products com chave estrangeira para brands
CREATE TABLE products (
    product_id INT PRIMARY KEY,     -- Chave primária para o identificador do produto
    product_name VARCHAR(50),       -- Nome do produto
    category_id INT,                -- Identificador da categoria
    brand_id INT,                   -- Identificador da marca (chave estrangeira)
    model_year INT,                 -- Ano do modelo do produto
    list_price DOUBLE,              -- Preço de lista do produto
    FOREIGN KEY (brand_id)          -- Definição da chave estrangeira
        REFERENCES brands(brand_id) -- Referencia brand_id da tabela brands
);


describe brands 
select *from products
describe products 
ALTER TABLE products DROP FOREIGN KEY brand_id;


ALTER TABLE brands DROP PRIMARY KEY;

describe products

ALTER TABLE products DROP FOREIGN key

ALTER TABLE products DROP INDEX brand_id;

show create table products 

ALTER TABLE brands ADD PRIMARY KEY (brand_id);

ALTER TABLE products
ADD CONSTRAINT fk_brand
FOREIGN KEY (brand_id) REFERENCES brands(brand_id);





