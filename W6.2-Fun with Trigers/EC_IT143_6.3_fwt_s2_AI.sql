/*
Student: AI
Course: IT 143
Assignment: 6.3
Section: Fun with Triggers
Script: EC_IT143_6.3_fwt_s2_AI.sql

The next logical step is to add a column to the table
that can store the date and time when a record is modified.

After the column is available, an AFTER UPDATE trigger
can automatically update the value.
*/

ALTER TABLE dbo.t_w3_schools_customers
ADD LastModifiedDate DATETIME2 NULL;