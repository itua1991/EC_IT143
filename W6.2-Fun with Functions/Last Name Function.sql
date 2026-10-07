/*
    EC_IT143 6.3 Fun with Functions
    Last Name Function
    Author: AI
    Date: 2026-10-05

    Purpose:
    Return the last name from ContactName by extracting
    the text after the final space.
*/

CREATE OR ALTER FUNCTION dbo.ufn_GetLastName
(
    @ContactName NVARCHAR(100)
)
RETURNS NVARCHAR(100)
AS
BEGIN

    RETURN RIGHT(
        @ContactName,
        CHARINDEX(' ', REVERSE(@ContactName + ' ')) - 1
    );

END;