/*
Student: AI
Course: IT 143
Assignment: 6.3
Section: Fun with Functions
Script: EC_IT143_6.3_fwf_s3_AI.sql

Create an ad hoc query to extract the first name.
*/
-- Ad hoc query for first name
SELECT TOP 10
    ContactName,
    LEFT(ContactName, CHARINDEX(' ', ContactName + ' ') - 1) AS FirstName_AdHoc
FROM dbo.t_w3_schools_customers;