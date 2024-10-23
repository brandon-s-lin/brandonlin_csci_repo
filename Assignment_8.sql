-- Question 1

alter table rental
add column status varchar(10);

update rental
set status = case
   when return_date < rental_date + interval '1 day' * (
        select rental_duration from film 
        join inventory on film.film_id = inventory.film_id
        where inventory.inventory_id = rental.inventory_id) then 'Early'
   when return_date > rental_date + interval '1 day' * (
        select rental_duration from film 
        join inventory on film.film_id = inventory.film_id
        where inventory.inventory_id = rental.inventory_id) then 'Late'
    else 'On Time'
end;

-- Question 2

select sum(payment.amount) as total_amount
from payment
join customer on customer.customer_id = payment.customer_id
join address on address.address_id = customer.address_id
join city on city.city_id = address.city_id
where city.city in ('Kansas City');

-- Question 3

select category.name, count(film.film_id)
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by category.name;

-- Question 4

-- The category table is used as a junction table in order to handle
-- the relatioinships between film and category.

-- Question 5

select film.film_id, film.title, film.length
from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
where rental.rental_date between '2005-05-15' and '2005-05-31';

-- Question 6

select film.film_id, film.title, film.rental_rate
from film
where film.rental_rate < (select avg(film.rental_rate) from film);

-- Question 7

select status, count(*) as count
from rental
group by status;

-- Question 8

select film.title, film.length,
    percent_rank() over (order by film.length) as duration_percentile
from film;

-- Question 9

explain analyze
select film.film_id, film.title, film.rental_rate
from film
where film.rental_rate < (select avg(film.rental_rate) from film);

-- Query 1 (Movies That Are Below Average Price)
-- I see there are two different seq scans
-- One for retrieving average
-- Other for filtering the films

explain analyze
select status, count(*) as count
from rental
group by status;

-- Query 2 (Films returned late, early, or on time)
-- There was on has aggregate and one seq scan
-- The hash aggregate was used to group the results based on status and counts them
-- The sec scan was used to read through all the rows in rental

-- They differ by query 1 being more complex since it has an inner and outer query.
-- They also differ by what they do. Query 1 compares each row while query 2 groups data.

-- Extra Credit

-- The relationship that is wrong in this data model is __ and __, because ...

-- In essence set-based programming processes entire datasets at a time while using 
-- declarative statements. SQL is an example of set-based programmin. Procedural 
-- programming follows a step-by-step sequence of instructions. Flow control in
-- procedural programming are controled by loops and conditionals. Python is an
-- exampple of procedural programming.