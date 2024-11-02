
-- Criação do usuário celso com permissão para visualizar todas as tabelas do banco de dados credit --
CREATE USER 'celso'@'localhost' IDENTIFIED BY 'iwPgJMkkPW8EWMS';
-- Garantindo a permissão de leitura em todas as tabelas do banco de dados credit --
GRANT SELECT ON credit.* TO 'celso'@'localhost';
-- Revogando as permissões de inserção, atualização e exclusão de dados nas tabelas do banco de dados credit --
REVOKE delete, insert, update ON *.* FROM 'celso'@'localhost';
-- Visualizar as permissões concedidas ao usuário celso --
SHOW GRANTS FOR 'celso'@'localhost';
-- Selecionar todos os usuários registrados --
SELECT User, Host FROM mysql.user;
-- Exclusão do usuário celso --
DROP USER 'celso'@'localhost';


--------------------------------------------------------


-- Criação do usuário emiliando com permissão para visualizar todas as tabelas do banco de dados credit --
CREATE USER 'emiliano'@'localhost' IDENTIFIED BY 'tjGdcQIiJIf72Nu';
-- Garantindo a permissão de leitura, visualização e atualização em todas as tabelas do banco de dados credit --
GRANT SELECT, INSERT, UPDATE ON credit.* TO 'emiliano'@'localhost';
-- Revogando as permissão de exclusão de dados nas tabelas do banco de dados credit --
REVOKE DELETE ON *.* FROM 'emiliano'@'localhost';
-- Selecionar todos os usuários registrados --
SELECT User, Host FROM mysql.user;
-- Exclusão do usuário emiliano --
DROP USER 'emiliano'@'localhost';








-- Cria um usuário chamado 'Lucas' com permissões locais (localhost) sem definir uma senha.
CREATE USER 'Lucas'@'localhost';


-- Exibe as permissões atuais atribuídas ao usuário 'Lucas' no localhost.
SHOW GRANTS FOR 'Lucas'@'localhost';


-- Concede ao usuário 'Lucas' permissão apenas para fazer consultas (SELECT) na tabela 'avaliacoes' do banco de dados 'projeto_2'.
GRANT SELECT ON projeto_2.* to  'Lucas'@'localhost';


-- Atualiza as permissões para que todas as alterações feitas nas permissões de usuários sejam aplicadas imediatamente.
FLUSH PRIVILEGES;


-- Cria um usuário chamado 'José' com permissões locais (localhost) e define a senha 'senha_jose'.
CREATE USER 'José'@'localhost' IDENTIFIED BY 'senha_jose';


-- Concede ao usuário 'José' permissões para selecionar (SELECT), inserir (INSERT) e atualizar (UPDATE) dados em todas as tabelas do banco de dados 'projetos_2'.
GRANT SELECT, INSERT, UPDATE ON projetos_2.* TO 'José'@'localhost';


-- Atualiza as permissões para garantir que as novas permissões concedidas ao usuário 'José' sejam aplicadas corretamente.
FLUSH PRIVILEGES;



-- Revoga a permissão de exclusão (DELETE) do usuário 'Lucas' para o banco de dados 'projeto_2'.
REVOKE DELETE ON projeto_2.* FROM 'Lucas'@'localhost';

-- Revoga a permissão de exclusão (DELETE) do usuário 'José' para o banco de dados 'projetos_2'.
REVOKE DELETE ON projetos_2.* FROM 'José'@'localhost';









-- 1. Criando usuário somente leitura
create user 'fran'@'localhost';


-- Dando a permissão apenas de leitura do usuário FRAN
GRANT SELECT on *.* to 'fran'@'localhost';


-- Mostrando os privilégios de FRAN
show grants for fran@localhost;




-- 2. Criando usuário com permissão de Leitura, Inserção e Modificação de Dados
create user 'gabriel'@'localhost';


-- Dando as permissões
grant select, update, insert on *.* to 'gabriel'@'localhost';
 
-- Mostrando os privilégios de GABRIEL
show grants for gabriel@localhost;


select * from user;








