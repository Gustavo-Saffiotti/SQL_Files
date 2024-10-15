-- AULA 18 TRIGGERS
-- 1. Auditoria com AFTER Trigger
-- Esta trigger registra uma mudança de salário na tabela de auditoria sempre que o salário de um funcionário é atualizado:

CREATE TRIGGER AfterSalaryUpdate
AFTER UPDATE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO SalaryAudit (employee_id, old_salary, new_salary, change_date)
    VALUES (OLD.employee_id, OLD.salary, NEW.salary, NOW());
END;


/*2. Validação de Dados com BEFORE Trigger
Esta trigger valida se a quantidade de um pedido é positiva antes de inserir: */

CREATE TRIGGER BeforeOrderInsert
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;
END;



/*3. Atualização Automática com AFTER Trigger
Este exemplo atualiza o estoque de um produto sempre que uma nova venda é registrada:*/


CREATE TRIGGER AfterSaleInsert
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    UPDATE Products
    SET stock_quantity = stock_quantity - NEW.quantity_sold
    WHERE product_id = NEW.product_id;
END;




-- Exemplo trabalho


DELIMITER $$

CREATE TRIGGER after_articles_update_1
AFTER UPDATE ON articles
FOR EACH ROW
BEGIN

    IF OLD.1622 Altura da embalagem [cm] <> NEW.1622 Altura da embalagem [cm] THEN
        INSERT INTO articles_update_log (article_number, column_name, old_value, new_value, update_time)
        VALUES (NEW.Article Number, '1622 Altura da embalagem [cm]', OLD.1622 Altura da embalagem [cm], NEW.1622 Altura da embalagem [cm], NOW());
    END IF;
END


-- Verificar o log
SELECT * FROM articles_update_log;

CREATE TABLE articles_update_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    article_number VARCHAR(50),
    updated_column VARCHAR(100),
    old_value TEXT,
    new_value TEXT,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




UPDATE ARTICLES
SET '1622 Altura da embalagem [cm]' = 'novo valor'
WHERE article_number = 'ga599'



-- EXEMPLOS PROF

/*Exemplo 1
 
 
 SELECT * FROM game;

CREATE TRIGGER tr_game_backup_insert
AFTER INSERT ON game
FOR EACH ROW
BEGIN
  INSERT INTO game_backup (
    id_game, 
    name, 
    description, 
    id_level, 
    id_class
  ) VALUES (
    NEW.id_game, 
    NEW.name, 
    NEW.description, 
    NEW.id_level, 
    NEW.id_class
  );
END

create table game_backup as
select * from game


INSERT INTO game ( id_game,name,  description,id_class,id_level)
VALUES (101, 'FIFA', 'Jogo de futebol', 11,300);

SELECT * FROM game_backup;



ALTER TABLE game
DROP FOREIGN KEY GAME_CLASS;*/


/*
Exemplo 2
CREATE TRIGGER tr_game_LOG2
before UPDATE ON game_backup
FOR EACH ROW
BEGIN
  INSERT INTO GAME_LOG (
    id_game,
    usuario, 
	data_registro
  ) VALUES (
    NEW.id_game,
	USER(),
	NOW()
  );
END
*/




insert into game (id_game, name, description, id_class, id_level) values (103, 'Call of Duty Zumbis', 'Modo survival do call of duty para matar zumbis', 300, 11);

insert into game (id_game, name, description, id_class, id_level) values (103, 'Call of Duty Zumbis', 'Modo survival do call of duty para matar zumbis', 300, 11);


