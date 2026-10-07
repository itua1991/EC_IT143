/*
Student: Itua A Thank-God
Course: IT 143
Assignment: 6.3
Section: Fun with Triggers
Script: EC_IT143_6.3_fwt_s4_AI.sql

Create an AFTER UPDATE trigger.

The trigger automatically updates LastModifiedDate
whenever a customer record is modified.
*/

GO

CREATE TRIGGER dbo.trg_Customers_LastModifiedDate
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET LastModifiedDate = SYSDATETIME()
    FROM dbo.t_w3_schools_customers AS c
    INNER JOIN inserted AS i
        ON c.CustomerID = i.CustomerID;
END;
GO
-- Trigger 1: Last Modified Date
CREATE OR ALTER TRIGGER dbo.trg_t_w3_schools_customers_LastModifiedDate
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    -- What does it do? Updates LastModifiedDate to current date/time when record is updated
    UPDATE t
    SET LastModifiedDate = GETDATE()
    FROM dbo.t_w3_schools_customers t
    INNER JOIN inserted i ON t.CustomerID = i.CustomerID;
END;
GO
-- Trigger 2: Last Modified By (Who)
CREATE OR ALTER TRIGGER dbo.trg_t_w3_schools_customers_LastModifiedBy
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    -- What does it do? Updates LastModifiedBy to server user who made the change
    UPDATE t
    SET LastModifiedBy = SUSER_NAME()
    FROM dbo.t_w3_schools_customers t
    INNER JOIN inserted i ON t.CustomerID = i.CustomerID;
END;
GO

-- OR COMBINED TRIGGER (Better - one trigger does both)
CREATE OR ALTER TRIGGER dbo.trg_t_w3_schools_customers_LastModified
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE t
    SET LastModifiedDate = GETDATE(),
        LastModifiedBy = SUSER_NAME()
    FROM dbo.t_w3_schools_customers t
    INNER JOIN inserted i ON t.CustomerID = i.CustomerID;
END;
GO