/*
Student: Itua A Thank-God
Course: IT 143
Assignment: 6.3
Section: Fun with Triggers
Script: EC_IT143_6.3_fwt_s5_AI.sql

Test the AFTER UPDATE trigger.

The trigger should automatically place the current
date and time into LastModifiedDate after the record
is updated.
*/

-- Test Trigger
-- 1. Check before
SELECT TOP 2 CustomerID, ContactName, LastModifiedDate, LastModifiedBy 
FROM dbo.t_w3_schools_customers;

-- 2. Make an update
UPDATE dbo.t_w3_schools_customers
SET ContactName = ContactName
WHERE CustomerID = 1; -- Update 1 record, set same value to fire trigger

-- 3. Check after - should now have date and user
SELECT TOP 2 CustomerID, ContactName, LastModifiedDate, LastModifiedBy 
FROM dbo.t_w3_schools_customers
WHERE CustomerID = 1;;