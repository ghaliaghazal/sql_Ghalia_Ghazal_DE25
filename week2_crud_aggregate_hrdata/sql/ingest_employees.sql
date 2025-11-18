CREAT SCHEMA IF NOT EXISTS STAGING;
CREATE TABLE IF NOT EXISTS employees AS(
    SELECT
    * 
    FROM 
        read_csv_auto('data/employees.csv')
);