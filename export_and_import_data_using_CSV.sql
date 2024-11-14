/*Explanation of Commands Used

- **SELECT INTO OUTFILE**: Exports data from a table to a CSV file. You can specify:
  - **FIELDS TERMINATED BY ','**: Defines the delimiter for separating fields (columns).
  - **OPTIONALLY ENCLOSED BY '"'**: Specifies if the data fields should be enclosed in double quotes.
  - **LINES TERMINATED BY '\n'**: Specifies the line terminator (newline) for the exported file.

- **SET GLOBAL local_infile=1**: Allows the loading of local files into MySQL from the client machine. This command needs to be executed by a user with SUPER privileges.

- **SHOW VARIABLES LIKE 'secure_file_priv'**: Displays the file directory paths that MySQL allows for reading or writing files. This helps to identify where MySQL can load or export files from.

- **LOAD DATA LOCAL INFILE**: Imports data from a local file (in this case, `Productos (mod).csv`) into a specified table (`produtos`). The options used are:
  - **FIELDS TERMINATED BY ';'**: Specifies the delimiter used in the CSV file for fields (in this case, a semicolon).
  - **LINES TERMINATED BY '\r\n'**: Defines the line terminator for the imported CSV file (carriage return and line feed for Windows-style text files).

This script is responsible for exporting data from a table to a CSV file and importing data from a local CSV file into a MySQL table.

*/

-- Export data from the specified table into a CSV file
SELECT * 
INTO OUTFILE '/caminho/do/arquivo.csv'
FIELDS TERMINATED BY ','  -- Field separator
OPTIONALLY ENCLOSED BY '"'  -- Enclose fields in double quotes
LINES TERMINATED BY '\n'  -- Line terminator
FROM nome_da_tabela;

-- Enable loading local files into MySQL
SET GLOBAL local_infile=1;

-- Show the secure file privileges configuration
SHOW VARIABLES LIKE 'secure_file_priv';

-- Import data from a CSV file into the 'produtos' table
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Productos (mod).csv'
INTO TABLE produtos
FIELDS TERMINATED BY ';'  -- Field separator in the CSV file
LINES TERMINATED BY '\r\n';  -- Line terminator in the CSV file
