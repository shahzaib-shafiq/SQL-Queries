--Q1
SELECT *  
    FROM web_events
    WHERE channel IN ('organic', 'adwords')
    AND DATE_PART('YEAR', occurred_at) = 2016
    ORDER BY occurred_at DESC;

---Q2

SELECT
    r.name AS region,
    a.name AS account,
    o.total_amt_usd / (o.total + 0.01)       
    AS unit_price
FROM

    region r
JOIN
    accounts a ON r.id = a.id
JOIN
    orders o ON a.id = o.account_id;

------------------------------------------
SELECT r.name AS "region name",
       a.name AS "account name",
       CASE
           WHEN o.total = 0 THEN o.total_amt_usd / (o.total + 0.01)
           ELSE o.total_amt_usd / o.total
       END AS "unit price"
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id;


--Q-3

SELECT r.name AS region, a.name AS account, s.name AS sales_rep
FROM region r
JOIN accounts a ON r.id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name DESC;
 
-----------------------------------------
SELECT r.name AS "region name",
       s.name AS "sales rep name",
       a.name AS "account name"
FROM sales_reps s
JOIN region r ON s.region_id = r.id
JOIN accounts a ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name ASC;


---Q-4
SELECT r.name AS region,  s.name AS sales_rep,a.name AS account
FROM region r
JOIN accounts a ON r.id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
AND s.name IN(SELECT LEFT(s.name,POSITION(' ' IN s.name)))
ORDER BY a.name DESC;


SELECT
    r.name AS region,
    s.name AS sales_rep_name,
    a.name AS account
FROM
    region r
JOIN
    accounts a ON r.id = a.id
JOIN
    sales_reps s ON a.sales_rep_id = s.id
WHERE
    r.name = 'Midwest'
    AND s.name LIKE 'S%'
ORDER BY
    a.name ASC;
------------------------------------

 SELECT r.name AS "region name",
       s.name AS "sales rep name",
       a.name AS "account name"
FROM sales_reps s
JOIN region r ON s.region_id = r.id
JOIN accounts a ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
  AND s.name LIKE 'S%'
ORDER BY a.name ASC;  


---Q-5

SELECT
    r.name AS region,
    CONCAT(s.first_name, ' ', s.last_name) AS sales_rep_name,
    a.name AS account_name
FROM
    region r
JOIN
    accounts a ON r.id = a.id
JOIN
    sales_reps s ON a.sales_rep_id = s.id
WHERE
    r.name = 'Midwest'
    AND s.last_name LIKE 'K%'
ORDER BY
    a.name ASC;


----Q-6
 SELECT
    r.name AS region,
    a.name AS account,
    o.total_amt_usd / (o.total + 0.01) AS unit_price,
	COUNT(*) AS Total	
	
FROM
    region r
JOIN
    accounts a ON r.id = a.id
JOIN
    orders o ON a.id = o.account_id
WHERE Total > 100;

----------------------------------------
SELECT r.name AS "region name",
       a.name AS "account name",
       o.total_amt_usd / (o.total + 0.01) AS "unit price"
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id
WHERE o.standard_qty > 100;

----Q-7
SELECT
    r.name AS region_name,
    a.name AS account_name,
    o.total_amt_usd / (o.total + 0.01) AS unit_price
FROM
    region r
JOIN
    accounts a ON r.id = a.id
JOIN
    orders o ON a.id = o.account_id
WHERE
    o.standard_qty > 100
    AND o.poster_qty > 50
ORDER BY
    unit_price ASC;


---------------------------------------------
SELECT r.name AS "region name",
       a.name AS "account name",
       o.total_amt_usd / (o.total + 0.01) AS "unit price"
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id
WHERE o.standard_qty > 100
  AND o.poster_qty > 50
ORDER BY "unit price" ASC;


--Q-8

SELECT DISTINCT w.channel,a.name
FROM accounts a
JOIN  web_events w
ON a.id=w.account_id
WHERE a.id=1001


-------------------------------------
SELECT a.name AS "account name",w.channel
FROM accounts a
JOIN orders o ON a.id = o.account_id
JOIN web_events w ON a.id = w.account_id
WHERE a.id = 1001
group by a.name, w.channel;


----Q-9


SELECT w.occurred_at,
a.name, o.total, o.total_amt_usd
FROM web_events w 
JOIN account a 
ON w.account_id=a.id
JOIN orders o
ON a.id=o.account_id
WHERE DATE_PART('YEAR', occurred_at) = 2015

---------------------------------------------

 SELECT o.occurred_at,


       a.name AS "account name",
       o.total AS "order total",
       o.total_amt_usd AS "order total_amt_usd"
FROM orders o
JOIN accounts a ON o.account_id = a.id
WHERE EXTRACT(YEAR FROM o.occurred_at) = 2015;
----Q-10

SELECT a.name, w.channel, COUNT(w.web_events) AS Total_Events
FROM web_events w
INNER JOIN accounts a ON w.account_id = a.id
GROUP BY a.name, w.channel;

--Q-11

SELECT s.name AS sales_rep_name, w.channel, COUNT(w.id) AS number_of_occurrences
FROM web_events w
JOIN accounts a ON w.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY number_of_occurrences DESC;
---------------------------------------------

SELECT a.name AS "account name",
       w.channel,
       COUNT(w.id) AS "# of events"
FROM accounts a
LEFT JOIN web_events w ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY a.name, w.channel;

--Q-12

SELECT
    o.account_id,
    o.total_amt_usd AS total_amount,
    CASE
        WHEN o.total_amt_usd >= 300 THEN 'Large'
        WHEN o.total_amt_usd < 3000 THEN 'Small'
    END AS order_level
FROM
    orders o;

--Q-13
SELECT
    CASE
        WHEN total_items >= 2000 THEN 'At Least 2000'
        WHEN total_items >= 1000 AND total_items < 2000 THEN 'Between 1000 and 2000'
        WHEN total_items < 1000 THEN 'Less than 1000'
    END AS order_category,
    COUNT(*) AS order_count
FROM (
    SELECT
        o.id AS order_id,
        SUM(o.standard_qty + o.gloss_qty + o.poster_qty) AS total_items
    FROM
        orders o
    GROUP BY
        o.id
) AS order_totals
GROUP BY
    order_category
ORDER BY
    order_category;


--Q-14  

SELECT
    CASE
        WHEN total_items >= 2000 THEN 'At Least 2000'
        WHEN total_items BETWEEN 1000 AND 1999 THEN 'Between 1000 and 2000'
        ELSE 'Less than 1000'
    END AS category,
    COUNT(*) AS order_count
FROM
    orders
GROUP BY
    category;


--Q-15
SELECT
    CASE
        WHEN total_items >= 2000 THEN 'At Least 2000'
        WHEN total_items >= 1000 AND total_items < 2000 THEN 'Between 1000 and 2000'
        WHEN total_items < 1000 THEN 'Less than 1000'
    END AS category,
    COUNT(*) AS count_of_orders
FROM (
    SELECT
        o.id AS order_id,
        SUM(o.standard_qty + o.gloss_qty + o.poster_qty) AS total_items
    FROM
        orders o
    GROUP BY
        o.id
) AS order_totals
GROUP BY
    category
ORDER BY
    category;


--Q-16
SELECT
    account_id,
    account_name,
    CASE
        WHEN total_amount_spent >= 2000 THEN 'At Least 2000'
        WHEN total_amount_spent >= 1000 AND total_amount_spent < 2000 THEN 'Between 1000 and 2000'
        WHEN total_amount_spent < 1000 THEN 'Less than 1000'
    END AS spending_category,
    total_amount_spent
FROM (
    SELECT
        a.id AS account_id,
        a.name AS account_name,
        SUM(o.total_amt_usd) AS total_amount_spent
    FROM
        accounts a
    JOIN
        orders o ON a.id = o.account_id
    WHERE
        EXTRACT(YEAR FROM o.occurred_at) IN (2016, 2017)
    GROUP BY
        a.id, a.name
) AS spending_by_customer
ORDER BY
    total_amount_spent DESC;

--Q-17

WITH SalesRepOrderCounts AS (
    SELECT
        sr.name AS sales_rep_name,
        COUNT(o.id) AS total_orders
    FROM
        sales_reps sr
    LEFT JOIN
        accounts a ON sr.id = a.sales_rep_id
    LEFT JOIN
        orders o ON a.id = o.account_id
    GROUP BY
        sr.name
)

SELECT
    sro.sales_rep_name,
    sro.total_orders,
    CASE
        WHEN sro.total_orders > 200 THEN 'top'
        ELSE 'not top'
    END AS performance
FROM
    SalesRepOrderCounts sro
WHERE
    sro.total_orders > 200
ORDER BY
    performance DESC, total_orders DESC, sales_rep_name;


--Q-18
SELECT
    DATE(occurred_at) AS event_day,
    channel,
    COUNT(*) AS count
FROM
    web_events
GROUP BY
    DATE(occurred_at), channel
ORDER BY
    event_day, channel;

--Q-19

--Q-20


