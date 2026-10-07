/*
Student: Itua A Thank-God
Course: IT 143
Assignment: 6.3
Section: Fun with Functions
Script: EC_IT143_6.3_fwf_s7_AI.sql

Test the scalar function against the original
ad hoc query.

Expected result:
0 rows.

If zero rows are returned, the function produces
the same results as the ad hoc query.
*/

-- 0 Results Expected Test using CTE
-- If function works, this should return 0 rows
WITH cte_Test AS (
    SELECT 
        ContactName,
        LEFT(ContactName, CHARINDEX(' ', ContactName + ' ') - 1) AS AdHoc,
        dbo.udf_ExtractFirstName(ContactName) AS UDF_Result
    FROM dbo.t_w3_schools_customers
)
SELECT * FROM cte_Test
WHERE AdHoc <> UDF_Result; -- Should be 0 rows if both match