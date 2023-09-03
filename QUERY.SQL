SELECT genre
FROM books
LIMIT 10

SELECT COUNT(birthdate) as count_records
FROM people


SELECT COUNT(language) AS count_languages,COUNT(country) AS count_countries
FROM films



SELECT COUNT(DISTINCT country) 
FROM films

SELECT film_id,imdb_score
FROM reviews
WHERE imdb_score>7.0


SELECT film_id,facebook_likes
FROM reviews
WHERE facebook_likes<10000
LIMIT 10


SELECT num_votes AS films_over_100K_votes .
FROM reviews
WHERE num_votes<1000000

SELECT COUNT(language) AS count_spanish
FROM films
WHERE language='Spanish'


 SELECT title,release_year
 FROM films
 WHERE release_year < 2000 AND language='German'

 -- Select all records for German-language films released after 2000 and before 2010

 SELECT *
 FROM films
 WHERE release_year BETWEEN 2000 AND 2010
 AND language='German'

 
 SELECT *
 FROM films
 WHERE release_year = 1990  OR   release_year = 1999

 -- Find the title and year of films from the 1990 or 1999


 SELECT *
 FROM films
 WHERE release_year = 1990  OR   release_year = 1999



-- Add a filter to see only English or Spanish-language films

 SELECT title, release_year
FROM films
WHERE (release_year = 1990 OR release_year = 1999)

AND (language='Spanish' OR language='English') ;


SELECT title, release_year
FROM films

WHERE (release_year = 1990 OR release_year = 1999)

	AND (language = 'English' OR language = 'Spanish')
-- Filter films with more than $2,000,000 gross
	AND (gross>2000000);



    Select name 
    FROM people
    WHERE name LIKE 'B%'

    
    Select name 
    FROM people
    WHERE name LIKE '_r%'

SELECT title, release_year
FROM films
WHERE release_year IN (1990,2000) AND duration >120



SELECT title, release_year
FROM films
WHERE release_year IN ('English', 'Spanish','French') 


SELECT title, certification , language
FROM films
WHERE certification IN ('NC-17' , 'R')
AND IN ('English', 'Italian', 'Greek')

    -- Count the unique titles
    SELECT DISTINCT title AS nineties_english_films_for_teens
    FROM films
    -- Filter to release_years between 1990 and 1999
    WHERE release_year BETWEEN 1990 AND 1999
    -- Filter to English-language films
    AND language = 'English'
    -- Narrow it down to G, PG, and PG-13 certification
    AND certification IN ('G', 'PG', 'PG-13');

SELECT SUM(duration) AS total_duration
from films


SELECT AVG(duration) AS average_duration
from films



SELECT MAX(release_year) AS latest_year
from films


SELECT MIN(duration) AS shortest_film
from films


SELECT SUM(gross) AS total_gross
from films
WHERE release_year>=2000



SELECT MIN(gross) AS avg_gross_A
from films
WHERE title LIKE 'A%'


SELECT MAX(gross) AS highest_gross
from films
WHERE release_year BETWEEN 2000 AND 2012


SELECT  ROUND(AVG(facebook_likes),1) AS avg_facebook_likes
FROM reviews

-- Calculate the percentage of people who are no longer alive
SELECT COUNT(deathdate) * 100.0 /COUNT(*) AS percentage_dead
FROM people;

-- Find the number of decades in the films table
SELECT (MAX(release_year)-Min(release_year)) / 10.0 AS number_of_decades

FROM films;

SELECT name 
from people
ORDER BY name

-- Select the certification, release year, and title sorted by certification and release year

SELECT certification,release_year,title
FROM films
ORDER BY certification, release_year DESC


SELECT release_year,Count(release_year) AS film_count
FROM films
GROUP BY release_year



SELECT release_year,AVG(duration) AS avg_duration
FROM films
GROUP BY release_year



SELECT release_year,country , MAX(budget) AS max_budget
FROM films
GROUP BY release_year,country


SELECT DISTINCT language
FROM films
GROUP BY release_year

SELECT release_year
FROM films
GROUP BY release_year
HAVING release_year>1990



SELECT release_year,AVG(budget) AS avg_budget,AVG(gross) AS avg_gross
FROM films
GROUP BY release_year
HAVING release_year>1990



-- Select fields
SELECT name, e.year, fertility_rate, unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
-- Join to economies (as e)
INNER JOIN economies AS e
-- Match on country code
ON c.code = e.code;



SELECT 
	c1.name AS country, 
    region, 
    l.name AS language,
	basic_unit, 
    frac_unit
FROM countries as c1 
-- Full join with languages (alias as l)
FULL JOIN languages as l 
USING(code)
-- Full join with currencies (alias as c2)
FULL JOIN currencies AS c2
USING(code)
WHERE region LIKE 'M%esia';


SELECT name 
from cities

except 
SELECT name 
from countries


SELECT code
FROM countries
WHERE code IN (

    SELECT region
    FROM countries
    WHERE region ='Middle East'
)


SELECT
    c.country AS country,
    COUNT(ci.city_name) AS cities_num
FROM
    countries c
LEFT JOIN
    cities ci
ON
    c.country_code = ci.country_code
GROUP BY
    c.country
ORDER BY
    cities_num DESC, country ASC
LIMIT
    9;


-- Find top nine countries with the most cities
SELECT countries.name AS country, COUNT(*) AS cities_num
FROM countries
LEFT JOIN cities
ON countries.code = cities.country_code
GROUP BY country
-- Order by count of cities as cities_num
ORDER BY cities_num DESC, country
LIMIT 9;


SELECT countries.name AS country,
-- Subquery that provides the count of cities   
  (SELECT count(cities.name)
   FROM cities
   WHERE cities.country_code= countries.code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;