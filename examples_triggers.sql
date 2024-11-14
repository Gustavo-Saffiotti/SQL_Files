/*Explanation of Commands Used

- **CREATE TRIGGER**: Defines a trigger in SQL, which is a set of instructions that are automatically executed in response to specific events (INSERT, UPDATE, DELETE) on a particular table.
  
- **AFTER** and **BEFORE** Triggers: 
  - `AFTER` triggers execute after the specified event (e.g., after a row is updated).
  - `BEFORE` triggers execute before the specified event (e.g., before a new row is inserted).
  
- **NEW** and **OLD**: 
  - `NEW` is used to reference the new values in the row being modified or inserted.
  - `OLD` is used to reference the existing values in a row before an update or delete operation.

- **NOW()**: A SQL function that returns the current date and time, often used in audit logs.

- **SIGNAL SQLSTATE**: Used to raise a custom error with a specified message if a condition is met (e.g., validation checks before inserting data).

- **SESSION_USER()**: Returns the name of the user connected to the session.

The following triggers demonstrate auditing, data validation, automatic updates, and custom error handling in SQL. Each trigger example serves a specific purpose, such as logging changes, enforcing constraints, or dynamically updating related tables.

*/





/* Example 1: Salary Update Audit Trigger
This AFTER trigger records salary changes in the `SalaryAudit` table whenever the salary of an employee is updated. */

CREATE TRIGGER AfterSalaryUpdate
AFTER UPDATE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO SalaryAudit (employee_id, old_salary, new_salary, change_date)
    VALUES (OLD.employee_id, OLD.salary, NEW.salary, NOW());
END;

/* Example 2: Order Quantity Validation
This BEFORE trigger checks that the quantity in an order is positive before inserting a new record into the `Orders` table. */

CREATE TRIGGER BeforeOrderInsert
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;
END;

/* Example 3: Automatic Stock Update
This AFTER trigger updates the stock quantity in the `Products` table each time a sale is recorded in the `Sales` table. */

CREATE TRIGGER AfterSaleInsert
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    UPDATE Products
    SET stock_quantity = stock_quantity - NEW.quantity_sold
    WHERE product_id = NEW.product_id;
END;

/* Example 4: Employee Performance Audit
Multiple triggers record different actions (insert, update, delete) on the `EmployeePerformance` table by logging events in `EmployeeLog`. */

DELIMITER //

CREATE TRIGGER before_insert_employee_performance
BEFORE INSERT ON EmployeePerformance
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate)
    VALUES (NEW.EmployeeID, 'Insert', NOW(), SESSION_USER());
END;

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_update_employee_performance
AFTER UPDATE ON EmployeePerformance
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate)
    VALUES (NEW.EmployeeID, 'Update', NOW(), SESSION_USER());
END;

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_delete_employee_performance
AFTER DELETE ON EmployeePerformance
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate)
    VALUES (OLD.EmployeeID, 'Delete', NOW(), SESSION_USER());
END;

DELIMITER ;




/* Example 5: Trigger Log Table
This table stores a log of employee actions, capturing `EmployeeID`, `Action`, `ActionDate`, and the user who performed the action. */

CREATE TABLE EmployeeLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,       -- Unique identifier for each log entry
    EmployeeID VARCHAR(20),                     -- ID of the employee affected
    Action VARCHAR(50),                         -- Description of the action (e.g., 'Insert', 'Update', 'Delete')
    ActionDate DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of the action
    UserID VARCHAR(50)                          -- User who performed the action
);


DELIMITER //

-- Trigger to log inserts
CREATE TRIGGER after_insert_employee_performance
AFTER INSERT ON EmployeePerformance
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate, UserID)
    VALUES (NEW.EmployeeID, 'Insert', NOW(), SESSION_USER());
END//

-- Trigger to log updates
CREATE TRIGGER after_update_employee_performance
AFTER UPDATE ON EmployeePerformance
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate, UserID)
    VALUES (NEW.EmployeeID, 'Update', NOW(), SESSION_USER());
END//

-- Trigger to log deletions
CREATE TRIGGER after_delete_employee_performance
AFTER DELETE ON EmployeePerformance
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeLog (EmployeeID, Action, ActionDate, UserID)
    VALUES (OLD.EmployeeID, 'Delete', NOW(), SESSION_USER());
END//

DELIMITER ;




-- Inserting a new employee performance record
INSERT INTO EmployeePerformance (EmployeeID, PerformanceScore) VALUES ('E123', 85);

-- Updating the performance score
UPDATE EmployeePerformance SET PerformanceScore = 90 WHERE EmployeeID = 'E123';

-- Deleting the employee performance record
DELETE FROM EmployeePerformance WHERE EmployeeID = 'E123';

-- View the logs
SELECT * FROM EmployeeLog;



