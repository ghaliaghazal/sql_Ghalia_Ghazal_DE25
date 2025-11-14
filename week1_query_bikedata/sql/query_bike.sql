

/* 


*/

Execute
DESC; 

Execute
DESC staging.joined_table;



---- SELECT ALL OR SOME  COLUMN 

Execute
select * from staging.joined_table;

Execute
select 
    order_data 
    customer_first_name 
    customer_last_name
    product_name
from staging.joined_table
WHERE customer_first_name = 'Marvin';

--- create a new table for order atatus description 

Execute
CREATE TABLE IF NOT EXISTS staging.status ( 
    order_status INTEGER, 
    order_status_description VARCHAR 
)

Execute
SELECT * FROM staging.status;


Execute
INSERT INTO 
    staging.status
    VALUES 
    (1, 'pending'),
    (2, 'Processing'),
    (3, 'Rejected'),
    (4, 'Completed');
 

 --- the two tables 
 Execute
 SELECT 
j.order_id,
j.order_status,
s.order_status_description
FROM staging.joined_table j 
JOIN staging.status s ON j.order_status = s.order_status 
order_status; 


--- sort the rows by order_status
--- ORDER BY ... ASC DESC
Execute
SELECT 
j.order_id,
j.order_status,
s.order_status_description
FROM staging.joined_table j 
JOIN staging.status s ON j.order_status = s.order_status 
--- order by j.order_status DESC;
ORDER BY j.order_status ASC; 



/* ==============
Investigate unique customers
===================== */

-- DISTINCT
Execute
SELECT DISTINCT order_id 
FROM staging.joined_table
ORDER BY order_id DESC; 


-- find unique values of customer_id
Execute
SELECT DISTINCT customer_id
FROM staging.joined_table
ORDER BY customer_id ASC; 


-- find unique values of customer fullnames
Execute
SELECT DISTINCT customer_first_name, customer_last_name
FROM staging.joined_table
ORDER BY customer_first_name, customer_last_name;


-- it is 'Justina Jenkins' that is the issue 
-- this can be found out by one window function
-- below also shows WHERE clause withh two condition
Execute
SELECT 
  customer_id,
  customer_first_name,
  customer_last_name,
  customer_city
FROM staging.joined_table
WHERE customer_first_name = 'Justina' AND customer_last_name = 'Jenkins'


/* =================
Introduce Aggregation Function 
================= */

-- aggregate over rows
-- there are differernt ways of aggregation (max, min, avg, sum, count)
-- 


--try out other aggregation function
Execute
SELECT 
  ROUND(MIN(quantity*list_price)) AS min_revenue,
  ROUND(MAX(quantity*list_price)) AS max_revenue
FROM staging.joined_table;



/* =================
CASE ... WHEN 
    ====================*/

-- Similar if ... else in other languages

-- we can replace the order_status column to some descriptions

Execute
SELECT 
  order_id,
  product_name,
  
  CASE order_status
    WHEN 1 THEN 'Pending'
    WHEN 2 THEN 'Processing'
    WHEN 3 THEN 'Rejected'
    WHEN 4 THEN 'Completed'
  END AS order_status_descrition
  FROM staging.joined_table;
  