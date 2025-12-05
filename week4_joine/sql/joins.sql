
Group 1: 

SELECT oi.product_id
FROM staging.products p
JOIN staging.order_items oi
ON oi.product_id = p.product_id;

SELECT oi.product_id
FROM staging.products p
INNER JOIN staging.order_items oi
ON oi.product_id = p.product_id;

SELECT oi.product_id
FROM staging.products p
LEFT JOIN staging.order_items oi
ON oi.product_id = p.product_id;



Group 2:

SELECT oi.product_id
FROM staging.order_items oi
INNER JOIN staging.products p
ON oi.product_id = p.product_id;

SELECT oi.product_id
FROM staging.order_items oi
LEFT JOIN staging.products p
ON oi.product_id = p.product_id;

SELECT oi.product_id
FROM staging.order_items oi
RIGHT JOIN staging.products p
ON oi.product_id = p.product_id;




Group 3:

SELECT *
FROM staging.order_items oi
INNER JOIN staging.products p
ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

SELECT *
FROM staging.order_items oi
RIGHT JOIN staging.products p
ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

