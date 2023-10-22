-- UNION and UNION ALL

-- UNION
-- MySQL UNION operator allows you to combine two or more result sets of queries into a single result set.
-- First, the number and the orders of columns that appear in all SELECT statements must be the same.
-- Second, the data types of columns must be the same or compatible.

SELECT firstName, lastName FROM employees
UNION
SELECT contactFirstName, contactLastName from customers;

SELECT CONCAT(firstName,' ',lastName) AS employee_fullname FROM employees
UNION
SELECT CONCAT(contactFirstName,' ',contactLastName) AS customer_fullname from customers;

SELECT CONCAT(firstName,' ',lastName) AS employee_fullname, 'Employee' FROM employees
UNION
SELECT CONCAT(contactFirstName,' ',contactLastName) AS customer_fullname, 'Customer' from customers;

-- UNION ALL
SELECT firstName, lastName FROM employees
UNION ALL
SELECT contactFirstName, contactLastName from customers;






