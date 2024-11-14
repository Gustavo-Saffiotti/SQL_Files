-- Script for User Management in MySQL

/* 
This script demonstrates essential user management operations in MySQL, including 
creating, altering, renaming, and deleting users, as well as managing user permissions. 
*/





/* 1. CREATE USER 
Creating users with different levels of access: domain-based, IP-based, and localhost.
*/

-- Create a user with domain-specific access
CREATE USER 'coderhouse'@'dominio' IDENTIFIED BY 'initialPassword';

-- Create a user with IP-based access
CREATE USER 'testUser'@'192.168.0.213' IDENTIFIED BY 'password123';

-- Create a user with localhost access
CREATE USER 'testUser'@'localhost' IDENTIFIED BY 'localPassword';

/* 2. ALTER USER 
Updating the password of an existing user for improved security.
*/

-- Altering the password for 'testUser' at 'localhost'
ALTER USER 'testUser'@'localhost' IDENTIFIED BY 'newSecurePassword';

/* 3. RENAME USER 
Renaming an existing user to change the username or host.
*/

-- Rename 'testUser' to 'coderhouseUser' at 'localhost'
RENAME USER 'testUser'@'localhost' TO 'coderhouseUser'@'dominio';

/* 4. DROP USER 
Removing a user account that is no longer needed.
*/

-- Drop the user 'coderhouseUser' at 'dominio'
DROP USER 'coderhouseUser'@'dominio';

/* 5. GRANT PRIVILEGES 
Granting permissions to users for specific databases and tables.
*/

-- Grant all privileges on all databases to 'coderhouse' at 'dominio'
GRANT ALL PRIVILEGES ON *.* TO 'coderhouse'@'dominio';

-- Grant all privileges on a specific table to 'coderhouse' at 'localhost'
GRANT ALL ON gamer.level_game TO 'coderhouse'@'localhost' WITH GRANT OPTION;

-- Grant specific privileges on a table for selective access
GRANT SELECT, UPDATE ON gamer.level_game TO 'coderhouse'@'localhost';

/* 6. GRANT COLUMN-LEVEL PRIVILEGES 
Granting privileges on specific columns within a table.
*/

-- Grant SELECT and UPDATE privileges only on the 'description' column
GRANT SELECT, UPDATE (description) ON gammers_model.level_game TO 'testUser'@'localhost';

/* 7. REVOKE PRIVILEGES 
Revoking permissions from users to remove their access to certain resources.
*/

-- Revoke all privileges from 'coderhouse' at 'dominio'
REVOKE ALL PRIVILEGES ON *.* FROM 'coderhouse'@'dominio';

-- Revoke only the UPDATE privilege from 'coderhouse' at 'localhost'
REVOKE UPDATE ON *.* FROM 'coderhouse'@'localhost';

/* 8. SHOW GRANTS 
Verifying current permissions granted to a user.
*/

-- Show all privileges granted to the current user
SHOW GRANTS FOR CURRENT_USER();

/* 9. FLUSH PRIVILEGES 
Reload the privileges from the grant tables in the MySQL database after changes.
*/

-- Refresh the privileges to ensure updates take effect
FLUSH PRIVILEGES;
