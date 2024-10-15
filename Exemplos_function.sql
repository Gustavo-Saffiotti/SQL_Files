DELIMITER //

CREATE FUNCTION GetJobSatisfactionLevel (
    empID VARCHAR(20)
)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE satisfactionLevel VARCHAR(255);
    
    -- Seleciona o nível de satisfação no trabalho do funcionário com o ID fornecido
    SELECT JobSatisfactionLevel
    INTO satisfactionLevel
    FROM EmployeePerformance
    WHERE EmployeeID = empID;

    -- Retorna o nível de satisfação
    RETURN satisfactionLevel;
END //

DELIMITER ;

-- Exemplo de chamada da função
SELECT GetJobSatisfactionLevel('E001777') AS JobSatisfactionLevel;






DELIMITER //

CREATE FUNCTION CountHighManagerRatings (
    deptName VARCHAR(100),
    minRating INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE countEmployees INT;

    -- Conta os funcionários com avaliação de gerente superior ao minRating no departamento especificado
    SELECT COUNT(*) 
    INTO countEmployees
    FROM EmployeePerformance
    WHERE Department = deptName
    AND ManagerRating > minRating;

    -- Retorna o número de funcionários
    RETURN countEmployees;
END //

DELIMITER ;

-- Exemplo de chamada da função
SELECT CountHighManagerRatings('Marketing', 3) AS NumHighRatedEmployees;
