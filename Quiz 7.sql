-- Q1) 

select *
from payment
where amount >= 9.99;

-- Q2)

select max(amount)
from payment;

-- Q3) 

select first_name, last_name, email, address, city, country
from staff
left join address
on staff.address_id = address.address_id
left join city 
on address.city_id = city.city_id
left join country
on city.country_id = country.country_id;

-- Q4) 

-- I am interested to start a roofing business, because I love the sun.

-- Extra Credit

-- "Crow's Foot Notation is a visual language used in ERDs to depict the relationship between entities in a database,"(Miro).
-- When looking at the connection between the city and the country table, we see that towards the country table, there are two
-- small perpendicular lines which indicate that a city can belong to one and only one country. When looking at the other side of
-- the connection, we see that there is a circle followed by a crows foot, meaning that a country can have zero or many countries.