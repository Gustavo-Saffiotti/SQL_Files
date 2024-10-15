-- Triggers

DELIMITER $$

CREATE TRIGGER after_articles_update_1
AFTER UPDATE ON articles
FOR EACH ROW
BEGIN

    IF OLD.1622 Altura da embalagem [cm] <> NEW.1622 Altura da embalagem [cm] THEN
        INSERT INTO articles_update_log (article_number, column_name, old_value, new_value, update_time)
        VALUES (NEW.Article Number, '1622 Altura da embalagem [cm]', OLD.1622 Altura da embalagem [cm], NEW.1622 Altura da embalagem [cm], NOW());
    END IF;



CREATE TABLE articles_update_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    article_number VARCHAR(50),
    updated_column VARCHAR(100),
    old_value TEXT,
    new_value TEXT,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Verificar o log
SELECT * FROM articles_update_log;






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



insert into game (id_game, name, description, id_class, id_level) 
values (104, 'Call of Duty Zumbis', 'Modo survival do call of duty para matar zumbis', 300, 11);

SELECT * FROM game_backup gb ;



CREATE TABLE console (
id_console int,
nome_console varchar (50)
);





use projeto_aviacao;

DELIMITER //

create procedure fabricantes_aeronave() -- cria a procedure
begin
select * from tipo_aeronave;
end

DELIMITER ;
call tipo_aeronave(); -- chama a procedure