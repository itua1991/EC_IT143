
-- EC_IT143_W5.2_Simpsons_AI.sql
-- My Communities Analysis: Simpsons_Restored

USE Simpsons_Restored;
GO

/* =========================================================
   Question 1
   Original Author: Itua A. Thank-God
   Stakeholder: Family Administrator

   Which family members are currently employed, and how are
   they distributed across departments and job titles?
   ========================================================= */

SELECT
    Name,
    Department,
    Job_Title
FROM dbo.Family_Data
WHERE Status = 'Active'
ORDER BY Department, Job_Title, Name;
GO


/* =========================================================
   Question 2
   Original Author: Itua A. Thank-God
   Stakeholder: Household Financial Coordinator

   What spending or income transactions are associated with
   each family member, and what is the net amount for each
   member?
   ========================================================= */

SELECT
    Member_Name,
    SUM(Credit) AS total_income,
    SUM(Debit) AS total_spending,
    SUM(Credit) - SUM(Debit) AS net_amount
FROM dbo.FBS_Viza_Costmo
GROUP BY Member_Name
ORDER BY net_amount DESC;
GO


/* =========================================================
   Question 3
   Original Author: Itua A. Thank-God
   Stakeholder: Family Administrator

   Which departments have the largest number of active
   employees, and what financial transactions are associated
   with members in those departments?
   ========================================================= */

SELECT
    fd.Department,
    COUNT(DISTINCT fd.Name) AS active_employee_count,
    SUM(f.Credit) AS total_income,
    SUM(f.Debit) AS total_spending,
    SUM(f.Credit) - SUM(f.Debit) AS net_amount
FROM dbo.Family_Data AS fd
LEFT JOIN dbo.FBS_Viza_Costmo AS f
    ON fd.Name = f.Member_Name
WHERE fd.Status = 'Active'
GROUP BY fd.Department
ORDER BY active_employee_count DESC;
GO


/* =========================================================
   Question 4
   Original Author: Shane Jarvis
   Stakeholder: Household Financial Coordinator

   Which family members spend the most money, what categories
   do they spend it on, and how do their spending patterns
   change over time?
   ========================================================= */

WITH FamilySpending AS
(
    SELECT
        Card_Member,
        Category,
        YEAR(Date) AS transaction_year,
        SUM(Amount) AS total_spending
    FROM dbo.Planet_Express
    GROUP BY
        Card_Member,
        Category,
        YEAR(Date)
),
MemberTotals AS
(
    SELECT
        Card_Member,
        SUM(total_spending) AS member_total_spending
    FROM FamilySpending
    GROUP BY Card_Member
)
SELECT
    fs.Card_Member,
    fs.Category,
    fs.transaction_year,
    fs.total_spending,
    mt.member_total_spending
FROM FamilySpending AS fs
INNER JOIN MemberTotals AS mt
    ON fs.Card_Member = mt.Card_Member
ORDER BY
    mt.member_total_spending DESC,
    fs.Card_Member,
    fs.transaction_year,
    fs.total_spending DESC;
GO

