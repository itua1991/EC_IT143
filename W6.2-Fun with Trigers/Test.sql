--SELECT
--    CustomerID,
--    ContactName,
--    LastModifiedDate,
--    LastModifiedBy
--FROM dbo.t_w3_schools_customers
--WHERE CustomerID = 1;

--UPDATE dbo.t_w3_schools_customers
--SET ContactName = ContactName
--WHERE CustomerID = 1;

--SELECT
--    CustomerID,
--    ContactName,
--    LastModifiedDate,
--    LastModifiedBy
--FROM dbo.t_w3_schools_customers
--WHERE CustomerID = 1;

--SELECT
--    name,
--    is_disabled
--FROM sys.triggers
--WHERE parent_id = OBJECT_ID('dbo.t_w3_schools_customers');



--DROP TRIGGER IF EXISTS dbo.trg_t_w3_schools_customers_LastModifiedBy;
--DROP TRIGGER IF EXISTS dbo.trg_Customers_LastModified;
--GO


--SELECT
--    name,
--    is_disabled
--FROM sys.triggers
--WHERE parent_id = OBJECT_ID('dbo.t_w3_schools_customers');



CREATE TRIGGER dbo.trg_Customers_LastModified
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET
        LastModifiedDate = SYSDATETIME(),
        LastModifiedBy = SUSER_NAME()
    FROM dbo.t_w3_schools_customers AS c
    INNER JOIN inserted AS i
        ON c.CustomerID = i.CustomerID;
END;
GO



SELECT
    CustomerID,
    ContactName,
    LastModifiedDate,
    LastModifiedBy
FROM dbo.t_w3_schools_customers
WHERE CustomerID = 1;

UPDATE dbo.t_w3_schools_customers
SET ContactName = ContactName
WHERE CustomerID = 1;

SELECT
    CustomerID,
    ContactName,
    LastModifiedDate,
    LastModifiedBy
FROM dbo.t_w3_schools_customers
WHERE CustomerID = 1;