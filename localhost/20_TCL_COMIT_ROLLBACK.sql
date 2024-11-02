SELECT @@autocommit;
SET autocommit = 0;


START TRANSACTION;
UPDATE class 
SET 
    description = 'TRACKPAD BT'
WHERE
    id_level = 10 AND
    id_class = 1;
SELECT * FROM class;



ROLLBACK;




START TRANSACTION;

INSERT INTO class (id_level, id_class, description) VALUES (15, 99, ‘Test class’);

SELECT * FROM class
order by description DESC
limit 10;



COMMIT;






START TRANSACTION;
INSERT INTO CLASS (id_level, id_class, description) VALUES (1, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (2, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (3, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (4, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (5, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (6, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (7, 1000,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (8, 1000,'class 1000');
savepoint lote_1;
INSERT INTO CLASS (id_level, id_class, description) VALUES (1, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (2, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (3, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (4, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (5, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (6, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (7, 1002,'class 1000');
INSERT INTO CLASS (id_level, id_class, description) VALUES (8, 1002,'class 1000');
savepoint lote_2;




ROLLBACK TO <savepoint>;


RELEASE <savepoint>;




/* EXEMPLO COMMIT E ROLLBACK
DELIMITER $$

CREATE PROCEDURE processar_pedido(
    IN p_pedido_id INT,
    IN p_cliente_id INT
)
BEGIN
    -- Inicia a transação
    START TRANSACTION;

    BEGIN
        -- Exemplo de atualização do estoque do produto
        UPDATE produtos
        SET quantidade_estoque = quantidade_estoque - 1
        WHERE produto_id = (SELECT produto_id FROM pedidos WHERE pedido_id = p_pedido_id);

        -- Exemplo de inserção de um registro na tabela de pagamentos
        INSERT INTO pagamentos (pedido_id, cliente_id, valor)
        VALUES (p_pedido_id, p_cliente_id, (SELECT valor_total FROM pedidos WHERE pedido_id = p_pedido_id));

        -- Verifica se algum erro ocorreu, caso contrário, comita a transação
        IF ROW_COUNT() > 0 THEN
            -- Confirma a transação
            COMMIT;
        ELSE
            -- Desfaz a transação em caso de erro
            ROLLBACK;
        END IF;
    END;

END $$

DELIMITER ;
*/




create table console (
id_console int,
nome_console varchar(15),
valor_console double
);

start transaction;

insert into console (id_console, nome_console, valor_console) value (1, 'PS1', '800');
insert into console (id_console, nome_console, valor_console) value (2, 'PS2', '1800');
insert into console (id_console, nome_console, valor_console) value (3, 'PS3', '2800');

savepoint level_1;

insert into console (id_console, nome_console, valor_console) value (4, 'XBox', '3800');
insert into console (id_console, nome_console, valor_console) value (5, 'Nintendo', '2000');

select * from console

rollback to level_1;
























