CREATE TABLE PAIS (
	pais_id INT PRIMARY KEY,
	nome_pais  VARCHAR(50)
);
CREATE TABLE PESSOA (
	pessoa_id INT PRIMARY KEY,
	nome_completo  VARCHAR(60),
	pais_id int
);



--- delete CASCADE
alter table pessoa add constraint fk_id_pais
foreign key (pais_id) references pais(pais_id) 
on delete cascade

--- update CASCADE
FOREIGN KEY (pais_id) REFERENCES pais(pais_id)
ON UPDATE cascade

--- set null 
alter table pessoa add constraint fk_id_pais
foreign key (pais_id) references pais(pais_id)
on delete set null





insert into PAIS(pais_id,nome_pais)
values (1,'ESPANHA'),
(2,'ITALIA'),
(3,'ARGENTINA'),
(4,'ALBANIA'),
(5,'BRASIL');


insert into pessoa(pessoa_id, nome_completo,pais_id)
values 
(1,'Fernando Omar',3),
(2,'Julian Conte',3),
(3,'Nicolas mariano',1),
(4,'Laura Grisel',2),
(5,'Constatino Pascual',4);

delete from pais where pais_id = 3;


insert into PAIS(pais_id,nome_pais)
values (1,'ESPANHA'),
(2,'ITALIA'),
(3,'ARGENTINA'),
(4,'ALBANIA'),
(5,'BRASIL');



CREATTE TABLE Aluno (
id_aluno auto_incrent primary key,
idade INT,
doc_aluno VARCHAR(15) UNIQUE
);


select * from pessoa

select * from pais






------ Exemplo professor

use aula13

create table conteudos (
id_curso int primary key,
curso varchar(20) not null unique);

create table alunos (
id_aluno int primary key,
id_curso int,
nome_aluno varchar (50) not null,
idade int not null)


select * from alunos;
select * from conteudos c ;


select
a.nome_aluno,
c.curso
from alunos a left join conteudos c
on a.id_curso = c.id_curso;


alter table alunos 
add constraint fk_curso -- Nome da restrição
foreign key (id_curso)  -- Coluna da tabela alunos para tornar FK
references conteudos (id_curso) -- Tabela e coluna referenciada


ALTER TABLE itens_pedido 
ADD CONSTRAINT fk_itenspedido 
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido);



insert into conteudos (id_curso, curso) 
values (1, 'Data Analytics'),
(2,'SQL'),
(3,'Python')


insert into alunos (id_aluno ,id_curso, nome_aluno ,idade) 
values 
(1, 1,'Roberta','25'),
(2,2,'Maria','23'),
(3,3,'Sabrina','30');


alter table alunos add constraint uni_id unique (id_curso)









