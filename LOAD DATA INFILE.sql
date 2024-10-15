CREATE TABLE produtos (
id int NOT NULL AUTO_INCREMENT, 
nome varchar(40) NOT NULL, 
existencia int NOT NULL DEFAULT '0', 
preco float NOT NULL DEFAULT '0', 
preco_compra float NOT NULL DEFAULT '0', 
PRIMARY KEY (id)
);



use gammers_model;
show tables;
explain produtos;





SELECT * 
INTO OUTFILE '/caminho/do/arquivo.csv'
FIELDS TERMINATED BY ','  -- Define o separador de campos
OPTIONALLY ENCLOSED BY '"'  -- Define se as strings estarão entre aspas
LINES TERMINATED BY '\n'  -- Define o final de linha
FROM nome_da_tabela;



SET GLOBAL local_infile=1;
SHOW VARIABLES LIKE 'secure_file_priv';


LOAD DATA LOCAL INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Productos (mod).csv'
INTO TABLE produtos
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n';


select * from produtos


truncate table produtos



