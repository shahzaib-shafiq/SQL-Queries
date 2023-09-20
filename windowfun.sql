SELECT website,COUNT(website) 
FROM accounts
GROUP BY(website)


--WINDOW FUN

SELECT standard_qty,SUM(standard_qty) OVER (PARTITION BY occurred_at)
from orders




SELECT standard_qty,SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('month',occurred_at))
from orders






SELECT
    standard_qty,
    DATE_TRUNC('month', occurred_at) AS month,
    SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('month', occurred_at)) AS monthly_total,
    SUM(standard_qty) OVER (ORDER BY occurred_at) AS running_total
FROM
    orders;




SELECT 
    standard_qty,
    DATE_TRUNC('month', occurred_at) AS month,
    SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('month', occurred_at) ORDER BY occurred_at) AS sum_monthly,
    SUM(standard_qty) OVER (ORDER BY occurred_at) AS running_total
FROM orders;


SELECT 
    standard_qty,
    DATE_TRUNC('month', occurred_at) AS month,
    SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('month', occurred_at) ORDER BY occurred_at) AS sum_monthly,
    SUM(standard_qty) OVER (ORDER BY occurred_at) AS running_total_sum,
    AVG(standard_qty) OVER (ORDER BY occurred_at) AS running_average,
    MAX(standard_qty) OVER (ORDER BY occurred_at) AS running_max,
    MIN(standard_qty) OVER (ORDER BY occurred_at) AS running_min,
    COUNT(standard_qty) OVER (ORDER BY occurred_at) AS running_count
FROM orders;


WITH sq AS
( 
  SELECT DATE_TRUNC('month', occurred_at) AS month,
  SUM(total_amt_usd) as total_amt_usd
  FROM orders
  GROUP BY 1 
)
SELECT
  month,
  total_amt_usd,
  LEAD(total_amt_usd) OVER (ORDER BY month) AS lead,
  LEAD(total_amt_usd) OVER (ORDER BY month) - total_amt_usd as leaddiff,
  LAG(total_amt_usd) OVER (ORDER BY month) AS lag,
  total_amt_usd - LAG(total_amt_usd) OVER (ORDER BY month) AS lagdiff
FROM sq;





SELECT DATE_TRUNC('month', occurred_at) AS month,

SUM(total_amt_usd) as total_amt_usd
FROM orders
GROUP BY 1 





--common table expression
--lead
--lag



