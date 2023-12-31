/*
1.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 
*/ 

SELECT
	first_name,
    last_name,
    email,
    store_id
FROM
	staff;

/*
2.	We will need separate counts of inventory items held at each of your two stores. 
*/ 

SELECT
	store_id,
    COUNT(inventory_id) AS inventory_count
FROM inventory
GROUP BY store_id;

/*
3.	We will need a count of active customers for each of your stores. Separately, please. 
*/

SELECT
	store_id,
    COUNT(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS active_customers,
    COUNT(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS inactive_customers
FROM customer
GROUP BY store_id;

/*
4.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/

SELECT
	COUNT(email) AS total_email_addresses
FROM customer;

/*
5.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide. 
*/

SELECT
	store_id,
    COUNT(DISTINCT inventory.film_id) AS unique_film_titles,
    COUNT(DISTINCT film_category.category_id) AS unique_categories
FROM inventory, film_category
GROUP BY store_id;

/*
6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/

SELECT
	MIN(replacement_cost) AS min_replacement_cost,
    MAX(replacement_cost) AS max_replacement_cost,
    CAST(AVG(replacement_cost) AS DECIMAL(10, 2)) AS avg_replacement_cost
FROM film;

/*
7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/

SELECT
	CAST(AVG(amount) AS DECIMAL(10, 2)) AS avg_payment,
    MAX(amount) AS max_payment
FROM payment;

/*
8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/

SELECT
	customer.customer_id AS customer_id,
    CONCAT(UPPER(SUBSTRING(customer.first_name,1,1)),LOWER(SUBSTRING(customer.first_name,2))) AS customer_first_name,
    CONCAT(UPPER(SUBSTRING(customer.last_name,1,1)),LOWER(SUBSTRING(customer.last_name,2))) AS customer_last_name,
    LOWER(customer.email) AS customer_email,
	customer.store_id AS store_id,
    COUNT(CASE WHEN rental.customer_id = customer.customer_id THEN rental_id ELSE NULL END) AS total_rentals
FROM customer, rental
GROUP BY customer_id
ORDER BY total_rentals DESC