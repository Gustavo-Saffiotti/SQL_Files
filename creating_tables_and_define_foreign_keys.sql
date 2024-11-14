/*Explanation of Commands Used

- CREATE TABLE: Creates tables with defined columns to store data and define relationships.
- PRIMARY KEY: Uniquely identifies each record in the table.
- FOREIGN KEY: Establishes a relationship between two tables; can be configured with ON DELETE CASCADE, ON UPDATE CASCADE, or ON DELETE SET NULL to control behavior when deleting or updating records.
- AUTO_INCREMENT: Automatically generates a unique, sequential value, useful for primary keys.
- UNIQUE: Ensures the values in a column are unique within the table.
- ALTER TABLE: Used to modify the structure of a table, such as adding constraints or foreign keys.
- JOIN: Connects data from two tables to display related information between them.CREATE TABLE PAIS (

*/


-- Creating tables and defining primary keys

-- 'COUNTRY' table
CREATE TABLE COUNTRY (
    country_id INT PRIMARY KEY,      -- Primary key for unique identification of each country
    country_name VARCHAR(50)         -- Country name with a 50-character limit
);

-- 'PERSON' table
CREATE TABLE PERSON (
    person_id INT PRIMARY KEY,       -- Primary key for unique identification of each person
    full_name VARCHAR(60),           -- Full name of the person with a 60-character limit
    country_id INT                   -- Foreign key referencing the COUNTRY table
);

-- Adding foreign key constraints for the 'PERSON' table

-- Foreign key constraint for DELETE CASCADE
ALTER TABLE PERSON 
ADD CONSTRAINT fk_country_id 
FOREIGN KEY (country_id) REFERENCES COUNTRY(country_id) 
ON DELETE CASCADE; -- If a country is deleted, all associated persons will also be removed.

-- Foreign key constraint for UPDATE CASCADE
ALTER TABLE PERSON 
ADD CONSTRAINT fk_country_id_update 
FOREIGN KEY (country_id) REFERENCES COUNTRY(country_id) 
ON UPDATE CASCADE; -- If a country ID is updated, all related records in 'PERSON' will be updated.

-- Foreign key constraint for SET NULL
ALTER TABLE PERSON 
ADD CONSTRAINT fk_country_id_set_null 
FOREIGN KEY (country_id) REFERENCES COUNTRY(country_id) 
ON DELETE SET NULL; -- If a country is deleted, the country_id field for associated persons will be set to NULL.

-- Inserting data into tables

-- Inserting data into the 'COUNTRY' table
INSERT INTO COUNTRY (country_id, country_name)
VALUES 
    (1, 'SPAIN'),
    (2, 'ITALY'),
    (3, 'ARGENTINA'),
    (4, 'ALBANIA'),
    (5, 'BRAZIL');

-- Inserting data into the 'PERSON' table
INSERT INTO PERSON (person_id, full_name, country_id)
VALUES 
    (1, 'Fernando Omar', 3),
    (2, 'Julian Conte', 3),
    (3, 'Nicolas Mariano', 1),
    (4, 'Laura Grisel', 2),
    (5, 'Constantino Pascual', 4);

-- Example of delete with CASCADE effect
DELETE FROM COUNTRY WHERE country_id = 3; -- Deletes country with ID 3 and all associated persons.

-- Reinserting data into the 'COUNTRY' table for the example
INSERT INTO COUNTRY (country_id, country_name)
VALUES 
    (1, 'SPAIN'),
    (2, 'ITALY'),
    (3, 'ARGENTINA'),
    (4, 'ALBANIA'),
    (5, 'BRAZIL');

-- Example of creating a table with primary key, auto-increment, and unique constraint

-- 'STUDENT' table
CREATE TABLE STUDENT (
    student_id INT auto_increment PRIMARY KEY, -- Unique identifier with auto-increment
    age INT,                                   -- Student age
    student_doc VARCHAR(15) UNIQUE             -- Unique student document number
);

-- Queries to check the contents of the tables
SELECT * FROM PERSON;
SELECT * FROM COUNTRY;










