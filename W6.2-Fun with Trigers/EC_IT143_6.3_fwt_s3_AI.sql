/*
Student:Itua A Thank-God
Course: IT 143
Assignment: 6.3
Section: Fun with Triggers
Script: EC_IT143_6.3_fwt_s3_AI.sql

Research and testing:

An AFTER UPDATE trigger can automatically run when
a record is updated.

The trigger can use SYSDATETIME() to record the current
date and time.

The inserted table contains the records affected by
the update.

Research source:
Microsoft Learn - CREATE TRIGGER
*/

SELECT
    CustomerID,
    ContactName,
    LastModifiedDate
FROM dbo.t_w3_schools_customers;

-- Research URL: https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql
-- Test SUSER_NAME() and GETDATE()
SELECT GETDATE() as CurrentDate, SUSER_NAME() as CurrentUser;