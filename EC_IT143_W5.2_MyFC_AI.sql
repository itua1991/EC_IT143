
-- EC_IT143_W5.2_MyFC_AI.sql
-- My Communities Analysis: MyFC

USE MyFc_Restored;
GO

/* =========================================================
   Question 1
   Original Author: Itua A. Thank-God
   Stakeholder: MyFC Financial Manager

   What is the total amount of player salary represented by
   all salary summary records in the MyFC database?
   ========================================================= */

SELECT
    SUM(total_player_salary) AS total_player_salary
FROM dbo.tbl_MyFC_Total_Player_Salary;
GO


/* =========================================================
   Question 2
   Original Author: Itua A. Thank-God
   Stakeholder: MyFC Financial Manager

   Which salary summary records have the highest total
   player salary amounts?
   ========================================================= */

SELECT
    salary_summary_id,
    total_player_salary
FROM dbo.tbl_MyFC_Total_Player_Salary
ORDER BY total_player_salary DESC;
GO


/* =========================================================
   Question 3
   Original Author: Itua A. Thank-God
   Stakeholder: MyFC Team Administrator

   How many salary summary records are stored in the
   MyFC database?
   ========================================================= */

SELECT
    COUNT(*) AS salary_summary_record_count
FROM dbo.tbl_MyFC_Total_Player_Salary;
GO


/* =========================================================
   Question 4
   Original Author: Shane Jarvis
   Stakeholder: MyFC Financial Manager

   Which players experienced the largest month-to-date
   salary increase between two selected dates, and how
   does that change vary by team?
   ========================================================= */



DECLARE @StartDate date = '2019-01-31';
DECLARE @EndDate date = '2019-02-28';

WITH PlayerSalaryChanges AS
(
    SELECT
        p.pl_id,
        p.pl_name,
        t.t_code AS team_code,
        start_salary.mtd_salary AS starting_salary,
        end_salary.mtd_salary AS ending_salary,
        end_salary.mtd_salary - start_salary.mtd_salary AS salary_increase
    FROM dbo.tblPlayerDim AS p
    INNER JOIN dbo.tblTeamDim AS t
        ON p.t_id = t.t_id
    INNER JOIN dbo.tblPlayerFact AS start_salary
        ON p.pl_id = start_salary.pl_id
       AND TRY_CONVERT(date, start_salary.as_of_date) = @StartDate
    INNER JOIN dbo.tblPlayerFact AS end_salary
        ON p.pl_id = end_salary.pl_id
       AND TRY_CONVERT(date, end_salary.as_of_date) = @EndDate
)
SELECT
    pl_name,
    team_code,
    starting_salary,
    ending_salary,
    salary_increase,
    RANK() OVER (
        ORDER BY salary_increase DESC
    ) AS overall_rank,
    RANK() OVER (
        PARTITION BY team_code
        ORDER BY salary_increase DESC
    ) AS team_rank
FROM PlayerSalaryChanges
ORDER BY overall_rank, team_code, team_rank;
GO