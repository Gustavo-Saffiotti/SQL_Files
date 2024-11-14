/*Explanation of Commands Used

- **DATE or DATETIME Data Type**: In SQL, dates and times are represented using `DATE` or `DATETIME` data types. To compare or reference dates, you should use the same syntax as string literals, enclosed in single quotes. This is especially important when filtering data based on date ranges.
  
  Example:
    - '2019-01-01' is treated as a date in SQL when comparing or filtering date values.

- **SELECT**: Used to retrieve data from a database.
- **WHERE**: Filters the data based on specific conditions.
- **IN**: Checks if a value matches any in a given list.
- **LIKE**: Filters based on pattern matching.
- **ORDER BY**: Sorts the results based on specified columns.

This script demonstrates various SQL queries filtering data based on `DATE` comparisons and other conditions.

*/

-- All comments for games from 2019 onwards
SELECT *
FROM commentary
WHERE comment_date >= '2019-01-01'  -- Filter comments from 2019 onwards
ORDER BY comment_date;

-- All comments for games prior to 2011
SELECT *
FROM commentary
WHERE comment_date < '2011/01/01'  -- Filter comments before 2011
ORDER BY comment_date DESC;

-- Users and their comments for the game with id_game = 73
SELECT 
    id_game,
    id_system_user,
    commentary
FROM commentary
WHERE id_game = 73;

-- Users and their comments for games whose id_game is NOT 73
SELECT 
    id_game,
    id_system_user,
    commentary
FROM commentary
WHERE id_game != 73;

-- Games with level 1
SELECT *
FROM game
WHERE id_level = 1;

-- Games with level 14 or higher
SELECT *
FROM game
WHERE id_level >= 14;

-- Games with the name 'Riders Republic' or 'The Dark Pictures: House Of Ashes'
SELECT * 
FROM game
WHERE name IN ('Riders Republic', 'The Dark Pictures: House Of Ashes');

-- Games whose name starts with 'Grand'
SELECT *
FROM game 
WHERE name LIKE 'Grand%';

-- Games whose name contains 'field'
SELECT *
FROM game
WHERE name LIKE '%field%';




