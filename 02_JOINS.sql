-- JOINS

-- A relational database consists of multiple related tables linking together using common columns, 
-- which are known as foreign key columns. 
-- Because of this, the data in each table is incomplete from the business perspective.

-- MySQL supports the following types of joins:
-- Inner join
-- Left join
-- Right join
-- Cross join

-- INNER JOIN 
-- Retrieves only the matching data from two tables.
SELECT p1.productName, p1.productLine, p2.textDescription  FROM products p1 INNER JOIN productlines p2 on 
p1.productline = p2.productline;

SELECT productName, productLine, textDescription  FROM products INNER JOIN productlines 
USING(productline);

-- INNER JOIN with GROUPBY
SELECT t1.orderNumber, t1.status, SUM(quantityOrdered * PriceEach) AS Total FROM orders t1 INNER JOIN
orderdetails t2 ON t1.orderNumber = t2.orderNumber GROUP BY orderNumber;

-- Multiple INNER JOINS
SELECT t1.orderNumber, t1.orderDate, t2.orderLineNumber, t3.productName, t2.quantityOrdered, t2.priceEach
FROM orders t1 INNER JOIN orderdetails t2 ON t1.orderNumber = t2.orderNumber 
INNER JOIN products t3 ON t2.productCode = t3.productCode
ORDER BY orderNumber, orderLineNumber;

-- LEFT JOIN
-- Used o retrieve the data from both tables only that matches in both and all data from left table.
-- query to retrieve all the customers and their orders
SELECT t1.CustomerNumber,t1.CustomerName, t2.OrderNumber, t2.`Status` FROM customers t1 LEFT JOIN orders t2 ON
t1.customerNumber = t2.customerNumber;

-- query to retrieve all the unmatched rows
SELECT t1.CustomerNumber,t1.CustomerName, t2.OrderNumber, t2.`Status` FROM customers t1 LEFT JOIN orders t2 ON
t1.customerNumber = t2.customerNumber WHERE t2.OrderNumber IS NULL;

-- LEFT JOIN with multiple tables
SELECT concat(firstname, ' ', lastname) AS fullname, t2.CustomerNumber, t3.checkNumber, t3.amount FROM 
employees t1 LEFT JOIN customers t2 ON t1.employeeNumber = t2.salesRepEmployeeNumber 
LEFT JOIN payments t3 ON t2.customerNumber = t3.customerNumber;

-- RIGHT JOIN
-- Used o retrieve the data from both tables only that matches in both and all data from right table.

SELECT t2.employeeNumber,t1.CustomerNumber FROM customers t1 
RIGHT JOIN employees t2 ON t1.salesRepEmployeeNumber = t2.employeeNumber;

-- RIGHT JOIN with Multiple tables
SELECT concat(firstname, ' ', lastname) AS fullname, t2.CustomerNumber, t3.checkNumber, t3.amount FROM 
employees t1 RIGHT JOIN customers t2 ON t1.employeeNumber = t2.salesRepEmployeeNumber 
RIGHT JOIN payments t3 ON t2.customerNumber = t3.customerNumber;

-- CROSS JOIN
-- Table joining by itself. Used to retrieve data for all combinations of the table.
SELECT CONCAT(m.lastName, ' ', m.firstName) AS Manager, CONCAT(e.lastName, ' ', e.firstName) AS 'Direct report'
FROM employees e
CROSS JOIN employees m ON m.employeeNumber = e.reportsTo
ORDER BY Manager;
















