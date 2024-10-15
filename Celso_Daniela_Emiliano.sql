CREATE DATABASE Celso_Daniela_Emiliano;

use Celso_Daniela_Emiliano;


SCRIPT DE CRIAÇÃO DAS TABELAS
use credit;
CREATE TABLE tabela_fato (
id VARCHAR(30) NOT NULL,
id_default varchar (30),
idade INT,
genero varchar(30),
dependentes INT,
escolaridade varchar(30),
estado_civil varchar(30),
salario_anual VARCHAR(30),
tipo_cartao varchar(30),
meses_de_relacionamento INT,
qtd_produtos INT,
iteracoes_12m INT,
meses_inativo_12m INT,
limite_credito FLOAT,
valor_transacoes_12m FLOAT,
qtd_transacoes_12m INT,
c
onstraint PK_id PRIMARY KEY (id)
);
create table inadimplente (
id_default varchar(30) not null,
desc_default varchar (50),
constraint PK_id_default primary key (id_default)
);


create table genero (
id_genero varchar (30) not null,
genero_sigla varchar (50),
desc_genero varchar (50),
constraint PK_genero primary key (id_genero)
);
create table escolaridade (
id_escolaridade varchar (30) not null,
desc_escolaridade varchar (50),
constraint PK_escolaridade primary key (id_escolar
idade)
);
create table estado_civil (
id_estado_civil varchar (30) not null,
estado_civil_desc varchar (50),
constraint PK_estado_civil primary key (id_estado_civil)
);
create table tipo_cartao (
id_tipo_cartao varchar (30) not null,
cartao_desc varchar (50),
constraint PK_tipo_cartao primary key (id_tipo_cartao)
);
--
Adiciona chave estrangeira para a coluna 'id_default' referenciando a tabela
'inadimplente'
ALTER TABLE tabela_fato
ADD CONSTRAINT fk_nao_pagou FOREIGN KEY (id_default) REFERENCES
inadimplente(id_default);


--
Adiciona chave estrangeira para a coluna 'sexo' referenciando a tabela 'genero'
ALTER TABLE tabela_fato
ADD CONSTRAINT fk_sexo FOREIGN KEY (sexo) REFERENCES gener
o(id_genero);
--
Adiciona chave estrangeira para a coluna 'escolaridade' referenciando a tabela
'escolaridade'
ALTER TABLE tabela_fato
ADD CONSTRAINT fk_escolaridade FOREIGN KEY (escolaridade) REFERENCES
escolaridade(id_escolaridade);
--
Adiciona chave e
strangeira para a coluna 'estado_civil' referenciando a tabela
'estado_civil'
ALTER TABLE tabela_fato
ADD CONSTRAINT fk_estado_civil FOREIGN KEY (estado_civil) REFERENCES
estado_civil(id_estado_civil);
--
Adiciona chave estrangeira para a coluna 'tipo_car
tao' referenciando a tabela
'tipo_cartao'
ALTER TABLE tabela_fato
ADD CONSTRAINT fk_tipo_cartao FOREIGN KEY (tipo_cartao) REFERENCES
tipo_cartao(id_tipo_cartao);





SCRIPT DE INSERÇÃO DE DADOS
load data infile 'C:\ProgramData\MySQL\MySQL Server 9.0\Uploads\tabela_fato.csv'
into table tabela_fato
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;
load data infile 'C:\ProgramData\MySQL\MySQL Server 9.0\Uploads\escolaridade.csv'
into table escolaridade
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;
load data infile 'C:\ProgramData\MySQL\MySQL Server 9.0\Uploads\dafault.csv'
into table inadimplente
fields terminated by ','
enclosed by
'"'
lines terminated by '\n'
ignore 1 rows;
load data infile 'C:\ProgramData\MySQL\MySQL Server 9.0\Uploads\tipo_cartao.csv'
into table tipo_cartao
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


load data infile 'C:\ProgramData\MySQL\MySQL Server 9.0\Uploads\genero.csv'
into table genero
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;
load data infile 'C:\ProgramData\MySQL\MySQL Server 9.0\Uploads\estado_civil.csv'
into table estado_civil
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;





















































