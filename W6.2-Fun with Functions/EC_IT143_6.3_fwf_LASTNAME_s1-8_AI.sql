/*
Student: AI
Course: IT 143
Assignment: 6.3
Section: Fun with Functions
Script: EC_IT143_6.2_fwf_s1-8_last_AI.sql 

Question:
How can I extract the last name from the ContactName column?

The goal is to create a simple solution that returns
the last name from a customer's full contact name.
*/
--- 
--Q: How to extract last name?
--Ad Hoc for Last Name
SELECT TOP 10
    ContactName,
    LTRIM(RIGHT(ContactName, LEN(ContactName) - CHARINDEX(' ', ContactName))) AS LastName_AdHoc
FROM dbo.t_w3_schools_customers
WHERE CHARINDEX(' ', ContactName) > 0;

-- UDF for Last Name
CREATE OR ALTER FUNCTION dbo.udf_ExtractLastName
(
    @ContactName VARCHAR(100)
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @LastName VARCHAR(50);
    -- Get everything after first space, handles multiple spaces
    SET @LastName = LTRIM(RIGHT(@ContactName, LEN(@ContactName) - CHARINDEX(' ', @ContactName + ' ')));
    -- If no space, return empty
    IF CHARINDEX(' ', @ContactName) = 0 SET @LastName = '';
    RETURN @LastName;
END;
GO

-- Compare Last Name
SELECT TOP 10
    ContactName,
    dbo.udf_ExtractFirstName(ContactName) as FirstName,
    dbo.udf_ExtractLastName(ContactName) as LastName
FROM dbo.t_w3_schools_customers;

-- 0 Results Test for Last Name
WITH cte_Last AS (
    SELECT 
        ContactName,
        LTRIM(RIGHT(ContactName, LEN(ContactName) - CHARINDEX(' ', ContactName))) AS AdHoc,
        dbo.udf_ExtractLastName(ContactName) AS UDF_Result
    FROM dbo.t_w3_schools_customers
    WHERE CHARINDEX(' ', ContactName) > 0
)
SELECT * FROM cte_Last WHERE AdHoc <> UDF_Result;