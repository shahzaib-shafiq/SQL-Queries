1)SELECT *
FROM web_events
WHERE (channel = 'organic' OR channel = 'adwords')
  AND EXTRACT(YEAR FROM occurred_at) = 2016
ORDER BY occurred_at DESC;

2) SELECT r.name AS "region name",
       a.name AS "account name",
       CASE
           WHEN o.total = 0 THEN o.total_amt_usd / (o.total + 0.01)
           ELSE o.total_amt_usd / o.total
       END AS "unit price"
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id;


3)SELECT r.name AS "region name",
       s.name AS "sales rep name",
       a.name AS "account name"
FROM sales_reps s
JOIN region r ON s.region_id = r.id
JOIN accounts a ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name ASC;

4) SELECT r.name AS "region name",
       s.name AS "sales rep name",
       a.name AS "account name"
FROM sales_reps s
JOIN region r ON s.region_id = r.id
JOIN accounts a ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
  AND s.name LIKE 'S%'
ORDER BY a.name ASC;

5)SELECT r.name AS "region_name",
       CONCAT(SUBSTRING(s.name, POSITION(' ' IN s.name) - 8)) AS "sales_rep_name",
       a.name AS "account_name"
FROM sales_reps s
JOIN region r ON s.region_id = r.id 
JOIN accounts a ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
  AND SUBSTRING(s.name, POSITION(' ' IN s.name) + 1) LIKE 'K%'
GROUP BY sales_rep_name,region_name,account_name
ORDER BY a.name ASC;

6)SELECT r.name AS "region name",
       a.name AS "account name",
       o.total_amt_usd / (o.total + 0.01) AS "unit price"
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id
WHERE o.standard_qty > 100;

7)SELECT r.name AS "region name",
       a.name AS "account name",
       o.total_amt_usd / (o.total + 0.01) AS "unit price"
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id
WHERE o.standard_qty > 100
  AND o.poster_qty > 50
ORDER BY "unit price" ASC;

8)SELECT a.name AS "account name",w.channel
FROM accounts a
JOIN orders o ON a.id = o.account_id
JOIN web_events w ON a.id = w.account_id
WHERE a.id = 1001
group by a.name, w.channel;

9) SELECT o.occurred_at,
       a.name AS "account name",
       o.total AS "order total",
       o.total_amt_usd AS "order total_amt_usd"
FROM orders o
JOIN accounts a ON o.account_id = a.id
WHERE EXTRACT(YEAR FROM o.occurred_at) = 2015;

10)SELECT a.name AS "account name",
       w.channel,
       COUNT(w.id) AS "# of events"
FROM accounts a
LEFT JOIN web_events w ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY a.name, w.channel;

11)SELECT s.name AS "sales rep name",
       w.channel,
       COUNT(w.id) AS "number of occurrences"
FROM sales_reps s
JOIN accounts a ON s.id = a.sales_rep_id
LEFT JOIN web_events w ON a.id = w.account_id
GROUP BY s.name, w.channel
ORDER BY "number of occurrences" DESC;

12a)SELECT sales_rep_id AS "Sales Rep ID",
       COUNT(id) AS "Number of Accounts Managed"
FROM accounts
GROUP BY sales_rep_id
HAVING COUNT(id) > 5;

12b)SELECT account_id, COUNT(id) AS number_of_orders
FROM orders
GROUP BY account_id
ORDER BY number_of_orders DESC
LIMIT 1;

12C)
SELECT account_id, SUM(total_amt_usd) AS orders_total
FROM orders
GROUP BY account_id
HAVING SUM(total_amt_usd) > 30000;

12d)
SELECT account_id, SUM(total_amt_usd) AS orders_total
FROM orders
GROUP BY account_id
ORDER BY orders_total DESC
LIMIT 1;

12E)
SELECT account_id, SUM(total_amt_usd) AS orders_total
FROM orders
GROUP BY account_id
ORDER BY orders_total ASC
LIMIT 1;

12F)
SELECT account_id, COUNT(*) AS Conatacted_by_Facebook
FROM web_events
WHERE channel = 'facebook'
GROUP BY account_id
HAVING COUNT(*) > 6;

12g)SELECT account_id, COUNT(*) AS Contacted_by_Facebook
FROM web_events
WHERE channel = 'facebook'
GROUP BY account_id
ORDER BY Contacted_by_Facebook DESC
LIMIT 1;

13)SELECT
    o.account_id,
    SUM(o.total) AS total_amount,
    CASE
        WHEN SUM(o.total) >= 300 AND SUM(o.total) <= 3000 THEN 'Small'
        WHEN SUM(o.total) > 3000 THEN 'Large'
        ELSE 'Small'
    END AS order_size
FROM
    orders o
JOIN
    accounts a
ON
    a.id = o.account_id
GROUP BY
    o.account_id;

14)SELECT
   CASE
        WHEN total >= 2000 THEN 'At Least 2000'
        WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
        ELSE 'Less than 1000'
    END AS order_category,
    COUNT(*) AS order_count
FROM (
    SELECT
        o.id AS order_id,
        SUM(o.standard_qty + o.gloss_qty + o.poster_qty) AS total
    FROM
        orders o
    GROUP BY
        o.id
) AS modified_order_totals
GROUP BY
    order_category
ORDER BY
    order_category;


15)SELECT
    CASE
        WHEN total >= 2000 THEN 'At Least 2000'
        WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
        ELSE 'Less than 1000'
    END AS category,
    COUNT(id) AS order_count
FROM
    orders
GROUP BY
    category
ORDER BY
    category;

16)
SELECT
    CASE
        WHEN total >= 2000 THEN 'At Least 2000'
        WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
        ELSE 'Less than 1000'
    END AS order_category,
    COUNT(*) AS order_count
FROM (
    SELECT
        o.id AS order_id,
        SUM(o.standard_qty + o.gloss_qty + o.poster_qty) AS total
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

17)SELECT
    s.name AS "sales rep name",
    COUNT(o.id) AS "total number of orders",
    CASE
        WHEN COUNT(o.id) > 200 THEN 'top'
        ELSE 'not top'
    END AS "top_orders"
FROM
    sales_reps s
LEFT JOIN
    accounts a
ON
    s.id = a.sales_rep_id
LEFT JOIN
    orders o
ON
    a.id = o.account_id
GROUP BY
    s.name
HAVING
    COUNT(o.id) > 200
ORDER BY
    "top_orders" DESC, "total number of orders" DESC;
	
	
18)SELECT
    DATE(occurred_at) AS event_date,
    channel AS event_channel,
    COUNT(id) AS event_count
FROM
    web_events
GROUP BY
    event_date,
    event_channel
ORDER BY
    event_date,
    event_channel;

19)SELECT
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
        SELECT MAX(total)
        FROM (
            SELECT
                r.name AS sub_region_name,
                SUM(o.total_amt_usd) AS total
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
        ) AS SubRegionSales
    );


20)WITH SubRegionSales AS (
    SELECT
        r.name AS sub_region_name,
        SUM(o.total_amt_usd) AS total
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
    SUM(o.total_amt_usd) = (SELECT MAX(total) FROM SubRegionSales);






