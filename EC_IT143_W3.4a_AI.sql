/*****************************************************************************************************************
NAME:    EC_IT143_W3.4_AI.sql
PURPOSE: Answering 8 user questions using AdventureWorks2022 database

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   ------------------------------------------------------------------------------
1.0     10/07/2026   AI - Initials AI  1. Built script for IT143 W3.4 Assignment - 8 questions answered

RUNTIME: 
45m

NOTES: 
This script answers 8 user questions using AdventureWorks2022 database.
- 2 Marginal Complexity Questions
- 2 Moderate Complexity Questions  
- 2 Increased Complexity Questions
- 2 Metadata Questions
All SQL formatted per LearnSQL.com standards.

******************************************************************************************************************/

-- Q1: Business User - Marginal Complexity (Author: Maria Garcia, Section 1)
-- Question: What are the top 5 most expensive products currently for sale?
SELECT TOP 5
    p.Name AS ProductName,
    p.ListPrice
FROM Production.Product AS p
WHERE p.SellEndDate IS NULL
ORDER BY p.ListPrice DESC;
GO

-- Q2: Business User - Marginal Complexity (Author: John Doe, Section 2)  
-- Question: How many employees does AdventureWorks have in total?
SELECT
    COUNT(*) AS TotalEmployees
FROM HumanResources.Employee AS e
WHERE e.CurrentFlag = 1;
GO

-- Q3: Business User - Moderate Complexity (Author: Sarah Lee, Section 1)
-- Question: What is the total sales amount per territory for 2013?
SELECT
    st.Name AS TerritoryName,
    SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesTerritory AS st
    ON soh.TerritoryID = st.TerritoryID
WHERE YEAR(soh.OrderDate) = 2013
GROUP BY st.Name
ORDER BY TotalSales DESC;
GO

-- Q4: Business User - Moderate Complexity (Author: David Kim, Section 3)
-- Question: List customers and how many orders each has placed, only customers with more than 5 orders.
SELECT
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.Customer AS c
JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, p.FirstName, p.LastName
HAVING COUNT(soh.SalesOrderID) > 5
ORDER BY OrderCount DESC;
GO

-- Q5: Business User - Increased Complexity (Author: Own Question - AI)
-- Question: What are the top 3 product categories by total sales quantity in the last 2 years of data?
SELECT TOP 3
    pc.Name AS CategoryName,
    SUM(sod.OrderQty) AS TotalQuantitySold
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
    ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product AS p
    ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory AS psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory AS pc
    ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE soh.OrderDate >= DATEADD(YEAR, -2, (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader))
GROUP BY pc.Name
ORDER BY TotalQuantitySold DESC;
GO

-- Q6: Business User - Increased Complexity (Author: Own Question - AI)
-- Question: Which salespersons have exceeded their quota and by how much for the most recent year?
SELECT
    pp.FirstName + ' ' + pp.LastName AS SalesPersonName,
    sp.SalesQuota,
    sp.SalesYTD,
    (sp.SalesYTD - sp.SalesQuota) AS AmountOverQuota
FROM Sales.SalesPerson AS sp
JOIN Person.Person AS pp
    ON sp.BusinessEntityID = pp.BusinessEntityID
WHERE sp.SalesYTD > sp.SalesQuota
ORDER BY AmountOverQuota DESC;
GO

-- Q7: Metadata Question (Author: James Wilson, Section 2)
-- Question: What tables exist in the Production schema and how many columns does each have?
SELECT
    t.TABLE_NAME AS TableName,
    COUNT(c.COLUMN_NAME) AS ColumnCount
FROM INFORMATION_SCHEMA.TABLES AS t
JOIN INFORMATION_SCHEMA.COLUMNS AS c
    ON t.TABLE_NAME = c.TABLE_NAME
    AND t.TABLE_SCHEMA = c.TABLE_SCHEMA
WHERE t.TABLE_SCHEMA = 'Production'
    AND t.TABLE_TYPE = 'BASE TABLE'
GROUP BY t.TABLE_NAME
ORDER BY ColumnCount DESC;
GO

-- Q8: Metadata Question (Author: Lisa Chen, Section 1)
-- Question: List all columns in Sales.SalesOrderHeader that allow NULL values and their data types.
SELECT
    COLUMN_NAME AS ColumnName,
    DATA_TYPE AS DataType,
    IS_NULLABLE AS IsNullable
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'Sales'
    AND TABLE_NAME = 'SalesOrderHeader'
    AND IS_NULLABLE = 'YES'
ORDER BY COLUMN_NAME;
GO