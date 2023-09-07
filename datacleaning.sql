SELECT LEFT(primary_poc,4) from accounts


SELECT RIGHT(primary_poc,4) from accounts


SELECT LEN(name)
FROM  accounts

SELECT LEFT(primary_poc,4) from accounts


SELECT POSITION (' ' IN primary_poc)
from accounts;

SELECT occurred_at 
FROM orders
LIMIT 10


SELECT SUBSTRING(occurred_at,4);
FROM orders
LIMIT 10


SELECT *
FROM  accounts



SELECT occurred_at 
FROM orders
LIMIT 10



SELECT LEN(name)
FROM  accounts

SELECT LEFT (occured_at,LENGTH(occured_at))-POSITION ('',)

SELECT LEFT(primary_poc,4) from accounts


SELECT RIGHT(primary_poc,4) from accounts

SELECT  DATE_TRUNC('year',occured_at)
FROM order

SELECT LEFT(DATE_TRUNC('year',occured_at)::varchar,4)
from orders


SELECT LEFT(DATE_TRUNC('month',occured_at)::varchar,7)

from orders

SELECT LEFT(DATE_TRUNC('day',occured_at)::varchar,10)

from orders






SELECT SUBSTRING(occurred_at::varchar from 6 for 2);
FROM orders

LIMIT 10




SELECT POSITION(' ' IN primary_poc)
from accounts;

SELECT LEFT(primary_poc,POSITION)) IN


SELECT UPPER(LEFT(primary_poc)), POSITION (' ',in primary_pos)  full,name



SELECT occured

SELECT lower(name)
from accounts

WITH sq AS
(SELECT CAST(occured_at AS varchar) AS date
 FROM orders
)

Select date
from sq


--PASSWORD 1ST CHAR OF FNAME

--PASSWORD 1ST CHAR OF LNAME

--PASSWORD last CHAR OF FNAME

--PASSWORD LAST CHAR OF LNAME

--5,6,7,8 IS THE COMPANY ID 



SELECT CONCAT(LEFT(primary_poc,POSITION(' ',IN primar_poc)-1,'.',
				  
				  	(RIGHT(primary_poc,LENGTH(primary_poc)-POSITION(' ') IN primary_poc))),
			  '@',
			  name,
			  '.com') AS EMAIL
			 FROM accounts


SELECT CONCAT(LEFT(primary_poc,POSITION(' ',IN primar_poc)-1,'.',
				  
				  	(RIGHT(primary_poc,LENGTH(primary_poc)-POSITION(' ') IN primary_poc))),
			  '@',
			  name,
			  '.com') AS EMAIL
			 FROM accounts
			 
			 
			 
			 

             WITH sq AS
(
SELECT 
	LEFT(primary_poc,1) ||
	RIGHT(primary_poc,1)||
	SUBSTRING(primary_poc 
			  FROM POSITION(' ' IN primary_poc))
	
	
)
			 
			 
			 
			 