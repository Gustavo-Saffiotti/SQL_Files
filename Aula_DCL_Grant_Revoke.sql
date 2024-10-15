USE mysql;
SHOW tables;


SELECT *FROM USER;

SELECT *FROM role_edges;


CREATE USER 'teste@dominio';


CREATE USER ‘teste@dbProdServer’; //seu nome
CREATE USER ‘teste@192.168.0.213;  //seu endereço IP
CREATE USER ‘teste@localhost’;    //local

CREATE USER 'teste@localhost' IDENTIFIED BY 'minhaPassword';



ALTER USER 'teste@localhost' IDENTIFIED BY 'novaPassword2';


UPDATE mysql.user SET Password=PASSWORD(‘novaPassword’)’ WHERE user = ‘teste’ AND host = ‘dominio’;



RENAME USER 'teste@localhost' TO 'coderhouse@dominio';

DROP USER 'usuário@dominio';


SELECT * FROM mysql.user WHERE user LIKE ‘coderhouse%’;




-- GRANTS

SHOW GRANTS FOR 'coderhouse@dominio';

GRANT ALL ON *.* TO 'coderhouse@dominio';


/*Para conceder permissões a um usuário 
 * sobre uma tabela específica de um banco de dados em particular, 
 * devemos referenciar a sentença da seguinte forma:
*/

GRANT ALL ON gammers_model.level_game TO 'coderhouse@dominio' WITH GRANT OPTION;

GRANT ALL ON gamer.class TO ‘coderhouse@localhost’;

GRANT ALL ON gamer.game TO ‘coderhouse@localhost’;


-- CONCEDER PERMISSÕES SELETIVAS

GRANT SELECT, UPDATE ON gamer.level_game TO ‘coderhouse@localhost’;


-- CONCEDER PERMISSÕES SOBRE COLUNAS

GRANT UPDATE, SELECT (description) 
ON gamer.level_game 
TO ‘coderhouse@localhost’;


-- REVOKE

REVOKE ALL ON *.* FROM ‘coderhouse@localhost’;

-- REVOGAR UMA DETERMINADA PERMISSÃO

REVOKE UPDATE ON *.* FROM ‘coderhouse@localhost’;



SHOW GRANTS FOR CURRENT_USER();


GRANT CREATE USER ON *.* TO 'root@localhost';
GRANT GRANT OPTION ON *.* TO 'seu_usuario'@'localhost';
FLUSH PRIVILEGES;


GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;


SELECT User, Host FROM mysql.user WHERE User = 'root';


















