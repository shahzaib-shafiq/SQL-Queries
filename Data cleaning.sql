SELECT LEFT(primary_poc, 3)
FROM accounts



SELECT LEFT(primary_poc, 3), RIGHT(primary_poc, 3)
FROM accounts

SELECT LENGTH(primary_poc)
FROM accounts

SELECT POSITION(' ' IN primary_poc)
FROM accounts

SELECT 
    primary_poc AS full_name,
    LEFT(primary_poc, POSITION(' ' IN primary_poc) - 1) AS first_name
FROM accounts;



SELECT primary_poc AS full_name, 
UPPER(LEFT(primary_poc, POSITION(' ' IN primary_poc))) AS left_name,
LOWER(RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc))) AS right_name
FROM accounts
AS first_name

SELECT DATE_TRUNC('year', occured_at)
FROM orders

-- Error as it is not string, convert it to string
SELECT LEFT(DATE_TRUNC('year', occurred_at), 4)
FROM orders

-- Extract year from date
SELECT LEFT(DATE_TRUNC('year', occurred_at)::varchar, 4)
FROM orders

-- Extract year, month from date
SELECT LEFT(DATE_TRUNC('month', occurred_at)::varchar, 7)
FROM orders

-- Extract year, month, day from date
SELECT LEFT(DATE_TRUNC('day', occurred_at)::varchar, 10)
FROM orders

-- Extract only months
-- ALERT :: Dont forget to cast date type to carchar
SELECT SUBSTRING(occurred_at::varchar from 6 for 2)
FROM orders

-- Extract only days
SELECT SUBSTRING(occurred_at::varchar from 9 for 2)
FROM orders

-- Common table expression
WITH sq AS
(SELECT CAST(occurred_at AS VARCHAR)
AS date
FROM orders
);

-- Make emails based on name and company name
SELECT LOWER(REPLACE(primary_poc,' ','_')) ||
'@'
|| REPLACE(website, 'www.','')
FROM accounts

-- Password rule: Password first char = first name first character
-- password 2nd char = last name first char
-- 3rd = first name last char
-- 4th = last name last char
-- 5th, 6th, 7th, 8th = company account id
-- next characters = account name
WITH sq AS (
    SELECT 
        a.primary_poc AS full_name, 
        UPPER(LEFT(a.primary_poc, POSITION(' ' IN a.primary_poc))) AS left_name,
        LOWER(RIGHT(a.primary_poc, LENGTH(a.primary_poc) - POSITION(' ' IN a.primary_poc))) AS right_name,
        a.id AS account_id,
        a.name AS account_name
    FROM accounts a
)

SELECT 
    LEFT(left_name, 1) || 
    RIGHT(right_name, 1) || 
    SUBSTRING(left_name FROM 2) || 
    SUBSTRING(right_name FROM 2) || 
    LPAD(account_id::text, 4, '0') || 
    account_name AS modified_name
FROM sq;


-- Don't use where with JOIn its query performance is not best
-- COALESCE -> Replace first null value with some other value

