CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.train_schedules AS 
    SELECT * FROM read_csv_auto('data/train_schedules.csv');
     
     
CREATE TABLE IF NOT EXISTS staging.sweden_holidays AS
    SELECT * FROM read_csv_auto('data/sweden_holidays.csv');

CREATE SCHEMA IF NOT EXISTS refined;

CREATE TABLE IF NOT EXISTS refined.train_schedules AS 
    SELECT * FROM staging.train_schedules;

CREATE TABLE IF NOT EXISTS refined.sweden_holidays AS
    SELECT * FROM staging.sweden_holidays;

    
