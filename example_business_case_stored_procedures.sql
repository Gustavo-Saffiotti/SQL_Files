-- ========================================================
-- Script for Updating Data in Table1 Based on New Criteria from Table2
-- ========================================================
-- This script provides a process for updating values in 'table1' 
-- using new criteria from 'table2'. It includes the following steps:
--
-- 1. Importing new criteria data into 'table2'.
-- 2. Selecting the columns from 'table2' to be used for updating 'table1'.
-- 3. Updating the values in 'table1' based on the matching identifier column (e.g., 'id_column').
-- 4. Viewing the updated data in 'table1' to confirm the changes.
-- 5. Optionally, exporting the updated data for further use.
--
-- The process is handled through three stored procedures:
-- 1. 'Select_Columns_for_Update' - Selects columns to update from 'table2'.
-- 2. 'Update_Columns_in_Table1' - Performs the update of 'table1' based on 'table2'.
-- 3. 'View_Updated_Table1' - Views the updated data in 'table1'.
--
-- Before running the script:
-- 1. Ensure that 'table2' is populated with the new criteria.
-- 2. Modify the columns and identifier name in the procedures as necessary.
-- 3. The script uses dynamic SQL for flexibility.
--
-- The script assumes that both 'table1' and 'table2' have the same identifier column 
-- (e.g., 'id_column') to match records for updating.

-- ========================================================
-- 1. IMPORTING NEW CRITERIA TABLE (table2)
-- Ensure that 'table2' contains the new criteria data for updating 'table1'.
-- This table should have the same structure but with updated criteria for columns.

-- 2. VIEW THE TABLES
-- Check the data in 'table2' (new criteria table) and 'table1' (table to be updated)
SELECT * FROM table2;  -- Check the data in table2 (new criteria)
SELECT * FROM table1;  -- Check the data in table1 (to be updated)

-- 3. EXECUTE THE PROCEDURE TO SELECT COLUMNS TO UPDATE (Exclude the identifier column)
-- This procedure will select the columns from 'table2' that should be used to update 'table1'
DELIMITER //

CREATE PROCEDURE Select_Columns_for_Update(
    IN p_columns TEXT  -- Column names for selection, separated by commas
)
BEGIN
    -- Format the columns to include backticks around each column name
    SET @columns_with_aliases = REPLACE(p_columns, ',', '`, `');
    SET @columns_with_aliases = CONCAT('`', @columns_with_aliases, '`');
    
    -- Store the formatted column list in a session variable
    SET @selected_columns = @columns_with_aliases;
    
    -- Optionally, display the selected columns for debugging
    SELECT @selected_columns;
END //

DELIMITER ;

-- Execute the procedure to select the columns to update (exclude identifier column)
CALL Select_Columns_for_Update('column1, column2, column3, column4');  -- Example columns

-- 4. EXECUTE THE PROCEDURE TO UPDATE THE 'table1' BASED ON 'table2'
-- This procedure updates 'table1' with values from 'table2' where the identifier matches
DELIMITER //

CREATE PROCEDURE Update_Columns_in_Table1(
    IN p_identifier_col VARCHAR(255)  -- Column name for the identifier (e.g., 'ID')
)
BEGIN
    -- Check if the columns were selected before proceeding
    IF @selected_columns IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No columns selected. Execute Select_Columns_for_Update first.';
    END IF;

    -- Start constructing the SQL command for updating 'table1'
    SET @sql = CONCAT('UPDATE table1 AS t1 JOIN table2 AS t2 ON t1.`', p_identifier_col, '` = t2.`', p_identifier_col, '` SET ');
    SET @set_sql = '';
    
    -- Use the columns selected previously
    SET @update_columns = @selected_columns;  -- Columns with backticks added
    
    -- Loop through columns to build the SET clause of the UPDATE query
    WHILE LENGTH(@update_columns) > 0 DO
        SET @column = SUBSTRING_INDEX(@update_columns, ',', 1);
        
        -- Remove the processed column from the list
        IF LOCATE(',', @update_columns) > 0 THEN
            SET @update_columns = TRIM(SUBSTRING(@update_columns, LENGTH(@column) + 2));  -- +2 to remove comma and space
        ELSE
            SET @update_columns = '';  -- Last column processed
        END IF;

        -- Append the UPDATE logic for the column
        SET @set_sql = CONCAT(
            @set_sql, 
            't1.', @column, ' = CASE 
                WHEN t2.', @column, ' IS NOT NULL AND t2.', @column, ' <> '''' THEN 
                    CONCAT(IFNULL(t1.', @column, ', ''''), 
                           IF(CHAR_LENGTH(IFNULL(t1.', @column, ', '''')) > 0, '';'', ''''), 
                           t2.', @column, ') 
                ELSE 
                    t1.', @column, ' 
            END,');
    END WHILE;

    -- Remove the last comma from the SET clause
    SET @set_sql = LEFT(@set_sql, LENGTH(@set_sql) - 1);
    
    -- Construct the final SQL query for updating
    SET @sql = CONCAT(@sql, @set_sql, ' WHERE t2.`', p_identifier_col, '` IS NOT NULL;');

    -- For debugging: show the generated SQL query
    SELECT @sql;  -- This step can be removed if you no longer need to debug the query

    -- Execute the SQL query
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- Execute the procedure to update 'table1' based on 'table2'
CALL Update_Columns_in_Table1('id_column');  -- Example identifier column 'id_column'

-- 5. VERIFY THE UPDATED TABLE DATA
-- After the update, view the data in 'table1' to verify the changes
DELIMITER //

CREATE PROCEDURE View_Updated_Table1(
    IN p_columns TEXT  -- Column names for viewing, separated by commas
)
BEGIN
    -- Format the column names with backticks for display
    SET @columns_with_aliases = REPLACE(p_columns, ',', '`, t1.`');
    SET @columns_with_aliases = CONCAT('t1.`', @columns_with_aliases, '`');
    
    -- Build the SQL query to select the updated data from 'table1'
    SET @sql = CONCAT('SELECT ', @columns_with_aliases, 
                      ' FROM table1 AS t1 INNER JOIN table2 AS t2 ON t1.`id_column` = t2.`id_column`;');
    
    -- For debugging: show the generated SQL query
    SELECT @sql;  -- This can be removed if not needed

    -- Execute the SQL query
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- Execute the procedure to view the updated data in 'table1'
CALL View_Updated_Table1('id_column, column1, column2, column3');  -- Example columns

-- 6. EXPORT THE UPDATED DATA
-- Once verified, export the table data for further use (e.g., CSV, SQL dump) and re-import it as needed.

