/*
Student: Itua A. Thank-God
Course: IT 143
Assignment: 6.3
Section: Fun with Functions
Script: EC_IT143_6.3_fwf_s5_AI.sql

Create a scalar user-defined function.

The function accepts a ContactName value and returns
the first name from the customer's full name.
*/


-- Create First Name Function
CREATE OR ALTER FUNCTION dbo.udf_ExtractFirstName
(
    @ContactName VARCHAR(100)
)
RETURNS VARCHAR(50)
AS
BEGIN
    -- What does it do? Extracts first name before the space
    DECLARE @FirstName VARCHAR(50);
    SET @FirstName = LEFT(@ContactName, CHARINDEX(' ', @ContactName + ' ') - 1);
    RETURN @FirstName;
END;
GO