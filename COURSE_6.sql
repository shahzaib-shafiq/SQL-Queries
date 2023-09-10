CH 1 

 -- Select all columns from the TABLES system database
 SELECT * 
 FROM INFORMATION_SCHEMA.TABLES
 -- Filter by schema
 WHERE table_schema = 'public';


 -- Select all columns from the COLUMNS system database
 SELECT * 
 FROM INFORMATION_SCHEMA.COLUMNS
 WHERE table_name = 'actor'

SELECT
    column_name, 
    data_type
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'customer';


SELECT
	rental_date,
	return_date,
	rental_date + INTERVAL '3 DAY' AS expected_return_date
FROM rental;


SELECT
	rental_date,
	return_date,
	rental_date + INTERVAL '3 DAY' AS expected_return_date
FROM rental;

-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film;

-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film
-- Use the array index of the special_features column
WHERE special_features[1] = 'Trailers';

-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film
-- Use the array index of the special_features column
WHERE special_features[2] = 'Deleted Scenes';

SELECT
  title, 
  special_features 
FROM film 
WHERE 'Trailers' = ANY(special_features);


SELECT 
  title, 
  special_features 
FROM film 
-- Filter where special_features contains 'Deleted Scenes'
WHERE special_features @> ARRAY['Deleted Scenes'];


--CHAP 2


SELECT f.title, f.rental_duration,
    -- Calculate the number of days rented
    r.rental_date - r.return_date AS days_rented
FROM film AS f
     INNER JOIN inventory AS i ON f.film_id = i.film_id
     INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
ORDER BY f.title;



SELECT f.title, f.rental_duration,
    -- Calculate the number of days rented
    r.return_date - r.rental_date AS days_rented
FROM film AS f
     INNER JOIN inventory AS i ON f.film_id = i.film_id
     INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
ORDER BY f.title;

SELECT f.title, f.rental_duration,
    -- Calculate the number of days rented
	AGE(return_date,rental_date) AS days_rented
FROM film AS f
	INNER JOIN inventory AS i ON f.film_id = i.film_id
	INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
ORDER BY f.title;



SELECT
    f.title,
 	-- Convert the rental_duration to an interval
    INTERVAL '1' day * f.rental_duration,
 	-- Calculate the days rented as we did previously
    r.return_date - r.rental_date AS days_rented
FROM film AS f
    INNER JOIN inventory AS i ON f.film_id = i.film_id
    INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
-- Filter the query to exclude outstanding rentals
WHERE r.return_date IS NOT NULL
ORDER BY f.title;

SELECT
    f.title,
 	-- Convert the rental_duration to an interval
    INTERVAL '1' day * f.rental_duration,
 	-- Calculate the days rented as we did previously
    r.return_date - r.rental_date AS days_rented
FROM film AS f
    INNER JOIN inventory AS i ON f.film_id = i.film_id
    INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
-- Filter the query to exclude outstanding rentals
WHERE r.return_date IS NOT NULL
ORDER BY f.title;



-- Select the current timestamp
SELECT NOW();

-- Select the current date
SELECT CURRENT_DATE;

--Select the current timestamp without a timezone
SELECT CAST( NOW() AS timestamp )

SELECT 
	-- Select the current date
	current_DATE,
    -- CAST the result of the NOW() function to a date
    CAST( NOW() AS date )


--Select the current timestamp without timezone
SELECT CURRENT_TIMESTAMP::timestamp AS right_now;


SELECT
	CURRENT_TIMESTAMP::timestamp AS right_now,
    INTERVAL '5 DAY' + CURRENT_TIMESTAMP AS five_days_from_now;



SELECT
	CURRENT_TIMESTAMP(0)::timestamp AS right_now,
    interval '5 days' + CURRENT_TIMESTAMP(0) AS five_days_from_now;


SELECT 
  -- Extract day of week from rental_date
  EXTRACT(DOW FROM rental_date) AS dayofweek 
FROM rental 
LIMIT 100;


-- Extract day of week from rental_date
SELECT 
  EXTRACT(dow FROM rental_date) AS dayofweek, 
  -- Count the number of rentals
  COUNT(*) as rentals 
FROM rental 
GROUP BY 1;

-- Truncate rental_date by year
SELECT DATE_TRUNC('YEAR',rental_date) AS rental_year
FROM rental;



-- Truncate rental_date by day of the month 
SELECT DATE_TRUNC('DAY',rental_date) AS rental_day 
FROM rental;



SELECT 
  DATE_TRUNC('day', rental_date) AS rental_day,
  -- Count total number of rentals 
  COUNT(*) AS  rentals
FROM rental
GROUP BY 1;


SELECT 
  EXTRACT(DOW FROM rental_date) AS dayofweek,
  AGE(return_date, rental_date) AS rental_days
FROM rental AS r 
WHERE 
  rental_date BETWEEN CAST('2005-05-01' AS date)
   AND CAST('2005-05-01' AS date) + INTERVAL '90 day';


SELECT 
  c.first_name || ' ' || c.last_name AS customer_name,
  f.title,
  r.rental_date,
  EXTRACT(DOW FROM r.rental_date) AS dayofweek,
  AGE(r.return_date, r.rental_date) AS rental_days,
  CASE 
    WHEN DATE_TRUNC('day', AGE(r.return_date, r.rental_date)) > f.rental_duration * INTERVAL '1 day' 
    THEN TRUE 
    ELSE FALSE 
  END AS past_due 
FROM 
  film AS f 
  INNER JOIN inventory AS i 
    ON f.film_id = i.film_id 
  INNER JOIN rental AS r 
    ON i.inventory_id = r.inventory_id 
  INNER JOIN customer AS c 
    ON c.customer_id = r.customer_id 
WHERE 
  r.rental_date BETWEEN CAST('2005-05-01' AS DATE) 
  AND CAST('2005-05-01' AS DATE) + INTERVAL '90 day';
