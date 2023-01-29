USE sakila;

/*Create a query or queries to extract the information you think may be relevant for building the prediction model. 
It should include some film features and some rental features. Use the data from 2005.*/
SELECT f.film_id, f.title, c.name as category, f.length, f.rating from film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
on c.category_id = fc.category_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
WHERE r.rental_date LIKE '2005%'
GROUP BY f.film_id, category
ORDER BY film_id;


/*Create a query to get the total amount of rentals in June for each film.*/
SELECT f.film_id, f.title, f.description, f.release_year, f.length, f.rating, f.special_features, count(r.inventory_id) as number_of_rentals_june from film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
WHERE r.rental_date LIKE '2005-06%'
GROUP BY f.film_id;

SELECT film_id, title, description, release_year, length, rating, special_features FROM film
WHERE film_id IN (
	SELECT film_id FROM (
		SELECT film_id, inventory_id from inventory
		WHERE inventory_id IN(
			SELECT inventory_id FROM (
				SELECT inventory_id, count(inventory_id) AS number_of_rentals FROM rental
				WHERE rental_date LIKE '2005-06%'
				GROUP BY inventory_id) AS db1))AS db2);
        

/*Do the same with July.*/
SELECT f.film_id, f.title, f.description, f.release_year, f.length, f.rating, f.special_features, count(r.inventory_id) as number_of_rentals_july from film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
WHERE r.rental_date LIKE '2005-07%'
GROUP BY f.film_id;

SELECT film_id, title, description, release_year, length, rating, special_features FROM film
WHERE film_id IN (
	SELECT film_id FROM (
		SELECT film_id, inventory_id from inventory
		WHERE inventory_id IN(
			SELECT inventory_id FROM(
				SELECT inventory_id, count(inventory_id) AS number_of_rentals FROM rental
				WHERE rental_date LIKE '2005-07%'
				GROUP BY inventory_id) AS db1)) AS db2);

SELECT f.film_id, f.title, c.name as category, f.length, f.rating, count(r.inventory_id) as number_of_rentals_july from film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
on c.category_id = fc.category_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
WHERE r.rental_date LIKE '2005-07%'
GROUP BY f.film_id, category
ORDER BY film_id;

/* The following search provides too many inputs for the same film (one per each actor that worked in it, so it is not very feasible*/
SELECT f.film_id, f.title, a.first_name as actor_name, a.last_name as actor_surname, f.release_year, f.length, f.rating, f.special_features, count(r.inventory_id) as number_of_rentals_june from film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN film_actor as fa
on f.film_id = fa.film_id
JOIN actor as a
on fa.actor_id = a.actor_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
WHERE r.rental_date LIKE '2005-06%'
GROUP BY f.film_id, actor_name, actor_surname
ORDER BY film_id;



SELECT f.film_id, f.title, a.first_name as actor_name, a.last_name as actor_surname, f.release_year, f.length, f.rating, f.special_features, count(r.inventory_id) as number_of_rentals_july from film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN film_actor as fa
on f.film_id = fa.film_id
JOIN actor as a
on fa.actor_id = a.actor_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
WHERE r.rental_date LIKE '2005-07%'
GROUP BY f.film_id, actor_name, actor_surname
ORDER BY film_id;