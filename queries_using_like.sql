/*Explanation of Commands Used

- **LIKE**: Used to filter records based on pattern matching.
  - **NOT LIKE**: Excludes records where the pattern matches.
  
  Examples:
    - `'J%'` matches names starting with "J".
    - `'%w%'` matches names containing "w".
    - `'_i%'` matches names where "i" is the second character.
    - `'%ch%'` matches names containing "ch".
    - `NOT LIKE '%ch%'` excludes names containing "ch".

This script demonstrates several queries filtering users based on string patterns in their names or surnames.

*/

-- Users whose first name starts with the letter 'J'
SELECT *
FROM `system_user`
WHERE first_name LIKE 'J%';

-- Users whose last name contains the letter 'W'
SELECT *
FROM `system_user`
WHERE last_name LIKE '%w%';

-- Users whose first name has 'i' in the second position
SELECT *
FROM `system_user`
WHERE first_name LIKE '_i%';

-- Users whose first name ends with the letter 'k'
SELECT *
FROM `system_user`
WHERE first_name LIKE '%k';

-- Users whose first name does not include the letters 'ch'
SELECT *
FROM `system_user`
WHERE first_name NOT LIKE '%ch%';

-- Users whose first name includes only the letters 'ch'
SELECT *
FROM `system_user`
WHERE first_name LIKE '%ch%';
