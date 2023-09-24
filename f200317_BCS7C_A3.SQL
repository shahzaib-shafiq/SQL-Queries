--20F-0317

--DS 7C


--Q1


SELECT *  
    FROM web_events
    WHERE channel IN ('organic', 'adwords')
    AND DATE_PART('YEAR', occurred_at) = 2016
    ORDER BY occurred_at DESC;


--Q2

SELECT r.name AS region,
       a.name AS account,
	   o.total_amt_usd / (o.total + 0.01) AS Unit_price
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id;


--Q-3



SELECT r.name AS region,
       s.name AS sales_rep,
       a.name AS account
FROM sales_reps s
JOIN region r  ON s.region_id = r.id
JOIN accounts a  ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name ASC;



--Q-4



 SELECT r.name  AS region,
        s.name  AS sales_rep,
        a.name  AS account
FROM sales_reps s
JOIN region r ON s.region_id = r.id
JOIN accounts a ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
  AND 
LEFT(s.name,POSITION(' ' IN a.name)-1) LIKE 'S%'
ORDER BY a.name ASC;  


--Q-5


SELECT
    r.name AS region,
    s.name AS sales_rep,
    a.name AS account
FROM
    region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON a.sales_rep_id = s.id
WHERE
    r.name = 'Midwest'
    AND RIGHT(a.name, LENGTH(a.name) - POSITION(' ' IN a.name)) LIKE 'K%'
ORDER BY
    a.name ASC;


--Q-6


  
SELECT r.name AS region,
       a.name AS account,
       o.total_amt_usd / (o.total + 0.01) AS unit_price
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id
WHERE o.standard_qty > 100;



----Q-7



SELECT r.name AS region,
       a.name AS account,
       o.total_amt_usd / (o.total + 0.01) AS unit_price
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id
WHERE o.standard_qty > 100
  AND o.poster_qty > 50
ORDER BY unit_price ASC;




--Q-8



    SELECT a.name AS account, w.channel AS channel
    FROM accounts a
    JOIN orders o ON a.id = o.account_id
    JOIN web_events w ON a.id = w.account_id
    WHERE a.id = 1001   
    group by account, channel;




--Q-9



 SELECT o.occurred_at,
      a.name AS account,
       o.total AS order_total,
       o.total_amt_usd AS total_amt_usd
FROM orders o
JOIN accounts a ON o.account_id = a.id
WHERE EXTRACT(YEAR FROM o.occurred_at) = 2015;



--Q-10



SELECT a.name AS Account, w.channel AS Channel, COUNT(*) AS Total_Events
FROM web_events w
JOIN accounts a ON w.account_id = a.id
GROUP BY a.name, w.channel;



--Q-11



SELECT a.name AS account,
       w.channel As channel,
       COUNT(w.id) AS no_of_events
FROM accounts a
LEFT JOIN web_events w ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY a.name, w.channel;



--Q-12

--a

SELECT SUM(tot)
FROM (
    SELECT COUNT(a.id) AS tot
    FROM accounts a
    JOIN sales_reps s ON a.sales_rep_id = s.id
    GROUP BY s.id, s.name
    HAVING COUNT(a.id) > 5
) AS subquery;




--b

SELECT a.name, COUNT(*)
FROM accounts AS a
INNER JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(*) = 
(
SELECT COUNT(*)
FROM orders
GROUP BY account_id
ORDER BY COUNT(*) DESC
LIMIT 1
)



--c


SELECT a.name, SUM(o.total_amt_usd) AS spent
FROM accounts AS a
INNER JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY Spent DESC


--d


SELECT a.name, SUM(o.total_amt_usd) AS most_spent
FROM accounts AS a
INNER JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) = 
(
SELECT MAX(most_spent)
FROM 
(
SELECT SUM(total_amt_usd) AS most_spent
FROM orders
GROUP BY account_id
) AS max_spent
)


--e


SELECT a.name, SUM(o.total_amt_usd) AS most_spent
FROM accounts AS a
INNER JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) = 
(
SELECT MIN(most_spent)
FROM 
(
SELECT SUM(total_amt_usd) AS most_spent
FROM orders
GROUP BY account_id
) AS max_spent
)


--f

SELECT a.name, w.channel, COUNT(*)
FROM accounts AS a
INNER JOIN web_events AS w
ON w.account_id = a.id
GROUP BY a.name, w.channel
HAVING COUNT(*) > 6
AND w.channel LIKE 'facebook'
ORDER BY COUNT(*)



--g


SELECT a.name, w.channel, COUNT(*)
FROM accounts AS a
INNER JOIN web_events AS w
ON w.account_id = a.id
GROUP BY a.name, w.channel
HAVING w.channel LIKE 'facebook'
ORDER BY COUNT(*) DESC
LIMIT 1



--Q-13



SELECT
    account_id,
    SUM(o.total) AS total_amount,
    CASE
        WHEN SUM(o.total) >= 300 AND SUM(o.total) <= 3000  THEN 'SMALL'
        WHEN SUM(o.total) > 3000 THEN 'LARGE'
        
    END AS order_size
FROM
    orders o
JOIN
    accounts a
ON
    a.id = o.account_id
GROUP BY
    account_id;



--Q-14  


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


--Q-15



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





--Q-16



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
		WHERE EXTRACT(YEAR FROM o.occurred_at) IN (2016, 2017)
    GROUP BY
        o.id
) AS order_totals
GROUP BY
    order_category
ORDER BY
    order_category DESC;




--Q-17



WITH SalesCounts AS (
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
    sc.sales_rep_name,
    sc.total_orders,
    CASE
        WHEN sc.total_orders > 200 THEN 'top'
        ELSE 'not top'
    END AS performance
FROM
    SalesCounts sc

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



SELECT
    r.name AS region_name,
    SUM(o.total_amt_usd) AS total_sales,
    COUNT(o.id) AS total_orders
FROM
    region r
JOIN
    sales_reps s ON r.id = s.region_id
JOIN
    accounts a ON s.id = a.sales_rep_id
JOIN
    orders o ON a.id = o.account_id
GROUP BY
    r.name

HAVING
    SUM(o.total_amt_usd) = (
        SELECT MAX(total_sales)
        FROM (
            SELECT
                r.name AS region_name,
                SUM(o.total_amt_usd) AS total_sales
            FROM
                region r
            JOIN
                sales_reps s ON r.id = s.region_id
            JOIN
                accounts a ON s.id = a.sales_rep_id
            JOIN
                orders o ON a.id = o.account_id
            GROUP BY
                r.name
        ) AS RegionSales
    );




--Q-20


WITH RegionSales AS (
    SELECT
        r.name AS region_name,
        SUM(o.total_amt_usd) AS total_sales,
        COUNT(o.id) AS total_orders
    FROM
        region r
    JOIN
        sales_reps s ON r.id = s.region_id
    JOIN
        accounts a ON s.id = a.sales_rep_id
    JOIN
        orders o ON a.id = o.account_id
    GROUP BY
        r.name
)
SELECT
    region_name,
    total_sales,
    total_orders
FROM
    RegionSales
WHERE
    total_sales = (SELECT MAX(total_sales) FROM RegionSales);


