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


-- TODO : Q12) Get all Sci- Fi movies with NC-17 ratings and language they are screened in.

-- SELECT film.title, language.name
-- FROM film
-- INNER JOIN language ON language.language_id = film.language_id
-- INNER JOIN film_category ON film_category.film_id = film.film_id
-- INNER JOIN category ON category.category_id = film_category.category_id 
-- WHERE category.name = 'Sci-Fi' AND film.rating = 'NC-17';





-- TODO : Q13) The actor FRED COSTNER (id:16) shifted to a new address:
-- TODO :      055,  Piazzale Michelangelo, Postal Code - 50125 , District - Rifredi at Florence, Italy. 
-- TODO : Insert the new city and update the address of the actor.

-- INSERT INTO city(city, country_id) VALUES("Florence", (SELECT country_id FROM country WHERE country = "Italy"))

-- UPDATE address 
-- SET address.address = "055,  Piazzale Michelangelo", 
-- address.postal_code = "50125" , 
-- address.district =  "Rifredi",
-- address.city_id = (SELECT city_id FROM city WHERE city = "FLorence")
-- WHERE address_id = (SELECT address_id FROM actor WHERE actor_id = 16);


-- TODO : Q 14) 
-- TODO : A new film “No Time to Die” is releasing in 2020 whose details are : 
-- TODO : Title :- No Time to Die
-- TODO : Description: Recruited to rescue a kidnapped scientist, globe-trotting spy James Bond finds himself hot on the trail of a mysterious villain, who's armed with a dangerous new technology.
-- TODO : Language: English
-- TODO : Org. Language : English
-- TODO : Length : 100
-- TODO : Rental duration : 6
-- TODO : Rental rate : 3.99
-- TODO : Rating : PG-13
-- TODO : Replacement cost : 20.99
-- TODO : Special Features = Trailers,Deleted Scenes
-- TODO : Insert the above data.

-- INSERT INTO film(
--         title, 
--         description, 
--         language_id, 
--         original_language_id, 
--         length, 
--         rental_duration,
--         rental_rate,
--         rating,
--         replacement_cost,
--         special_features,
--         release_year

-- ) VALUES(
--         "No Time to Die",
--         "Recruited to rescue a kidnapped scientist, globe-trotting spy James Bond finds himself hot on the trail of a mysterious villain, who's armed with a dangerous new technology",
--         (SELECT language_id FROM language WHERE name = "English"),
--         (SELECT language_id FROM language WHERE name = "English"),
--         100,
--         6,
--         3.99,
--         "PG-13",
--         20.99,
--         "Trailers,Deleted Scenes",
--         2020
-- );


-- TODO : Q15) Assign the category Action, Classics, Drama  to the movie “No Time to Die” .

-- INSERT INTO film_category(film_id, category_id)
-- VALUES
--         ((SELECT film_id FROM film WHERE title = "No Time to Die"),(SELECT category_id FROM category WHERE name = "Action")),
--         ((SELECT film_id FROM film WHERE title = "No Time to Die"),(SELECT category_id FROM category WHERE name = "Classics")),
--         ((SELECT film_id FROM film WHERE title = "No Time to Die"),(SELECT category_id FROM category WHERE name = "Drama"))

-- ;

-- TODO : Q16) Assign the cast: PENELOPE GUINESS, NICK WAHLBERG, JOE SWANK to the movie “No Time to Die” .

-- INSERT INTO film_actor(actor_id, film_id)
-- VALUES ((SELECT actor_id FROM actor WHERE first_name = "PENELOPE" AND last_name = "GUINESS"), (SELECT film_id FROM film WHERE title = "No Time to Die")),
-- ((SELECT actor_id FROM actor WHERE first_name = "NICK" AND last_name = "WAHLBERG"), (SELECT film_id FROM film WHERE title = "No Time to Die")),
-- ((SELECT actor_id FROM actor WHERE first_name = "JOE" AND last_name = "SWANK"), (SELECT film_id FROM film WHERE title = "No Time to Die"));


-- TODO : Q17) Assign a new category Thriller  to the movie ANGELS LIFE.

-- INSERT INTO category(name) VALUES ("Thriller");

-- INSERT INTO film_category(film_id, category_id)
-- VALUES ((SELECT film_id FROM film WHERE title = "ANGELS LIFE" ), (SELECT category_id FROM category WHERE name = "THriller"));

        -- To check if the new data is added, run the following query: 

-- SELECT film.title, category.name as Category
-- FROM film
-- INNER JOIN film_category ON film.film_id = film_category.film_id
-- INNER JOIN category ON category.category_id = film_category.category_id
-- WHERE film.title = "ANGELS LIFE";

-- TODO : Q18) Which actor acted in most movies?

-- SELECT actor.actor_id, CONCAT(actor.first_name, ' ', actor.last_name) AS Actor, COUNT(film_actor.actor_id) AS no_of_films
-- FROM actor
-- INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
-- GROUP BY film_actor.actor_id
-- ORDER BY COUNT(film_actor.actor_id) DESC
-- LIMIT 1;

