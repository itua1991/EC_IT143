
--Student: Itua A.Thank-God
--Course: IT 143
--Assignment: 6.3
--Section: Fun with Functions
--Script: EC_IT143_6.3_fwf_s4_AI.sql

-- Research URL: https://learn.microsoft.com/en-us/sql/t-sql/functions/charindex-transact-sql
-- Tested solution using CHARINDEX + LEFT
--Adding space to handle single names: ContactName + ' '

SELECT 
    ContactName,
    CHARINDEX(' ', ContactName) as SpacePosition,
    LEFT(ContactName, CHARINDEX(' ', ContactName + ' ') - 1) as FirstName
FROM dbo.t_w3_schools_customers;