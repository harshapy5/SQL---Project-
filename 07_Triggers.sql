-- TRIGGERS

-- In MySQL, a trigger is a stored program invoked automatically in response to an event such as insert,update,
-- or delete that occurs in the associated table. For example, you can define a trigger that is invoked 
-- automatically before a new row is inserted into a table.
-- MySQL supports triggers that are invoked in response to the INSERT, UPDATE or DELETE event.

-- MySQL BEFORE INSERT triggers are automatically fired before an insert event occurs on the table.

CREATE TABLE WorkCenters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE WorkCenterStats(
    totalCapacity INT NOT NULL
);

DELIMITER $$
CREATE TRIGGER before_workcentres_insert 
BEFORE INSERT 
ON WorkCenters FOR EACH ROW
BEGIN
DECLARE rowcount INT;
SELECT COUNT(*) INTO rowcount FROM WorkCenterStats;
IF rowcount > 0 THEN
        UPDATE WorkCenterStats
        SET totalCapacity = totalCapacity + new.capacity;
    ELSE
        INSERT INTO WorkCenterStats(totalCapacity)
        VALUES(new.capacity);
    END IF; 
END $$

INSERT INTO WorkCenters(name, capacity)
VALUES('Mold Machine',100);
SELECT * FROM WorkCenterStats;

INSERT INTO WorkCenters(name, capacity)
VALUES('Packing',200);
SELECT * FROM WorkCenterStats

-- AFTER INSERT
-- MySQL AFTER INSERT triggers are automatically invoked after an insert event occurs on the table.

CREATE TABLE members (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    birthDate DATE,
    PRIMARY KEY (id)
);

CREATE TABLE reminders (
    id INT AUTO_INCREMENT,
    memberId INT,
    message VARCHAR(255) NOT NULL,
    PRIMARY KEY (id , memberId)
);

DELIMITER $$
CREATE TRIGGER after_members_insert
AFTER INSERT
ON members FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
        INSERT INTO reminders(memberId, message)
        VALUES(new.id,CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    END IF;
END$$

INSERT INTO members(name, email, birthDate)
VALUES
    ('John Doe', 'john.doe@example.com', NULL),
    ('Jane Doe', 'jane.doe@example.com','2000-01-01');
    
SELECT * FROM members;
SELECT * FROM reminders;

-- BEFOR UPDATE
-- MySQL BEFORE UPDATE triggers are invoked automatically before an update event occurs on the table associated with the triggers.

CREATE TABLE sales (
    id INT AUTO_INCREMENT,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    fiscalYear SMALLINT NOT NULL,
    fiscalMonth TINYINT NOT NULL,
    CHECK(fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK(fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >=0),
    UNIQUE(product, fiscalYear, fiscalMonth),
    PRIMARY KEY(id)
);

INSERT INTO sales(product, quantity, fiscalYear, fiscalMonth)
VALUES
    ('2003 Harley-Davidson Eagle Drag Bike',120, 2020,1),
    ('1969 Corvair Monza', 150,2020,1),
    ('1970 Plymouth Hemi Cuda', 200,2020,1);

SELECT * FROM sales;

DELIMITER $$
CREATE TRIGGER before_salesupdate
BEFORE UPDATE
ON sales FOR EACH ROW
BEGIN
	DECLARE errormessage VARCHAR(300);
    SET errormessage = CONCAT('The new quantity', NEW.quantity, 'cannot be 3 times greater than old
							  quantity', OLD.quantity);
                              
	IF NEW.quantity > OLD.quantity * 3 THEN SIGNAL SQLSTATE '45000' SET message_text = errormessage;
    END IF;
    END $$
    
-- AFTER UPDATE
-- MySQL AFTER UPDATE triggers are invoked automatically after an update event occurs on the table associated with the triggers.

CREATE TABLE Sales1 (
    id INT AUTO_INCREMENT,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    fiscalYear SMALLINT NOT NULL,
    fiscalMonth TINYINT NOT NULL,
    CHECK(fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK(fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >=0),
    UNIQUE(product, fiscalYear, fiscalMonth),
    PRIMARY KEY(id)
);

INSERT INTO Sales1(product, quantity, fiscalYear, fiscalMonth)
VALUES
    ('2001 Ferrari Enzo',140, 2021,1),
    ('1998 Chrysler Plymouth Prowler', 110,2021,1),
    ('1913 Ford Model T Speedster', 120,2021,1);
    
CREATE TABLE SalesChanges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    salesId INT,
    beforeQuantity INT,
    afterQuantity INT,
    changedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER after_sales_update
AFTER UPDATE
ON sales1 FOR EACH ROW
BEGIN
    IF OLD.quantity <> new.quantity THEN
        INSERT INTO SalesChanges(salesId,beforeQuantity, afterQuantity)
        VALUES(old.id, old.quantity, new.quantity);
    END IF;
END$$

UPDATE Sales1 
SET quantity = 350
WHERE id = 1;

SELECT * FROM sales1;
SELECT * FROM saleschanges;

-- BEFORE DELETE
-- MySQL BEFORE DELETE triggers are fired automatically before a delete event occurs in a table.

CREATE TABLE Salaries (
    employeeNumber INT PRIMARY KEY,
    validFrom DATE NOT NULL,
    amount DEC(12 , 2 ) NOT NULL DEFAULT 0
);

CREATE TABLE SalaryArchives (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employeeNumber INT ,
    validFrom DATE NOT NULL,
    amount DEC(12 , 2 ) NOT NULL DEFAULT 0,
    deletedAt TIMESTAMP DEFAULT NOW()
);

DELIMITER $$
CREATE TRIGGER before_salaries_delete
BEFORE DELETE
ON salaries FOR EACH ROW
BEGIN
    INSERT INTO SalaryArchives(employeeNumber,validFrom,amount)
    VALUES(OLD.employeeNumber,OLD.validFrom,OLD.amount);
END$$  

DELETE FROM salaries WHERE employeeNumber = 1002;  

-- AFTER DELETE

INSERT INTO Salaries1(employeeNumber,salary)
VALUES
    (1002,5000),
    (1056,7000),
    (1076,8000);
    
CREATE TABLE SalaryBudgets(
    total DECIMAL(15,2) NOT NULL
);

INSERT INTO SalaryBudgets(total)
SELECT SUM(salary) 
FROM Salaries1;

SELECT * FROM SalaryBudgets

CREATE TRIGGER after_delete_salaries
AFTER DELETE
ON Salaries1 FOR EACH ROW
UPDATE SalaryBudgets 
SET total = total - old.salary;





