-- Window Functions
-- MySQL window functions and their practical applications for solving analytical query challenges.

CREATE TABLE sales_data(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

CREATE TABLE sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales_data(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);

SELECT * FROM sales_data;

SELECT fiscal_year,SUM(sale) FROM sales_data GROUP BY fiscal_year;

-- Like the aggregate functions with the GROUP BY clause, window functions also operate on a subset of rows
-- but they do not reduce the number of rows returned by the query.

SELECT fiscal_year, sales_employee, sale, SUM(sale) OVER (PARTITION BY fiscal_year) AS total FROM sales_data;

-- DENSE RANK 
-- The DENSE_RANK() is a window function that assigns a rank to each row within a partition or result set 
-- with no gaps in ranking values.

SELECT sales_employee, fiscal_year, sale, DENSE_RANK() OVER(PARTITION BY fiscal_year ORDER BY sale DESC)
AS sale_rank FROM sales_data;

-- RANK
-- The RANK() function assigns a rank to each row within the partition of a result set. 
-- The rank of a row is specified by one plus the number of ranks that come before it.

SELECT sales_employee, fiscal_year, sale, RANK() OVER(PARTITION BY fiscal_year ORDER BY sale DESC)
AS sale_rank FROM sales_data;

-- ROW_NUMBER
-- The ROW_NUMBER() is a window function or analytic function that assigns a sequential number to each row 
-- in the result set. The first number begins with one.

SELECT sales_employee, fiscal_year, sale, ROW_NUMBER() OVER(PARTITION BY fiscal_year ORDER BY sale DESC)
AS sale_rank FROM sales_data;

