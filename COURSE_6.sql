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




