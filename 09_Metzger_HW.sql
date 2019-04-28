use sakila;
-- 1a,b,c,
select actor.first_name, actor.last_name from actor;
select CONCAT(actor.first_name, ' ',  actor.last_name) as 'Actor Name' from actor;
-- 2 a,b,c,d
select actor.actor_id, actor.first_name, actor.last_name from actor where actor.first_name = "Joe";
select actor.first_name, actor.last_name from actor where actor.last_name like '%gen%';
select actor.last_name, actor.first_name from actor where actor.last_name like '%li%';
select country_id, country from country where country IN ('Afghanistan', 'Bangladesh', 'China');
-- 3 a,b
alter table actor
add column Description BLOB;
alter table actor
drop column Description;
-- 4 a,b,c,d
select actor.last_name, count(last_name) 
from actor 
where last_name is not null group by last_name;
-- 
select actor.last_name, count(last_name) 
from actor 
where last_name is not null group by last_name
having count(last_name)>1;
--
update actor
set first_name = 'Harpo'
where first_name = 'Groucho' and last_name = 'Williams';
--
update actor
set first_name = 'Groucho'
where first_name = 'Harpo' and last_name = 'Williams';
select actor.first_name, actor.last_name from actor where first_name = 'Groucho';
-- 5
CREATE Table address_found (
address_id smallint(5) not null,
address varchar(50),
address2 varchar(50),
district varchar(20),
city_id smallint(5), 
postal_code varchar(10),
phone varchar(20),
location geometry, 
last_update timestamp);
-- 6 a, b, c, d, e
select staff.first_name, staff.last_name, address.address
from address
join staff on staff.address_id=address.address_id;
-- 
select staff.first_name, staff.last_name, sum(payment.amount) 
from staff
left join payment on payment.staff_id=staff.staff_id
where payment_date like '2005-%'
group by staff.staff_id
order by staff.staff_id;
--
select film.title, sum(distinct film_actor.actor_id) as 'Number of Actors in Film'
from film
join film_actor on film_actor.film_id=film.film_id
group by film.film_id;
--
select count(*)
from inventory
where film_id in 
(select film_id
from film 
where title = 'Hunchback Impossible');
--
select customer.first_name, customer.last_name, sum(payment.amount) as 'Total Amount Paid'
from customer
join payment on payment.customer_id=customer.customer_id
group by customer.customer_id
order by customer.last_name;
-- 7 a,b,c,d,e,f,g,h 
select title
from film
where title IN 
 (
select film.title
from film
where language_id IN
(
select language_id
from language
where name = 'English')) and title like 'k%' or title like 'q%';
-- 
select first_name, last_name
from actor
where actor_id IN
(
select actor_id
from film_actor
wherecfilm_id IN
(
select film_id
from film
where title = 'Alone Trip'));
-- 
select customer.first_name, customer.last_name, customer.email
from customer
where address_id IN 
(
select address_id
from address
where city_id IN 
(
select city_id
from city
where country_id IN 
(
select country_id
from country
where country = "Canada")));
-- 
select title
from film
where film_id IN 
(
select film_id
from film_category
where category_id IN 
(
select category_id
from category
where name = "Family"));
-- 
select film.title, count(rental.rental_id)
from film
inner join inventory on film.film_id=inventory.film_id
inner join rental on inventory.inventory_id=rental.inventory_id
group by film.title
order by count(rental.rental_id) desc; 
--
select store.store_id, sum(payment.amount)
from store
inner join customer on store.store_id=customer.store_id
inner join payment on customer.customer_id=payment.customer_id
group by store.store_id;
-- 
select store.store_id, city.city, country.country
from store
inner join address on store.address_id=address.address_id
inner join city on address.city_id=city.city_id
inner join country on city.country_id=country.country_id;
-- 
select category.name, sum(payment.amount) as 'Gross Revenue'
from category
inner join film_category on category.category_id=film_category.category_id
inner join inventory on film_category.film_id=inventory.film_id
inner join rental on inventory.film_id=rental.inventory_id
inner join payment on rental.rental_id=payment.rental_id
group by category.name
order by 'Gross Revenue' desc limit 5;
-- 8 a,b,c
create view top_five_genres as
select category.name, sum(payment.amount) as 'Gross Revenue'
from category
inner join film_category on category.category_id=film_category.category_id
inner join inventory on film_category.film_id=inventory.film_id
inner join rental on inventory.film_id=rental.inventory_id
inner join payment on rental.rental_id=payment.rental_id
group by category.name
order by 'Gross Revenue' desc limit 5;
-- 
select * from top_five_genres;
--
drop view top_five_genres;



