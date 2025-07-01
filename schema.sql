CREATE DATABASE DB;
USE DB;

-- TABLE EMPLOYEES!
CREATE TABLE Employees1 (
    ID INT,
    Name VARCHAR(50),
    DepartmentID INT,
    Salary INT
);

INSERT INTO Employees1 (ID, Name, DepartmentID, Salary) VALUES
(101, 'Alice', 1, 50000),
(102, 'Bob', 2, 60000),
(103, 'Charlie', 3, 70000),
(104, 'David', 3, 80000),
(105, 'Eve', 4, 55000),
(106, 'Frank', 1, 52000),
(107, 'Grace', 2, 58000),
(108, 'Heidi', 4, 61000),
(109, 'Ivan', 3, 75000),
(110, 'Judy', 2, 67000);

-- TABLE EMPLOYEES1 ENDS



-- TABLE DEPARTMENTS STARTS
CREATE TABLE Departments (
    DepartmentID INT,
    DepartmentName VARCHAR(50)
);
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Sales');
-- TABLE DEPARTMENTS ENDS
-- 1. Scalar Subquery in SELECT
SELECT Name, 
    (SELECT AVG(Salary)
     FROM Employees1) AS AvgSalary
FROM Employees1;

-- 2. Subquery in WHERE using IN
SELECT Name 
FROM Employees1 
WHERE DepartmentID IN (
    SELECT DepartmentID 
    FROM Departments 
    WHERE DepartmentName = 'IT'
);

-- 3. Correlated Subquery
SELECT Name 
FROM Employees1 e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees1
    WHERE DepartmentID = e.DepartmentID
);

-- 4. Subquery in FROM clause (Derived Table)
SELECT DepartmentID, AvgSalary
FROM (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees1
    GROUP BY DepartmentID
) AS DeptAvg;


-- 5. Subquery with EXISTS
SELECT Name
FROM Employees1 e
WHERE EXISTS (
    SELECT 1
    FROM Departments d
    WHERE d.DepartmentID = e.DepartmentID
    AND d.DepartmentName = 'HR'
);



