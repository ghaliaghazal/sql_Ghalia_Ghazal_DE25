
CREAT SCHEMA IF NOT EXISTS staging; 



CREATE TABLE IF NOT EXISTS staging.orders AS (
    SELECT * FROM read_csv_auto('data/orders.csv')
    );


    CREATE TABLE IF NOT EXISTS staging.customers AS (
    SELECT * FROM read_csv_auto('data/customers.csv')
    );