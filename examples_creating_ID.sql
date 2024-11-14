/*Explanation of Commands Used

- **CREATE TABLE**: Defines new tables in the database and specifies the columns, data types, and constraints.
- **ROW_NUMBER() OVER (ORDER BY ...)**: A window function that assigns a unique number to each row within the result set, based on the order specified by the `ORDER BY` clause. In this case, it’s used to generate a unique ID for each customer.
- **DISTINCT**: Removes duplicate rows from the result set. Used in this case to ensure that only unique combinations of customer names and phone numbers are inserted into the `dim_customer` table.
- **INSERT INTO**: Adds new rows of data into an existing table.

This script creates and populates two tables: `fact_sales` to store sales data and `dim_customer` to store unique customer details. It also creates the `hosts` table and establishes a foreign key relationship with the `listings` table (assuming `listings` exists in your database). Additionally, customer IDs are generated using the `ROW_NUMBER()` function to ensure each customer has a unique identifier.

*/


-- Create the fact_sales table
CREATE TABLE fact_sales (
    sale_id INT PRIMARY KEY,  -- Unique identifier for each sale
    nome VARCHAR(100),  -- Customer's name
    telefone VARCHAR(20),  -- Customer's phone number
    produto VARCHAR(100),  -- Product sold
    quantidade INT,  -- Quantity of products sold
    valor DECIMAL(10, 2)  -- Value of the sale
);

-- Insert data into fact_sales table
INSERT INTO fact_sales (sale_id, nome, telefone, produto, quantidade, valor)
VALUES
(1, 'Alice', '123456789', 'Laptop', 1, 1000.00),
(2, 'Bob', '987654321', 'Phone', 2, 500.00),
(3, 'Alice', '123456789', 'Tablet', 1, 300.00);

-- Create the dim_customer table to store unique customer data
CREATE TABLE dim_customer AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY nome, telefone) AS id_cliente,  -- Generate a unique ID for each customer
    nome, 
    telefone
FROM 
    (SELECT DISTINCT nome, telefone FROM fact_sales) AS unique_customers;

-- Selecting all data from dim_customer and fact_sales
SELECT * FROM dim_customer dc;
SELECT * FROM fact_sales fs;

