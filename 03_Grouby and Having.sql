-- Clauses in MYSQL

-- GROUP BY
-- The GROUP BY clause groups a set of rows into a set of summary rows by values of columns or expressions. 
-- The GROUP BY clause returns one row for each group. 
-- In other words, it reduces the number of rows in the result set.

-- query used to group the data based on status
SELECT `status` FROM orders GROUP BY status;

-- query used to get the total count per status
SELECT status, COUNT(*) FROM orders GROUP BY `status` ORDER BY `status`;

-- query to get total amount grouped on orderNumber
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS Total_amount FROM orderdetails GROUP BY orderNumber;


-- HAVING Clause
-- The HAVING clause is used in the SELECT statement to specify filter conditions for a group of rows or aggregates.
-- The HAVING clause is often used with the GROUP BY clause to filter groups based on a specified condition.
-- If you omit the GROUP BY clause, the HAVING clause behaves like the WHERE clause.

-- Query to retrieve the total amount greater than 10000 grouped on orderNumber
SELECT orderNumber, SUM(quantityOrdered),SUM(quantityOrdered * priceEach) AS Total_amount
FROM orderdetails GROUP BY orderNumber HAVING Total_amount > 10000;

-- query to retrieve data tha matching in both orderdetails and orders grouped on orderNumber
SELECT a.ordernumber, `status`, SUM(priceeach*quantityOrdered) total
FROM orderdetails a INNER JOIN orders b ON b.ordernumber = a.ordernumber GROUP BY ordernumber, `status`
HAVING status = 'Shipped' AND total > 15000;













