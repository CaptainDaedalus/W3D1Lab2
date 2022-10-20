use sakila;
-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT * from sakila.film;
select f.title as Film, count(i.inventory_id) as 'Inventory'
from film as f
join inventory as i
on f.film_id = i.film_id
where f.title = 'Hunchback Impossible'
group by f.film_id;
 
 -- List all films whose length is longer than the average of all the films

SELECT f.title, f.length, ct.name FROM film as f 
JOIN film_category as fc 
ON f.film_id=fc.film_id
JOIN category as ct 
ON ct.category_id=fc.category_id
WHERE f.length > AVG (f.length);
                   
-- Use subqueries to display all actors who appear in the film Alone Trip.
select CONCAT(first_name,' ',last_name) as 'Actors in Alone Trip'
from actor
where actor_id in 
(
 select actor_id from film_actor where film_id = 
(select film_id from film where title = 'Alone Trip')
);

SELECT first_name,last_name
 FROM actor
 WHERE actor_id IN(
 SELECT actor_id
 FROM film
 LEFT JOIN film_actor 
 ON (film.film_id=film_actor.film_id)
 WHERE film.title='Alone Trip');
 
 -- Sales have been lagging among young families, 
 -- and you wish to target all family movies for a promotion. 
 -- Identify all movies categorized as family films.
 
 SELECT * FROM sakila.film_category;  
 SELECT * FROM sakila.film;
 SELECT * FROM sakila.category;
 
 Select c.name as category, f.title as 'movies'
 FROM sakila.film as f
 join sakila.film_category as fc on f.film_id=fc.film_id
 join sakila.category as c on fc.category_id = c.category_id
 where c.name= 'Family';
 
-- Get name and email from customers from Canada using subqueries. 
-- Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables 
-- with their primary keys and foreign keys, 
-- that will help you get the relevant information. 

select concat(c.first_name,' ',c.last_name) as 'Name', c.email as 'E-mail'
from customer as c
join address as a on c.address_id = a.address_id
join city as cy on a.city_id = cy.city_id
join country as ct on ct.country_id = cy.country_id
where ct.country = 'Canada';

-- Which are films starred by the most prolific actor? 
-- Most prolific actor is defined as the actor 
-- that has acted in the most number of films. 
-- First you will have to find the most prolific actor 
-- and then use that actor_id to find the different films that he/she starred.
 
 
 
 
 
 
 
 
 -- Films rented by most profitable customer. 
 -- You can use the customer table and payment table 
 -- to find the most profitable customer 
 -- ie the customer that has made the largest sum of payments

SELECT Concat(customer.first_name,' ' ,customer.last_name) as 'customer name', a.total_spend FROM customer
LEFT JOIN(
SELECT payment.customer_id,
SUM(payment.amount) AS total_spend
FROM payment LEFT JOIN customer ON (payment.customer_id=customer.customer_id)
GROUP BY 1)
ORDER BY a.total_spend DESC;