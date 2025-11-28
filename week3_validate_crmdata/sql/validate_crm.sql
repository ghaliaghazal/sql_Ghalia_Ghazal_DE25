/* task2 =========
    ==================== */

-- find invalid emails
-- use LIKE operator with wildcards for the old data 

SELECT * FROM staging.crm_old_raw
WHERE NOT email LIKE '%@%.%';

-- use REGEXP functions for the new data
-- because the above query cannot deal with the new data
SELECT * FROM staging.crm_new_raw
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+');

-- combine all three conditions
SELECT * FROM staging.crm_old_raw
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive');

SELECT * FROM staging.crm_new_raw
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive');

/* Task 3 */

CREATE SCHEMA IF NOT EXISTS constrained;

CREATE TABLE IF NOT EXISTS constrained.crm_old (
    customer_id INTEGER UNIQUE,
    name VARCHAR NOT NULL,
    email VARCHAR CHECK(email LIKE '%@%.%'),
    region VARCHAR CHECK(region IN ('EU', 'US')),
    status VARCHAR CHECK (status IN ('active', 'inactive'))
);

CREATE TABLE IF NOT EXISTS constrained.crm_new (
    customer_id INTEGER UNIQUE,
    name VARCHAR NOT NULL,
    email VARCHAR CHECK(regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+')),
    region VARCHAR CHECK(region IN ('EU', 'US')),
    status VARCHAR CHECK (status IN ('active', 'inactive'))
);


INSERT INTO constrained.crm_old 
SELECT * 
FROM staging.crm_old_raw;
WHERE regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') AND
    region IN ('EU', 'US') OR
    status IN ('active', 'inactive');



INSERT INTO constrained.crm_new 
SELECT * 
FROM staging.crm_new_raw;
WHERE regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') AND
    region IN ('EU', 'US') AND
    status IN ('active', 'inactive');


/* Task 4 */

-- How many customers are only in the old CRM system
-- 7 customer are only in the old CRM system

SELECT customer_id
FROM staging.crm_old_raw
EXCEPT 

SELECT customer_id
FROM staging.crm_new_raw

-- How many customers are only in the new CRM system
-- 6 customer are only in the old CRM system

SELECT customer_id
FROM staging.crm_new_raw
EXCEPT 

SELECT customer_id
FROM staging.crm_old_raw

/* Task 5 */

-- subquery 1: customers only in the old crm system
(SELECT *
FROM staging.crm_old_raw
EXCEPT
SELECT *
FROM staging.crm_new_raw)
UNION
-- subquery 2: customers only in the new crm sytem
(SELECT *
FROM staging.crm_new_raw
EXCEPT
SELECT *
FROM staging.crm_old_raw)
UNION
-- subquery 3: customers violating constraints in old crm system
(SELECT * FROM staging.crm_old_raw
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive'))
UNION
-- subquery 4: customers violating constraints in new crm system
(SELECT * FROM staging.crm_new_raw
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive'))