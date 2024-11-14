/* Explanation of Commands Used

- **SELECT @@autocommit**: Retrieves the current autocommit setting for the session. Autocommit controls whether each SQL statement is automatically committed after execution or if manual transaction control is required.

- **SET autocommit = 0**: Disables autocommit mode, meaning that SQL statements will not be automatically committed. This requires explicit use of `COMMIT` or `ROLLBACK` to manage transaction states.

- **START TRANSACTION**: Begins a new transaction, grouping a set of operations into a single unit. If any operation fails, the entire transaction can be rolled back to maintain data consistency.

- **UPDATE**: Modifies existing records in a table based on specific conditions. Here, it is used to update the description of a class based on its ID.

- **SELECT**: Retrieves data from the specified table. After the `UPDATE`, this command is used to verify the result of the update operation.

- **ROLLBACK**: Reverts all changes made during the current transaction, effectively undoing any operations that were performed after `START TRANSACTION`.

- **INSERT INTO**: Adds new records to a table. Used to insert new rows into the `class` and `console` tables.

- **ORDER BY**: Sorts the result set based on a specified column, in this case, the description column, ordered in descending order.

- **LIMIT**: Restricts the number of rows returned by the `SELECT` query. Here, it limits the result to the 10 most recent records.

- **COMMIT**: Finalizes the transaction, making all changes permanent. Once `COMMIT` is executed, the changes made during the transaction cannot be rolled back.

- **SAVEPOINT**: Creates a savepoint within the transaction. Savepoints allow partial rollbacks, which means that only the operations performed after the savepoint can be undone without affecting previous operations.

- **ROLLBACK TO <savepoint>**: Rolls back the transaction to a specific savepoint, undoing only the operations that occurred after that point. This allows for more granular control over which parts of a transaction should be undone.

- **RELEASE SAVEPOINT**: Releases a specific savepoint, freeing any resources associated with it. After a savepoint is released, it cannot be rolled back to.

- **DELIMITER**: Changes the statement delimiter in SQL. It is typically used when defining stored procedures or triggers, allowing for multi-line definitions without confusion between the delimiter and SQL statements.

- **CREATE PROCEDURE**: Defines a stored procedure in SQL, a reusable block of SQL code that can accept parameters and execute multiple statements. In this example, the procedure handles order processing.

- **BEGIN...END**: Encapsulates a block of SQL statements, typically used within stored procedures or triggers to group related operations together.

- **IF...THEN**: Conditional statement used to check if a certain condition is met. In this case, it is used to determine whether to commit or roll back the transaction based on whether any rows were affected by the previous `UPDATE` and `INSERT` statements.

- **ROW_COUNT()**: Returns the number of rows affected by the last SQL operation (such as `UPDATE`, `INSERT`, or `DELETE`). It is used to check whether the `UPDATE` and `INSERT` were successful before committing the transaction.

- **SESSION_USER()**: Returns the user connected to the session. While not directly used in this script, this function can be useful for auditing or logging purposes in triggers or stored procedures.

The above examples demonstrate how to handle transactions in SQL using various commands like `START TRANSACTION`, `COMMIT`, and `ROLLBACK`, as well as how to use savepoints for more granular control over the rollback process. They also show how to define and use stored procedures for encapsulating business logic and controlling transactions within those procedures.
*/





-- Checking the current autocommit status
SELECT @@autocommit;

-- Disable autocommit for manual control over transactions
SET autocommit = 0;

-- Example 1: Start a transaction, update a record, and rollback
START TRANSACTION;

-- Updating a class description based on conditions
UPDATE class 
SET description = 'TRACKPAD BT'
WHERE id_level = 10 AND id_class = 1;

-- Viewing the result of the update
SELECT * FROM class;

-- Rolling back the transaction (undo the update)
ROLLBACK;

-- Example 2: Start a new transaction, insert a record, and commit
START TRANSACTION;

-- Inserting a new class
INSERT INTO class (id_level, id_class, description) 
VALUES (15, 99, 'Test class');

-- Viewing the newly inserted records, ordered by description
SELECT * FROM class
ORDER BY description DESC
LIMIT 10;

-- Committing the transaction (making the changes permanent)
COMMIT;

-- Example 3: Multiple inserts with savepoints and rollback to savepoint
START TRANSACTION;

-- Inserting multiple records
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (1, 1000, 'class 1000');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (2, 1000, 'class 1000');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (3, 1000, 'class 1000');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (4, 1000, 'class 1000');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (5, 1000, 'class 1000');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (6, 1000, 'class 1000');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (7, 1000, 'class 1000');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (8, 1000, 'class 1000');

-- Savepoint to mark the point in the transaction
SAVEPOINT lote_1;

-- More inserts after the first savepoint
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (1, 1002, 'class 1002');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (2, 1002, 'class 1002');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (3, 1002, 'class 1002');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (4, 1002, 'class 1002');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (5, 1002, 'class 1002');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (6, 1002, 'class 1002');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (7, 1002, 'class 1002');
INSERT INTO CLASS (id_level, id_class, description) 
VALUES (8, 1002, 'class 1002');

-- Savepoint for a second point in the transaction
SAVEPOINT lote_2;

-- Rollback to the second savepoint (undo all changes after lote_2)
ROLLBACK TO lote_2;

-- Release the first savepoint (free resources)
RELEASE SAVEPOINT lote_1;

-- Example 4: Commit transaction
START TRANSACTION;

-- Insert some records into the console table
INSERT INTO console (id_console, nome_console, valor_console) 
VALUES (1, 'PS1', 800);
INSERT INTO console (id_console, nome_console, valor_console) 
VALUES (2, 'PS2', 1800);
INSERT INTO console (id_console, nome_console, valor_console) 
VALUES (3, 'PS3', 2800);

-- Savepoint to mark the point in the transaction
SAVEPOINT level_1;

-- Insert more records
INSERT INTO console (id_console, nome_console, valor_console) 
VALUES (4, 'XBox', 3800);
INSERT INTO console (id_console, nome_console, valor_console) 
VALUES (5, 'Nintendo', 2000);

-- View the current data in the console table
SELECT * FROM console;

-- Rollback to level_1 (undo the second set of inserts)
ROLLBACK TO level_1;

-- Example 5: Stored Procedure with transaction control (example within a procedure)
DELIMITER $$

CREATE PROCEDURE processar_pedido(
    IN p_pedido_id INT,
    IN p_cliente_id INT
)
BEGIN
    -- Start transaction for processing a customer's order
    START TRANSACTION;

    -- Example of updating product stock based on order
    UPDATE produtos
    SET quantidade_estoque = quantidade_estoque - 1
    WHERE produto_id = (SELECT produto_id FROM pedidos WHERE pedido_id = p_pedido_id);

    -- Example of inserting a payment record
    INSERT INTO pagamentos (pedido_id, cliente_id, valor)
    VALUES (p_pedido_id, p_cliente_id, (SELECT valor_total FROM pedidos WHERE pedido_id = p_pedido_id));

    -- Check if the update and insert were successful
    IF ROW_COUNT() > 0 THEN
        -- Commit the transaction if successful
        COMMIT;
    ELSE
        -- Rollback the transaction if there was an error
        ROLLBACK;
    END IF;
END $$

DELIMITER ;

-- Final cleanup: Re-enable autocommit for normal operation
SET autocommit = 1;
