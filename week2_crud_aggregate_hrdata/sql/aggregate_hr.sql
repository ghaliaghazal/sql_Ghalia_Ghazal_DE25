/* ===============================
   Aggregation
   ======================== */

   -- create a new table

   CREATE TABLE IF NOT EXISTS staging.employees_agg AS(
    SELECT * FROM read_csv_auto('data/more_employees.csv')
    )

-- count distinct departments

    SELECT COUNT(DISTINCT department) 
    FROM staging.more_employees;

    -- analyse salary

    SELECT 
        department,
        ROUND(AVG(monthly_salary_sek)) AS rounded_salary_sek,
    FROM staging.more_employees
    GROUP BY department; 



    SELECT 
        department,
        ROUND(AVG(monthly_salary_sek)) AS average_salary_sek,
        ROUND(MEDIAN(monthly_salary_sek)) AS median_salary_sek,
        ROUND(MIN(monthly_salary_sek)) AS minimum_salary_sek,
        ROUND(max(monthly_salary_sek)) AS maximum_salary_sek,
    FROM staging.more_employees
    GROUP BY department; 



