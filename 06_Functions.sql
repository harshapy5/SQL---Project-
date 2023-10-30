-- FUNCTIONS

-- A stored function is a special kind of stored program that returns a single value. Typically, 
-- you use stored functions to encapsulate common formulas or business rules that are reusable among SQL statements or stored programs.
-- Different from a stored procedure, you can use a stored function in SQL statements wherever an expression is
-- used. This helps improve the readability and maintainability of the procedural code.

DELIMITER $$
CREATE FUNCTION CustomerLevel(credit DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN	
	DECLARE customerlevel VARCHAR(20);
    IF credit > 50000 THEN
		SET customerLevel = 'PLATINUM';
    ELSEIF (credit >= 50000 AND 
			credit <= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSEIF credit < 10000 THEN
        SET customerLevel = 'SILVER';
	END IF;
    RETURN (customerlevel);
END $$

-- Calling a Function in SELECT statement.

SELECT CustomerName, creditlimit, CustomerLevel(creditlimit) FROM customers ORDER BY CustomerName;

-- We can modify the functions and drop the functions.

DELIMITER $$
CREATE FUNCTION OrderLeadTime(orderDate DATE, requiredDate DATE)
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN orderDate - requiredDate;
END $$

SELECT orderDate,requiredDate,OrderLeadTime(orderDate, requiredDate) FROM orders;

DROP FUNCTION OrderLeadTime();  -- Drops the Function from the Database.


