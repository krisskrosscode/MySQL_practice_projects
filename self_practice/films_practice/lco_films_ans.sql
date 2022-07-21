/*To run a query for each question, uncomment the query and run the .sql file in terminal 
using command [source lco_films_ans.sql]*/


-- TODO :  Q1) Which categories of movies released in 2018? Fetch with the number of movies. 

-- SELECT DISTINCT category.name AS category, COUNT(category.category_id) AS number_of_films
-- FROM film_category
-- LEFT JOIN film ON film_category.film_id = film.film_id
-- INNER JOIN category ON film_category.category_id = category.category_id
-- WHERE release_year = 2018
-- GROUP BY category.category_id;


-- TODO : Q2) Update the address of actor id 36 to “677 Jazz Street”.


-- SELECT actor.first_name, actor.last_name, address.address
-- FROM actor
-- LEFT JOIN address ON actor.address_id = address.address_id
-- WHERE actor.actor_id = 36;

        -- ANS
-- UPDATE address SET address = "677 Jazz Street"
-- WHERE address_id = (SELECT address_id FROM actor WHERE actor_id = 36);


-- TODO : Q3) Add the new actors (id : 105 , 95) in film  ARSENIC INDEPENDENCE (id:41).

-- INSERT INTO film_actor(actor_id, film_id) VALUES(105, 41), (95, 41);   

-- TODO : Q4) Get the name of films of the actors who belong to India.


-- SELECT DISTINCT film.title
-- FROM film
-- INNER JOIN film_actor ON film_actor.film_id = film.film_id
-- INNER JOIN actor ON actor.actor_id = film_actor.actor_id
-- INNER JOIN address ON address.address_id = actor.address_id
-- INNER JOIN city ON city.city_id = address.city_id
-- INNER JOIN country ON country.country_id = city.country_id
-- WHERE country.country = 'India';


-- TODO : Q5) How many actors are from the United States?

-- SELECT COUNT(actor.actor_id)
-- FROM actor
-- INNER JOIN address ON address.address_id = actor.address_id
-- INNER JOIN city ON city.city_id = address.city_id
-- INNER JOIN country on country.country_id = city.country_id
-- WHERE country.country = 'United States';


-- TODO : Q6) Get all languages in which films are released in the year between 2001 and 2010.

-- SELECT language.name AS language, film.release_year, COUNT(language.language_id) AS no_of_films
-- FROM language
-- INNER JOIN film ON film.language_id = language.language_id
-- WHERE film.release_year BETWEEN 2001 AND 2010
-- GROUP BY language.language_id
-- ORDER BY film.release_year;

-- TODO : Q7) The film ALONE TRIP (id:17) was actually released in Mandarin, update the info.

-- UPDATE film
-- SET language_id = (SELECT language_id FROM language WHERE name = 'Mandarin')
-- WHERE film_id = 17;

-- TODO : Q8) Fetch cast details of films released during 2005 and 2015 with PG rating.

-- SELECT actor.actor_id, CONCAT(actor.first_name, ' ', actor.last_name), film.title
-- FROM film 
-- INNER JOIN film_actor ON film_actor.film_id = film.film_id
-- INNER JOIN actor ON actor.actor_id = film_actor.actor_id
-- WHERE film.rating = 'PG';

-- TODO : Q9) In which year most films were released?

-- SELECT release_year as year_with_most_films, COUNT(release_year) AS no_of_films 
-- FROM film 
-- GROUP BY release_year
-- ORDER BY COUNT(release_year) DESC 
-- LIMIT 1; 

-- TODO : Q10) In which year least number of films were released?

-- SELECT release_year AS year_with_least_films , COUNT(release_year) AS no_of_films
-- FROM film
-- GROUP BY release_year
-- ORDER BY COUNT(release_year) 
-- LIMIT 1;


-- TODO : Q11) Get the details of the film with maximum length released in 2014 .

-- SELECT *
-- FROM film
-- WHERE release_year = 2014
-- ORDER BY length DESC
-- LIMIT 1;







