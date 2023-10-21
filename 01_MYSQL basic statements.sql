-- In this SQL project, we will deal with the basic to advanced SQL queries 
-- using dataset from MYSQL tutorial.org. Check https://www.mysqltutorial.org/mysql-sample-database.aspx

SHOW DATABASES;        -- query shows all the available databases.
USE classicmodels;     -- query to use the specified database.
SHOW TABLES;           -- query shows all tables present in the classicmodels database.

DESCRIBE customers;    -- query to show ow the table is built.

SELECT * FROM customers;       -- retrieves all data from customers table.
SELECT * FROM employees;       -- retrieves all data from employees table.
SELECT * FROM offices;         -- retrieves all data from offices table.
SELECT * FROM orderdetails;    -- retrieves all data from orderdetails table.
SELECT * FROM orders;          -- retrieves all data from orders table.
SELECT * FROM payments;        -- retrieves all data from payments table.
SELECT * FROM productlines;    -- retrieves all data from productlines table.
SELECT * FROM products;        -- -- retrieves all data from products table.

-- query retrieves only the selected columns from the table.
SELECT contactLastName,contactFirstName,phone,addressLine1,addressLine2,city FROM customers;

-- ORDER BY
-- query retrieves the selected columns with ordered data.
SELECT contactLastName,contactFirstName,phone,addressLine1,addressLine2,city 
FROM customers ORDER BY contactLastName;

-- BY default, the sorting  is done by MYSQL on Ascending order.alter

-- query retrieves the selected columns with ordered data in Descending order.
SELECT contactLastName,contactFirstName,phone,addressLine1,addressLine2,city 
FROM customers ORDER BY contactLastName DESC;

SELECT contactLastName,contactFirstName,phone,addressLine1,addressLine2,city 
FROM customers ORDER BY contactLastName ASC;

-- WHERE clause.
-- query to retrieve the data based on afilter condition specified.
SELECT * FROM orders WHERE status = 'In Process';
SELECT * FROM employees WHERE jobTitle = 'VP Sales';

-- WHERE with AND 
-- query to retrieve data based on two filter conditions
SELECT lastName, firstName, jobTitle, officeCode
FROM employees WHERE jobtitle = 'Sales Rep' AND officeCode = 1;

-- WHERE with ORDER BY.
-- query retrieves all data based on a filter specified and orders by columns given.
SELECT lastName, firstName, jobTitle, officeCode
FROM employees WHERE jobtitle = 'Sales Rep' OR officeCode = 1
ORDER BY officeCode , jobTitle;

-- WHERE with BETWEEN
-- query to retrieve data based on filter condition 
SELECT lastName, firstName, officeCode
FROM employees WHERE officeCode BETWEEN 1 AND 3 ORDER BY officeCode;

-- WHERE with IN
-- query to retreive data based on multiple filter conditions
SELECT lastName, firstName, jobTitle, officeCode
FROM employees WHERE officeCode IN (1,2,3);

-- WHERE with IS NULL
-- query to retrieve all the NULL values specified in a condition
SELECT lastName, firstName, reportsTO
FROM employees WHERE reportsTo IS NULL;

-- DISTINCT 
-- When querying sometimes you may get duplicate rows. To avoid duplicate rows we use DISTINCT.
SELECT DISTINCT lastname from employees ORDER BY lastname ASC;
SELECT DISTINCT city,state FROM customers WHERE state IS NOT NULL ORDER BY city,state;

-- LIKE operator
-- operator is a logical operator that tests whether a string contains a specified pattern or not.
-- query retrieves all data from table where name starts with a
SELECT employeeNumber, lastName, firstName
FROM employees WHERE firstName LIKE 'a%';
 
-- query retrieves all data from table where name ends with a
SELECT employeeNumber, lastName, firstName
FROM employees WHERE firstName LIKE '%a';

-- query retrieves all data from table where name contains on
SELECT employeeNumber, lastName, firstName
FROM employees WHERE firstName LIKE '%on%';

-- query retrieves all data from table where name starts with T and ends with m
SELECT employeeNumber, lastName, firstName
FROM employees WHERE firstName LIKE 'T_M';

-- LIMIT 
-- Used to retrieve data by specified number of rows.
-- query to retrieve data from employees table for 10 rows.
SELECT employeeNumber, lastName, firstName
FROM employees ORDER BY employeeNumber LIMIT 10;

-- query to retrieve data from employees table 10 rows starting from index 10
SELECT employeeNumber, lastName, firstName
FROM employees LIMIT 10,10;




















