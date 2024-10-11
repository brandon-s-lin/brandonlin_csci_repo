-- Q1) 
-- Show all customers whose last names start with T. Order them by 
-- first name from A-Z.

select first_name, last_name
from customer
where last_name like 'T%'
order by first_name asc;

-- Q2) 
-- Show all rentals returned from 05/28/2005 to 06/01/2005

select *
from rental
where return_date between '2005-05-28' and '2005-06-01';

-- Q3) 
-- What query would you use to determine which movies are rented the 
-- most? Show the top 10 movies rented the most.

-- The query below would be what I would use in order to determine
-- which movies are rented the most. The query starts where the movie
-- information is contained. Then the query aggregates the number of 
-- rentals per movie in order to order them by number of rentals in 
-- decending order.

select title, count(rental.rental_id)
from rental
left join inventory
on rental.inventory_id = inventory.inventory_id
left join film 
on inventory.film_id = film.film_id
group by title
order by count(rental.rental_id) desc
limit 10;

-- Q4)
-- Show how much each customer spent on movies (for all time). Order
-- them from least to most

select customer.customer_id, sum(amount)
from payment
left join customer 
on customer.customer_id = payment.customer_id
group by customer.customer_id
order by sum(amount);

-- Q5) 
-- Which actor was in the most movies in 2006 (based on this dataset)?
-- Be sure to alias the actor name and count as a more descriptive name.
-- Order the results from most to least.

-- Find actor in the most movies in 2006
select actor.first_name ||' '|| actor.last_name as actor_name, count(actor.actor_id) as total_movies
from actor
left join film_actor 
on actor.actor_id = film_actor.actor_id
left join film
on film_actor.film_id = film.film_id
where film.release_year = 2006
group by actor_name
order by total_movies desc
limit 1;

-- Order from most to least
select actor.first_name ||' '|| actor.last_name as actor_name, count(actor.actor_id) as total_movies
from actor
left join film_actor 
on actor.actor_id = film_actor.actor_id
left join film
on film_actor.film_id = film.film_id
where film.release_year = 2006
group by actor_name
order by total_movies desc;

-- Q6) 
-- Write and explain query plan for 4 and 5. Show the queries and explain what 
-- is happening in each one and what the output means to the best of your 
-- ability.

-- a)
explain analyze
select customer.customer_id, sum(amount)
from payment
left join customer 
on customer.customer_id = payment.customer_id
group by customer.customer_id
order by sum(amount);
-- Query Plan:
-- Sort  (cost=423.12..424.62 rows=599 width=36) (actual time=6.973..6.996 rows=599 loops=1)
--      This query is tells me how much it costs to sort. It also shows me how long executing this query took to run. The output also tells
--      me that there was only one loop to this query.
--   Sort Key: (sum(payment.amount))
--          This query tells me how the sorting is happening (sum(payment.amount))   
--   Sort Method: quicksort  Memory: 43kB
--          This query tells me that the memory that was used was 43kB
--   ->  HashAggregate  (cost=388.00..395.49 rows=599 width=36) (actual time=6.717..6.830 rows=599 loops=1)
--              This query tells me the cost of executing this query. This also shows me how long executing this query took to run. The 
--              output also tells me that there was only one loop to this query.
--         Group Key: customer.customer_id
--                  This query tells me that it created a new group key named customer.customer_id.
--         Batches: 1  Memory Usage: 297kB
--                  This query tells me that the memory that was used was 297kB
--         ->  Hash Left Join  (cost=22.48..315.02 rows=14596 width=10) (actual time=0.178..3.894 rows=14596 loops=1)
--                      This query tells me how much it costs to sort. It also shows me how long executing this query took to run. The
--                      output also tells me that there was only one loop to this query.
--               Hash Cond: (payment.customer_id = customer.customer_id)
--                          This query essentially tells me that the information is being moved.
--               ->  Seq Scan on payment  (cost=0.00..253.96 rows=14596 width=8) (actual time=0.015..0.852 rows=14596 loops=1)
--                              This query is tells me how much it costs to sort. It also shows me how long executing this query took to run. 
--                              The output also tells me that there was only one loop to this query.
--               ->  Hash  (cost=14.99..14.99 rows=599 width=4) (actual time=0.145..0.146 rows=599 loops=1)
--                              This query is tells me how much it costs to sort. It also shows me how long executing this query took to run. 
--                              The output also tells me that there was only one loop to this query.
--                     Buckets: 1024  Batches: 1  Memory Usage: 30kB
--                                  This query tells me that the memory that was used was 30kB
--                     ->  Seq Scan on customer  (cost=0.00..14.99 rows=599 width=4) (actual time=0.009..0.080 rows=599 loops=1)
--                                      This query is tells me how much it costs to sort. It also shows me how long executing this query 
--                                      took to run. The output also tells me that there was only one loop to this query.
-- Planning Time: 0.433 ms
--      This query tells me that it took .433 ms to plan everything above.
-- Execution Time: 7.125 ms
--      This query tells me that it took 7.125 ms to execute everything above.

-- b)
explain analyze
select actor.first_name ||' '|| actor.last_name as actor_name, count(actor.actor_id) as total_movies
from actor
left join film_actor 
on actor.actor_id = film_actor.actor_id
left join film
on film_actor.film_id = film.film_id
where film.release_year = 2006
group by actor_name
order by total_movies desc
limit 1;
--Limit  (cost=290.33..290.33 rows=1 width=40) (actual time=3.033..3.034 rows=1 loops=1)
--      This query is tells me how much it costs to sort. It also shows me how long executing this query took to run. The output also tells 
--      me that there was only one loop to this query.
--  ->  Sort  (cost=290.33..290.65 rows=128 width=40) (actual time=3.031..3.033 rows=1 loops=1)
--          This query is tells me how much it costs to sort. It also shows me how long executing this query took to run. The output also 
--          tells me that there was only one loop to this query.
--        Sort Key: (count(actor.actor_id)) DESC
--              This query tells me how the sorting is happening (count(actor.actor_id))
--        Sort Method: top-N heapsort  Memory: 25kB
--              This query tells me that the memory that was used was 25kB
--        ->  HashAggregate  (cost=287.77..289.69 rows=128 width=40) (actual time=2.996..3.011 rows=199 loops=1)
--                  This query tells me how much it costs to sort. It also shows me how long executing this query took to run. The output
--                  also tells me that there was only one loop to this query.
--              Group Key: (((actor.first_name)::text || ' '::text) || (actor.last_name)::text)
--                  This query tells me that actor.first_name is going to be grouped with actor.last_name
--              Batches: 1  Memory Usage: 48kB
--                  This query tells me that the memory that was used was 28kB
--              ->  Hash Join  (cost=119.50..260.46 rows=5462 width=36) (actual time=0.421..2.369 rows=5462 loops=1)
--                      This query tells me how much it costs to sort. It also shows me how long executing this query took to run. The
--                      output also tells me that there was only one loop to this query.
--                    Hash Cond: (film_actor.film_id = film.film_id)
--                          This query essentially tells me that the information is being moved.
--                    ->  Hash Join  (cost=6.50..105.76 rows=5462 width=19) (actual time=0.069..1.107 rows=5462 loops=1)
--                              This query tells me how much it costs to sort. It also shows me how long executing this query took to run. 
--                              The output also tells me that there was only one loop to this query.
--                          Hash Cond: (film_actor.actor_id = actor.actor_id)
--                                  This query essentially tells me that the information is being moved.
--                          ->  Seq Scan on film_actor  (cost=0.00..84.62 rows=5462 width=4) (actual time=0.010..0.241 rows=5462 loops=1)
--                                      This query tells me how much it costs to sort. It also shows me how long executing this query took 
--                                      to run. The output also tells me that there was only one loop to this query.
--                          ->  Hash  (cost=4.00..4.00 rows=200 width=17) (actual time=0.047..0.048 rows=200 loops=1)
--                                      This query tells me how much it costs to sort. It also shows me how long executing this query took 
--                                      to run. The output also tells me that there was only one loop to this query.
--                                Buckets: 1024  Batches: 1  Memory Usage: 18kB
--                                          This query tells me that the memory that was used was 18kB
--                                 ->  Seq Scan on actor  (cost=0.00..4.00 rows=200 width=17) (actual time=0.006..0.018 rows=200 loops=1)
--                                              This query tells me how much it costs to sort. It also shows me how long executing this 
--                                              query took to run. The output also tells me that there was only one loop to this query.
--                     ->  Hash  (cost=100.50..100.50 rows=1000 width=4) (actual time=0.345..0.345 rows=1000 loops=1)
--                                  This query tells me how much it costs to sort. It also shows me how long executing this query took to 
--                                  run. The output also tells me that there was only one loop to this query.
--                           Buckets: 1024  Batches: 1  Memory Usage: 44kB
--                                      This query tells me that the memory that was used was 44kB
--                           ->  Seq Scan on film  (cost=0.00..100.50 rows=1000 width=4) (actual time=0.006..0.279 rows=1000 loops=1)
--                                          This query tells me how much it costs to sort. It also shows me how long executing this query 
--                                          took to run. The output also tells me that there was only one loop to this query.
--                                 Filter: ((release_year)::integer = 2006)
--                                              I assume this query makes it so that only release_year 2006 is selected.
--
-- Planning Time: 0.472 ms
--      This query tells me that it took .472 ms to plan everything above.
-- Execution Time: 3.085 ms
--      This query tells me that it took 3.085 ms to execute everything above.

explain analyze
select actor.first_name ||' '|| actor.last_name as actor_name, count(actor.actor_id) as total_movies
from actor
left join film_actor 
on actor.actor_id = film_actor.actor_id
left join film
on film_actor.film_id = film.film_id
where film.release_year = 2006
group by actor_name
order by total_movies desc;
-- This one is essentially the same as the one above without the first limit statement.

-- Q7)
-- What is the average rental rate per genre?

select category.name as genre, avg(film.rental_rate)
from film
left join film_category 
on film.film_id = film_category.film_id
left join category 
on film_category.category_id = category.category_id
group by genre;

-- Q8) 
-- What categories are the most rented and what are their total sales?
-- Show the top 5 most rented categories.

select category.name as genre, count(rental.rental_id), sum(payment.amount)
from rental
join payment
on rental.rental_id = payment.rental_id
join inventory
on rental.inventory_id = inventory.inventory_id
join film
on inventory.film_id = film.film_id
join film_category
on film.film_id = film_category.film_id
join category
on film_category.category_id = category.category_id
group by genre
order by count(rental.rental_id) desc
limit 5;

-- Extra Credit
-- Write a query that shows how many total films were rented each month. 
-- Group them by category and month. So, you want to show January in 
-- general regardless of year, etc.

select to_char(rental.rental_date, 'Month') as Month, category.name as genre, count(rental.rental_id)
from rental
left join inventory
on rental.inventory_id = inventory.inventory_id
left join film
on inventory.film_id = film.film_id
left join film_category
on film.film_id = film_category.film_id
left join category
on film_category.category_id = category.category_id
group by Month, genre
order by Month