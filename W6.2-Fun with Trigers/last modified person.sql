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