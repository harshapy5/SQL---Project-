-- STORED PROCEDURES

-- Query to retrieve data from customers table
SELECT customerName, city, state, postalCode, country
FROM customers ORDER BY customerName;

-- When you use MySQL Workbench or mysql shell to issue the query to MySQL Server, MySQL processes the query and returns the result set.
-- If you want to save this query on the database server for execution later, one way to do it is to use a stored procedure.

-- Same sql with stored procedure

DELIMITER $$
CREATE PROCEDURE GetCustomers()
BEGIN
	  SELECT customerName, city, state, postalCode, country
      FROM customers ORDER BY customerName; 
END$$
DELIMITER ;

CALL GetCustomers();

-- STORED PROCEDURE with Parameters

-- IN parameters
-- IN is the default mode. When you define an IN parameter in a stored procedure, the calling program has to pass an argument to the stored procedure.
-- In addition, the value of an IN parameter is protected. It means that even if you change the value of the IN parameter inside the stored procedure
-- its original value is unchanged after the stored procedure ends. In other words, the stored procedure only works on the copy of the IN parameter.

DELIMITER $$
CREATE PROCEDURE office_by_country(IN CountryName VARCHAR(30))
BEGIN
	SELECT * FROM offices WHERE country = CountryName;
END$$

CALL office_by_country('USA');

-- OUT parameters
-- The value of an OUT parameter can be changed inside the stored procedure and its new value is passed back to the calling program.

DELIMITER $$
CREATE PROCEDURE GetOrderCountByStatus (
	IN  orderStatus VARCHAR(25),
	OUT total INT)
BEGIN
	SELECT COUNT(orderNumber) INTO total FROM orders WHERE status = orderStatus;
END$$
DELIMITER ;

CALL GetOrderCountByStatus('Shipped',@total);
SELECT @total;

-- INOUT parameters
-- An INOUT  parameter is a combination of IN and OUT parameters. 
-- It means that the calling program may pass the argument, and the stored procedure can modify the INOUT parameter, and pass the new value back to the calling program.

DELIMITER $$
CREATE PROCEDURE SetCounter(
	INOUT counter INT,
    IN inc INT)
BEGIN
	SET counter = counter + inc;
END$$
DELIMITER ;

SET @counter = 1;
CALL SetCounter(@counter, 1);
SELECT @counter;

-- STORED PROCEDURE with Conditional Statements
DELIMITER $$
CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL(10,2) DEFAULT 0;
    
    SELECT creditLimit INTO credit FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    END IF;
END$$
DELIMITER ;

CALL GetCustomerLevel(141,@level);
SELECT @level;

-- STORED PROCEDURE with CASE statements
DELIMITER $$
CREATE PROCEDURE GetCustomerShipping(
	IN  pCustomerNUmber INT, 
	OUT pShipping VARCHAR(50))
BEGIN
    DECLARE customerCountry VARCHAR(100);
SELECT country INTO customerCountry FROM customers
WHERE customerNumber = pCustomerNUmber;
	CASE customerCountry WHEN  'USA' THEN SET pShipping = '2-day Shipping';
		WHEN 'Canada' THEN SET pShipping = '3-day Shipping';
		ELSE SET pShipping = '5-day Shipping';
	END CASE;
END$$
DELIMITER ;

CALL GetCustomerShipping(121,@pShipping);
SELECT @pShipping;




