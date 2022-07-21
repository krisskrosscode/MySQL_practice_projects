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

-- SELECT actor.actor_id
-- FROM actor
-- INNER JOIN address ON actor.address_id = address.address_id
-- INNER JOIN city ON address.city_id = city.city_id
-- INNER JOIN country ON city.country_id = country.country_id 
-- WHERE country.country = 'India'; 


-- SELECT film.title
-- FROM film_id
-- INNER JOIN film_actor ON film.film_id = film_actor.film_id;