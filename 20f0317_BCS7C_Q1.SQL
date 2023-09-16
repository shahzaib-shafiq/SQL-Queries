
--20F-0317 7C

--Q1

SELECT o.id,o.total_amt_usd , r.name,COUNT(*) AS Total
FROM orders o
INNER JOIN region r
ON o.id=r.id
GROUP BY o.id

--Q2


WITH largest_sales AS
(
SELECT o.id,o.total_amt_usd , r.name,COUNT(id) AS Total
FROM orders o
INNER JOIN region r
ON o.id=r.id
GROUP BY o.id
)
SELECT  o.id,o.total_amt_usd , r.name,COUNT(id) AS Total
FROM largest_sales


--Q3

SELECT id,occured_at,COUNT(*) , EXTRACT(DAY from occured_at) AS DAY
FROM web_events 
GROUP BY id








--	Q1

WITH RegionSales AS (
    SELECT
        r.id AS region_id,
        r.name AS region_name,
        SUM(o.total_amt_usd) AS total_sales
    FROM
        region r
    JOIN
       sales_reps sr ON r.id = sr.region_id
    JOIN
        accounts a ON sr.id = a.sales_rep_id
    JOIN
        orders o ON a.id = o.account_id
    GROUP BY
        r.id, r.name
)
SELECT
    region_name,
    total_sales,
    (
        SELECT COUNT(*)
        FROM orders o
        JOIN accounts a ON o.account_id = a.id
        JOIN sales_reps sr ON a.sales_rep_id = sr.id
        JOIN RegionSales rs ON sr.region_id = rs.region_id
        WHERE rs.total_sales = (SELECT MAX(total_sales) FROM RegionSales)
    ) AS total_orders_in_region
FROM
    RegionSales
ORDER BY
    total_sales DESC
LIMIT 1;


-------Q-2
SELECT
    DATE_TRUNC('day', occurred_at) AS event_day,
    channel,
    COUNT(*) AS event_count
FROM
    public.web_events
GROUP BY
    event_day, channel
ORDER BY
    event_day, channel;
