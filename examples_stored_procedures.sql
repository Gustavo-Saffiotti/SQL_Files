/* Explanation of Commands Used

- **DELIMITER**: Changes the default statement delimiter in SQL to define multi-statement procedures or functions. This is necessary when creating stored procedures, allowing SQL to recognize the end of the procedure block.
  
- **CREATE PROCEDURE**: Defines a stored procedure, which is a reusable SQL block that can include conditional logic, parameters, and return results. Stored procedures are useful for complex queries and operations on the database.

- **CALL**: Executes a stored procedure. Parameters can be passed to customize the procedure's execution.

- **IN** / **OUT** / **INOUT**: Define parameter types in stored procedures. 
  - `IN`: The parameter is input-only.
  - `OUT`: The procedure assigns a value to this parameter to output a result.
  - `INOUT`: Acts as both input and output.

- **IF**, **ELSEIF**, **END IF**: Used for conditional logic within procedures, allowing specific SQL commands to run based on conditions.

- **SET**: Assigns a value to a variable. This is commonly used to dynamically build queries or store values for output.

- **PREPARE** and **EXECUTE**: Used to create and run dynamic SQL statements within a stored procedure. This allows for the creation of queries with variable parts, which can be constructed based on procedure parameters.

- **DEALLOCATE PREPARE**: Releases a prepared statement, freeing up resources once the statement execution is complete.

- **SELECT**: Retrieves data from a database. Often paired with **WHERE** to filter data, **ORDER BY** to sort results, and **GROUP BY** for aggregation.

- **WHERE**: Filters rows based on specified conditions, allowing for precise data retrieval.

- **LIKE**: Filters results based on pattern matching. Used to search for specific substrings within text fields.

- **ORDER BY**: Sorts the results based on specified columns, either in ascending (ASC) or descending (DESC) order.

- **BETWEEN**: Selects values within a specified range, commonly used with dates to filter a period.

- **CONCAT**: Combines multiple strings or values into one, useful for constructing dynamic SQL queries.

- **LAST_INSERT_ID**: Retrieves the last auto-increment ID generated, often used when inserting records into a table and needing to reference the newly created record.

This script demonstrates various SQL techniques and stored procedures for filtering, ordering, counting, and dynamically querying tables with custom conditions and parameters.
*/

 
 
 
 
 
 /* Example 1: Procedure to Retrieve Game by ID
   This procedure takes an ID as a parameter and returns the corresponding game information.
   **DELIMITER** temporarily changes the delimiter, and **CALL** is used for execution. */
DELIMITER //
CREATE PROCEDURE `get_game_by_id` (IN game_id CHAR(40))
BEGIN
    SELECT * FROM game WHERE id_game LIKE game_id;
END //
DELIMITER ;

CALL get_game_by_id('20');



/* Example 2: Procedure to Count Enabled Products
   This procedure counts the number of enabled products in the `products` table. */
DELIMITER //
CREATE PROCEDURE `count_enabled_products` (OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM products WHERE enabled = TRUE;
END //
DELIMITER ;

CALL count_enabled_products(@product_count);
SELECT @product_count;



/* Example 3: Procedure with Conditional Checks (IF)
   This procedure uses **IF** conditions to check the game ID and return information based on its value. */
DELIMITER //
CREATE PROCEDURE `if_game_check` (IN game_id INT)
BEGIN 
    IF game_id = 1 THEN
        SELECT * FROM game WHERE id_game = game_id;
    ELSEIF game_id = 2 THEN
        SELECT * FROM game WHERE id_game = game_id;
    ELSEIF game_id = 3 THEN
        SELECT * FROM game WHERE id_game = game_id;
    END IF;
END //
DELIMITER ;

CALL if_game_check(3);



/* Example 4: Procedure to Count Total Games
   This procedure returns the total count of games in the `game` table and stores the result in an output variable. */
DELIMITER //
CREATE PROCEDURE count_games(OUT total_games INT)
BEGIN
    SELECT COUNT(*) INTO total_games FROM game;
END //
DELIMITER ;

CALL count_games(@total_games);
SELECT @total_games;



/* Example 5: Dynamic Sorting Procedure using PREPARE and EXECUTE
   This procedure enables sorting results dynamically based on a sorting field provided as a parameter. */
DELIMITER //
CREATE PROCEDURE `get_games_with_order` (IN field CHAR(20))
BEGIN
    DECLARE game_order VARCHAR(255);  

    IF field <> '' THEN
        SET game_order = CONCAT('ORDER BY ', field);
    ELSE
        SET game_order = '';
    END IF;

    SET @query = CONCAT('SELECT * FROM game ', game_order);

    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

CALL get_games_with_order('description');



/* Example 6: Insert New Employee Procedure
   This procedure inserts a new employee into the `Employees` table and returns the generated ID in the `NewEmployeeID` output variable. */
DELIMITER //
CREATE PROCEDURE AddNewEmployee(
    IN Name VARCHAR(100),
    IN Position VARCHAR(100),
    IN Salary DECIMAL(10, 2),
    OUT NewEmployeeID INT
)
BEGIN
    INSERT INTO Employees (Name, Position, Salary)
    VALUES (Name, Position, Salary);
    SET NewEmployeeID = LAST_INSERT_ID();
END //
DELIMITER ;

CALL AddNewEmployee('Alice', 'Manager', 75000, @EmployeeID);
SELECT @EmployeeID;



/* Example 7: Date Range Sum Calculation
   This procedure calculates the sum of `id_system_user` values in the `commentary` table between specified dates. */
DELIMITER //
CREATE PROCEDURE calculate_period_sum(IN start_date DATE, IN end_date DATE, OUT sum_value INT)
BEGIN
    SELECT SUM(id_system_user) INTO sum_value
    FROM commentary
    WHERE comment_date BETWEEN start_date AND end_date;
END //
DELIMITER ;

CALL calculate_period_sum('2010-01-31', '2010-06-27', @result);
SELECT @result;



/* Example 8: Dynamic Table Selection
   This procedure allows for dynamically selecting all columns from a specified table name. */
DELIMITER //
CREATE PROCEDURE `select_table` (IN table_name CHAR(20))
BEGIN
    SET @query = CONCAT('SELECT * FROM ', table_name);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

CALL select_table('game');



/* Example 9: Dynamic Sales Report with Custom Sorting
   This procedure generates a sales report and allows custom sorting based on `p_order_by` and `p_direction` parameters. */
DELIMITER //
CREATE PROCEDURE dynamic_sales_report(
    IN p_order_by VARCHAR(50),
    IN p_direction VARCHAR(4)
)
BEGIN
    SET @query = 'SELECT customer_id, SUM(sale_value) AS total_sales FROM sales GROUP BY customer_id ';
    
    IF p_order_by IS NOT NULL AND p_direction IS NOT NULL THEN
        SET @query = CONCAT(@query, ' ORDER BY ', p_order_by, ' ', p_direction);
    END IF;
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

CALL dynamic_sales_report('total_sales', 'DESC');
CALL dynamic_sales_report('customer_id', 'ASC');



/* Example 10: Dynamic Query for Multiple Tables
   This procedure allows querying different tables and columns dynamically by passing values as parameters. */
DELIMITER //
CREATE PROCEDURE dynamic_table_query(
    IN table_name VARCHAR(50),
    IN column_name VARCHAR(50),
    IN column_value VARCHAR(100)
)
BEGIN
    SET @query = CONCAT('SELECT * FROM ', table_name, ' WHERE ', column_name, ' = "', column_value, '"');
    
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

CALL dynamic_table_query('customers', 'name', 'John');
CALL dynamic_table_query('products', 'category', 'Electronics');





























