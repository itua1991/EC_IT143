-- EC_IT143_W6.1_My Communities Analysis - FINAL PROJECT
-- Author: Itua, Thank-God
-- Databases: MyFC_Restored and Simpsons_Restored

-- COMMUNITY 1: MyFC
-- Q1: What is total player salary? Expected $475,840,000.00
USE MyFC_Restored;
SELECT SUM(total_player_salary) AS total_player_salary
FROM dbo.tbl_MyFC_Total_Player_Salary;

-- Q2: Highest salary records
SELECT summary_id, total_player_salary
FROM dbo.tbl_MyFC_Total_Player_Salary
ORDER BY total_player_salary DESC;

-- Q3: How many records? Expected 1
SELECT COUNT(*) AS total_salary_summary_records
FROM dbo.tbl_MyFC_Total_Player_Salary;

-- Q4: Salary increase Jan 31 vs Feb 28 2019 with CTE and RANK
DECLARE @StartDate DATE = '2019-01-31';
DECLARE @EndDate DATE = '2019-02-28';
WITH SalaryComparison AS (
    SELECT team_code,
    SUM(CASE WHEN salary_month = @StartDate THEN total_player_salary ELSE 0 END) AS salary_jan,
    SUM(CASE WHEN salary_month = @EndDate THEN total_player_salary ELSE 0 END) AS salary_feb
    FROM dbo.tbl_MyFC_Total_Player_Salary GROUP BY team_code
)
SELECT team_code, (salary_feb - salary_jan) AS salary_increase,
RANK() OVER (ORDER BY (salary_feb - salary_jan) DESC) AS team_rank
FROM SalaryComparison
ORDER BY salary_increase DESC;

-- COMMUNITY 2: Simpsons
-- Q5: Employees per department
USE Simpsons_Restored;
SELECT department, COUNT(*) AS employee_count
FROM dbo.tbl_Simpsons_Employment GROUP BY department;

-- Q6: Active employee - Marge Simpson
SELECT job_title, employment_status, character_name
FROM dbo.tbl_Simpsons_Employment WHERE employment_status = 'Active';

-- Q7: Net amount $172,296.14
SELECT SUM(CASE WHEN transaction_type = 'Income' THEN amount ELSE 0 END) - 
       SUM(CASE WHEN transaction_type = 'Spending' THEN amount ELSE 0 END) AS net_amount
FROM dbo.tbl_Simpsons_Financial_Transactions
WHERE transaction_date BETWEEN '1989-01-01' AND '1991-12-31';

-- Q8: Spending by category with RANK
WITH SpendingByCategory AS (
    SELECT e.character_name, t.category, YEAR(t.transaction_date) AS yr, SUM(t.amount) AS total_spending
    FROM dbo.tbl_Simpsons_Employment e JOIN dbo.tbl_Simpsons_Financial_Transactions t ON e.character_name = t.character_name
    WHERE t.transaction_type = 'Spending' GROUP BY e.character_name, t.category, YEAR(t.transaction_date)
)
SELECT *, RANK() OVER (PARTITION BY yr ORDER BY total_spending DESC) AS spending_rank
FROM SpendingByCategory ORDER BY yr, total_spending DESC;