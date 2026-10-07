/*
Student: Itua A Thank-God
Course: IT 143
Assignment: 6.3
Section: Fun with Functions
Script: EC_IT143_6.3_fwf_s6_AI.sql

Compare the original ad hoc query with the
user-defined scalar function.

Both methods should return the same first name.
*/
-- Compare UDF vs Ad Hoc
SELECT TOP 10
    ContactName,
    LEFT(ContactName, CHARINDEX(' ', ContactName + ' ') - 1) AS AdHoc_FirstName,
    dbo.udf_ExtractFirstName(ContactName) AS UDF_FirstName
FROM dbo.t_w3_schools_customers;