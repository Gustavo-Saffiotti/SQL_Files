--- EXEMPLO 1

DELIMITER //

CREATE PROCEDURE `nome_do_game` (IN parametro1 CHAR(40))
BEGIN
SELECT * FROM game WHERE id_game LIKE parametro1;
END
DELIMITER ;

CALL nome_do_game('20');


--- EXEMPLO 2

DELIMITER //
CREATE PROCEDURE `nome_do_sp` (OUT total INTEGER)
BEGIN
SELECT COUNT(*) INTO total FROM produtos 	WHERE habilitado = TRUE;
...
END //


--- EXEMPLO 2

USE gammers_model
DROP PROCEDURE IF EXISTS 'sp_get_games'

CREATE PROCEDURE 'sp_get_games'
BEGIN
	SELECT *FROM gammers_model.game;
END

delimiter ;


CALL sp_get_games();






--- EXEMPLO 3 -  WITH IF

DELIMITER //

CREATE PROCEDURE `if_jogo` (IN game_id INT)
BEGIN 
	If game_id = 1 THEN
		SELECT * FROM game WHERE id_game = game_id;
	ELSEIF game_id=2 then
		SELECT * FROM game WHERE id_game = game_id;
	ELSEIF game_id = 3 THEN
		SELECT * FROM game WHERE id_game = game_id;
	END IF;
end


CALL if_jogo(3)






--- EXEMPLO 4

DELIMITER //

CREATE PROCEDURE count_jogos(OUT total_jogos int)
BEGIN
	SELECT count(*)
INTO total_jogos FROM game;
END



DELIMITER ;

CALL count_jogos (@variavel)
SELECT @variavel



--- WITH PREPARE E EXECUTE

DELIMITER //
CREATE PROCEDURE `sp_get_games_order2` (IN field CHAR(20))
BEGIN
  DECLARE game_order VARCHAR(255);  

  IF field <> '' THEN
    SET game_order = CONCAT('ORDER BY ', field);
  ELSE
    SET game_order = '';
  END IF;

  SET @clausula = CONCAT('SELECT * FROM game ', game_order);

  PREPARE runSQL FROM @clausula;
  EXECUTE runSQL;
  DEALLOCATE PREPARE runSQL;
END

DELIMITER ;


SET @clausula1= 'game'





CALL sp_get_games_order2('description');



--- DROP PROCEDURE
DROP PROCEDURE name_procedure

--- ALTER PROCEDURE
ALTER PROCEDURE AddNewEmployee





--- EXEMPLO COM INSERT INTO

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2)
);


DELIMITER //

CREATE PROCEDURE AddNewEmployee(
    IN Name VARCHAR(100),
    IN Position VARCHAR(100),
    IN Salary DECIMAL(10, 2),
    OUT NewEmployeeID INT  -- Variável de saída
)
BEGIN
    -- Inserir o novo funcionário na tabela
    INSERT INTO Employees (Name, Position, Salary)
    VALUES (Name, Position, Salary);

    -- Atribuir o ID gerado à variável de saída
    SET NewEmployeeID = LAST_INSERT_ID();
END //

DELIMITER ;




call buscar_game_id2(2);  --- terceiro comando


delimiter ; ---- quarto comando


--- fernanda
--- 1°comando
delimiter //

--- 2°comando
create procedure calculo_periodo(in data_inicio date, in data_final date, out soma_valor int) 
begin
	select sum(id_system_user) into soma_valor
	from commentary
	where comment_date between data_inicio and data_final;
end


--- 3°comando
call calculo_periodo('2010-01-31','2010-06-27',@variavel);


--- 4°comando
select @variavel  


--- 5°comando
delimiter ;






--- SELECIONAR TABELA

DELIMITER //
CREATE PROCEDURE `select_tabela` (IN name CHAR(20))

BEGIN
  SET @clausula = CONCAT('SELECT * FROM ', name);

  PREPARE runSQL FROM @clausula;
  EXECUTE runSQL;
  DEALLOCATE PREPARE runSQL;
END

DELIMITER ;


CALL select_tabela ('game')





/*Exemplo: Relatório Dinâmico com Ordenação Personalizada
Essa procedure permite gerar relatórios com ordenação dinâmica, 
com a coluna de ordenação sendo passada como parâmetro.*/

DELIMITER //

CREATE PROCEDURE relatorio_vendas_dinamico(
    IN p_order_by VARCHAR(50),
    IN p_direction VARCHAR(4)
)
BEGIN
    DECLARE @sql VARCHAR(1000);
    
    -- Inicia a query de seleção
    SET @sql = 'SELECT cliente_id, SUM(valor_venda) AS total_vendas FROM vendas GROUP BY cliente_id ';
    
    -- Adiciona a cláusula ORDER BY com base nos parâmetros
    IF p_order_by IS NOT NULL AND p_direction IS NOT NULL THEN
        SET @sql = CONCAT(@sql, ' ORDER BY ', p_order_by, ' ', p_direction);
    END IF;
    
    -- Executa a query construída dinamicamente
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;







CREATE PROCEDURE ordenar_codigo_ocorrencia(
IN codigo_ocorrencia INT, -- Nome do campo de ordenação
IN id_tipo VARCHAR(50) -- Tipo de ordenação: 'ASC' ou 'DESC'
)
BEGIN
	DECLARE sql VARCHAR(1000);

	SET @sql = 'SELECT * FROM class ';

	IF codigo_ocorrencia IS NOT NULL AND id_tipo IS NOT NULL THEN
		SET @sql = CONCAT(@sql, ' ORDER BY ', codigo_ocorrencia, ' ', id_tipo);
	END IF;

	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END

DELIMITER ;


DELIMITER $$
CREATE PROCEDURE ordenar_codigo_ocorrencia(
    IN p_campo_ordenacao VARCHAR(50),
    IN p_tipo_ordenacao VARCHAR(50)
)
BEGIN
    SET @sql := CONCAT('SELECT * FROM class ');

    IF p_campo_ordenacao IS NOT NULL AND p_tipo_ordenacao IN ('ASC', 'DESC') THEN
        SET @sql := CONCAT(@sql, 'ORDER BY ', p_campo_ordenacao, ' ', p_tipo_ordenacao);
    END IF;

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;


CALL ordenar_codigo_ocorrencia('id_level','asc');



SELECT * FROM class;








-- Chamando a procedure com diferentes critérios de ordenação
CALL relatorio_vendas_dinamico('total_vendas', 'DESC'); -- Ordena por total de vendas em ordem decrescente
CALL relatorio_vendas_dinamico('cliente_id', 'ASC'); -- Ordena por ID do cliente em ordem crescente


/*Exemplo 4: Consulta Dinâmica em Várias Tabelas
Neste exemplo, a procedure permite selecionar dinamicamente de uma tabela 
especificada como parâmetro, o que é útil quando há muitas tabelas semelhantes.*/
DELIMITER //

CREATE PROCEDURE consulta_dinamica_em_tabela(
    IN p_table_name VARCHAR(50),
    IN p_column_name VARCHAR(50),
    IN p_value VARCHAR(100)
)
BEGIN
    DECLARE @sql VARCHAR(1000);
    
    -- Constrói a query dinamicamente com base nos parâmetros
    SET @sql = CONCAT('SELECT * FROM ', p_table_name, ' WHERE ', p_column_name, ' = "', p_value, '"');
    
    -- Executa a query dinâmica
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- Chamando a procedure para consultar diferentes tabelas e colunas
CALL consulta_dinamica_em_tabela('clientes', 'nome', 'João');
CALL consulta_dinamica_em_tabela('produtos', 'categoria', 'Eletrônicos');






DELIMITER //

CREATE TRIGGER before_insert_employee_performance
BEFORE INSERT ON EmployeePerformance
FOR EACH ROW
BEGIN
INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate)
VALUES (NEW.EmployeeID, 'Insert', NOW(), SESSION_USER());
END

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_update_employee_performance
AFTER UPDATE ON EmployeePerformance
FOR EACH ROW
BEGIN
INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate)
VALUES (NEW.EmployeeID, 'Update', NOW(), SESSION_USER());
END

DELIMITER ;

DELIMITER //

CREATE TRIGGER before_insert_abbr_employee_perf
BEFORE INSERT ON AbbrEmployeePerfWithInnerJoin
FOR EACH ROW
BEGIN
INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate)
VALUES (NEW.EmpID, 'Insert', NOW(), SESSION_USER());
END

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_update_abbr_employee_perf
AFTER UPDATE ON AbbrEmployeePerfWithInnerJoin
FOR EACH ROW
BEGIN
INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate)
VALUES (NEW.EmpID, 'Update', NOW(), SESSION_USER());
END

DELIMITER ;

CREATE TABLE EmployeeLog (
LogID INT AUTO_INCREMENT PRIMARY KEY,
EmployeeID VARCHAR(20),
Action VARCHAR(50),

ActionDate DATETIME
);

ALTER TABLE EmployeeLog
ADD COLUMN UserID VARCHAR(50);

DELIMITER //

CREATE TRIGGER after_delete_employee_performance
AFTER DELETE ON EmployeePerformance
FOR EACH ROW
BEGIN
INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate)
VALUES (OLD.EmployeeID, 'Delete', NOW(), SESSION_USER());
END

DELIMITER ;

DELETE FROM EmployeePerformance e
WHERE EmployeeID = 'E8F5-C47D';

select * from EmployeeLog

















































