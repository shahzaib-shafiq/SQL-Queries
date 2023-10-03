--QUESTION 1


SELECT r.name AS region,
       a.name AS account,
       o.total_amt_usd / (o.total + 0.01) AS "unit price"
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id

--QUESTION 2


WITH Monthly_Performance AS (
  SELECT
    total_amt_usd,EXTRACT(month,occured_at) AS month
  FROM accounts a 
  JOIN  orders o ON  a.id=o.account_id
   JOIN web_evnts w ON  a.id=w.account_id
   GROUP BY  total_amt_usd ,month 
    )
SELECT
  -- Return the  earned so far 
  total_amt_usd,month 
  count(Medals) OVER (PARTITION BY total_amt_usd
                        ORDER BY month ASC)
FROM Monthly_Performance
ORDER BY month;

