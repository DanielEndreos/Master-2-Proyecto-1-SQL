--1. Crea el esquema de la BBDD.
--------------------------------

--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
select 
	f.title as titulo,
	f.rating as clasificacion
from film f
where f.rating = 'R';

--3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
select 
	*
from actor a
where a.actor_id between 30 and 40;

--4. Obtén las películas cuyo idioma coincide con el idioma original.
select 
	f.title, 
	f.language_id, 
	f.original_language_id  
from film f
where f.language_id = f.original_language_id;

--5. Ordena las películas por duración de forma ascendente. 
select *
from film f
order by f.length asc;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
select concat(a.first_name ,' ', a.last_name)
from actor a
where lower(a.last_name) = lower('Allen');

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla
--   “filmˮ y muestra la clasificación junto con el recuento.
select 
	count(f.film_id) as pelicula, 
	f.rating as clasificacion
from film f
group by f.rating ;

--8. Encuentra el título de todas las películas que son ‘PG13ʼ o tienen una
--  duración mayor a 3 horas en la tabla film.
select 
	f.title,
	f.rating,
	f.length 
from film f
where f.rating = 'PG-13' or f.length > 3*60
order by f.rating asc, f.length asc;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select variance(f.replacement_cost)
from film f; 

--10 Encuentra la mayor y menor duración de una película de nuestra BBDD.
select 
	max(f.length) as mayor_duracion, 
	min(f.length) as menor_duracion
from film f;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select p.amount, p.payment_date 
from payment p 
order by p.payment_date desc
offset 1
limit 1;

--12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-
--    17ʼ ni ‘Gʼ en cuanto a su clasificación. 
select f.title, f.rating 
from film f 
where f.rating not in ('NC-17', 'G')
order by f.rating;

--13. Encuentra el promedio de duración de las películas para cada
--	  clasificación de la tabla film y muestra la clasificación junto con el
-- 	  promedio de duración.
select 
	f.rating as clasificacion,
	round(avg(f.length), 2) as promedio_duracion
from film f 
group by f.rating;

--14. Encuentra el título de todas las películas que tengan una duración mayor
--    a 180 minutos.
select
	f.title,
	f.length 
from film f
where f.length > 180
order by f.length;

--15. ¿Cuánto dinero ha generado en total la empresa?
select sum(p.amount)
from payment p;

--16. Muestra los 10 clientes con mayor valor de id.
select *
from customer c 
order by c.customer_id desc
limit 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la
--	  película con título ‘Egg Igbyʼ.
select
	concat(a.first_name ,' ', a.last_name ),
	f.title 
from actor a
inner join film_actor fa 
	on a.actor_id = fa.actor_id
inner join film f 
	on fa.film_id = f.film_id
where lower(f.title) = lower('Egg Igby');

--18. Selecciona todos los nombres de las películas únicos.
select distinct title as film_unico
from film f
order by f.title ;

--19. Encuentra el título de las películas que son comedias y tienen una
--    duración mayor a 180 minutos en la tabla “filmˮ.
select 
	f.title as titulo,
	f.length as duracion,
	c."name" as categoria
from film f
inner join film_category fc 
	on fc.film_id = f.film_id 
inner join category c 
	on fc.category_id = c.category_id 
where f.length > 180 and lower(c."name") = lower('Comedy')
order by f.length;

--20. Encuentra las categorías de películas que tienen un promedio de
--	  duración superior a 110 minutos y muestra el nombre de la categoría
--	  junto con el promedio de duración.
select
	count(f.length) as cantidad,
	round(avg(f.length),2) as promedio_duracion,
	c."name" as categoria
from film f
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
group by c."name"
having avg(f.length) > 110
order by cantidad;

--21. ¿Cuál es la media de duración del alquiler de las películas?
select avg(f.rental_duration) 
from film f;

--22. Crea una columna con el nombre y apellidos de todos los actores y
--	  actrices.
select
	concat(a.first_name, ' ',a.last_name)
from actor a;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de
--    forma descendente.
select 
	count(r.rental_id) as num_alquileres,
	DATE(r.rental_date) as dia_alquiler
from rental r
group by DATE(r.rental_date)
order by num_alquileres desc;

--24. Encuentra las películas con una duración superior al promedio.
select *
from film f
where f.length > (select avg(length) from film);

--25. Averigua el número de alquileres registrados por mes.
SELECT  
    CONCAT(EXTRACT(YEAR FROM r.rental_date), '-', EXTRACT(MONTH FROM r.rental_date)) AS anio_mes,
    COUNT(*) AS num_alquileres
FROM rental r
GROUP BY anio_mes
ORDER BY anio_mes;

--26. Encuentra el promedio, la desviación estándar y varianza del total
--    pagado.
	select
		round(avg(p.amount) ,2) as promedio_total,
		round(stddev(p.amount) ,2) as desviacion_total,
		round(variance(p.amount) ,2) as varianza_total
		from payment p;

--27. ¿Qué películas se alquilan por encima del precio medio?
select
	f.title as pelicula_cara,
	f.rental_rate as precio_medio  
from film f 
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	on i.inventory_id = r.inventory_id
where f.rental_rate > (select avg(f.rental_rate) from film f)
order by precio_medio;

--28. Muestra el id de los actores que hayan participado en más de 40
--    películas.
select 
	a.actor_id as actor,
	concat(a.first_name, ' ', a.last_name),
	count(fa.film_id) as total_peliculas
from actor a
inner join film_actor fa 
	on a.actor_id = fa.actor_id
group by a.actor_id
having count(fa.film_id) > 40;

--29. Obtener todas las películas y, si están disponibles en el inventario,
--	  mostrar la cantidad disponible.
select 
	f.film_id as id,
	f.title as titulo,
	count(i.film_id) as qty
from film f 
full join inventory i
	on i.film_id = f. film_id 
group by f.film_id 
order by f.film_id;

--30. Obtener los actores y el número de películas en las que ha actuado. 
select 
	concat(a.first_name,' ', a.last_name) as actor,
	count(f.film_id) as qty_movies
from actor a
inner join film_actor fa 
	on a.actor_id = fa.actor_id
inner join film f 
	on fa.film_id = f.film_id
group by a.actor_id
order by qty_movies; 

--31. Obtener todas las películas y mostrar los actores que han actuado en
-- 	   ellas, incluso si algunas películas no tienen actores asociados.  
select 
	f.title, 
	concat(a.first_name, ' ', a.last_name) as Actor
from film f 
left join film_actor fa 
	on f.film_id = fa.film_id 
left join actor a 
	on fa.actor_id = a.actor_id
group by f.film_id, a.actor_id 
order by f.title ; 

--32. Obtener todos los actores y mostrar las películas en las que han
--	  actuado, incluso si algunos actores no han actuado en ninguna película.
select 
	concat(a.first_name, ' ', a.last_name) as Actor,
	f.title 
from actor a
left join film_actor fa 
	on a.actor_id = fa.actor_id
left join film f 
	on fa.film_id = f.film_id
group by a.actor_id, f.film_id 
order by a.actor_id;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select
	f.title, 
	r.rental_id 
from film f
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	on i.inventory_id = r.inventory_id;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select 
	concat(c.first_name, ' ', c.last_name ) as cliente_fav,
	sum(amount) as dinero_gastado
from customer c 
inner join rental r 
on c.customer_id = r.customer_id
inner join payment p 
on c.customer_id = p.customer_id
group by c.customer_id 
order by dinero_gastado desc
limit 5;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select concat (a.first_name, ' ', a.last_name ) as Actor
from actor a
where lower(a.first_name) = lower('Johnny'); 

--36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como
--	  Apellido.
select 
	a.first_name as nombre,
	a.last_name as apellido
from actor a

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select
	min(a.actor_id) as id_bajo,
	max(a.actor_id) as id_alto
from actor a

--38. Cuenta cuántos actores hay en la tabla “actorˮ.
select
	count(a.actor_id)
from actor a;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente. 
select *
from actor a
order by a.last_name asc;

--40. Selecciona las primeras 5 películas de la tabla “filmˮ. 
select *
from film f 
limit 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
--    mismo nombre. ¿Cuál es el nombre más repetido? 
select 
a.first_name,
count(a.first_name) as qty
from actor a
group by a.first_name
order by qty desc;

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select
 r.rental_id,
 concat(c.first_name, ' ', c.last_name) as Cliente 
from rental r 
inner join customer c 
	on r.rental_id = c.customer_id;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select 
	concat(c.first_name, ' ', c.last_name) as cliente,
	r.rental_id 
from customer c
left join rental r 
	on c.customer_id = r.customer_id
order by c.customer_id, r.rental_id;

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
--    esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from film f 
cross join category c;
/*   Yo pienso que no aporta valor, una pelicula no puede tener todos las categorías.
     Un cross join podría servir por ejemplo, para ver las posibilidades de un numero de loteria de navidad por ejemplo....
     donde creas 5 tablas con el valor de cada numero y haces el cross join de las 5 tablas dandote las posibilidades que hay... 
     (mejor no hacer... depresion)
*/

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select
 a.*
 from actor a 
 inner join film_actor fa 
 	on a.actor_id = fa.film_id
 inner join film f 
	on fa.film_id = f.film_id
 inner join film_category fc 
 	on f.film_id = fc.film_id
 inner join category c 
 	on fc.category_id = c.category_id
 where c."name" = 'Action'
 group by a.actor_id;

--46. Encuentra todos los actores que no han participado en películas.
select 
	a.*
from actor a
left join film_actor fa 
on a.actor_id = fa.actor_id
where fa.film_id is null
group by a.actor_id ;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select
	a.first_name as actor,
	count(fa.film_id) as peliculas
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
group by a.actor_id
order by a.actor_id; 

--48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres
--	  de los actores y el número de películas en las que han participado.
CREATE VIEW "actor_num_peliculas" AS
select
	a.first_name, 
	count(fa.film_id)
from actor a
inner join film_actor fa 
on a.actor_id = fa.actor_id
group by a.actor_id
order by a.actor_id;

--49. Calcula el número total de alquileres realizados por cada cliente.
select
c.first_name as Cliente,
count(r.rental_id) as alquileres
from rental r
inner join customer c 
on r.customer_id = c.customer_id
group by c.customer_id
order by alquileres; 

--50. Calcula la duración total de las películas en la categoría 'Action'.
select
	count(f.length) as duracion_total
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id 
where c."name" = 'Action';

--51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para
--	  almacenar el total de alquileres por cliente. 
create temporary table cliente_rentas_temporal as
select
	count(r.rental_id) as alquileres,
	c.first_name as Cliente
from rental r 
right join customer c 
	on r.customer_id = c.customer_id
group by c.customer_id 
order by alquileres;

--52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las
-- 	  películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
select
	f.title as peliculas,
	count(r.rental_id) as qty_rented
from film f 
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	on i.inventory_id = r.inventory_id
group by f.title
having count(r.rental_id) >= 10
order by qty_rented;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente
-- 	  con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena
--    los resultados alfabéticamente por título de película.		
select
f.title
from film f
inner join inventory i 
on f.film_id = i.film_id
inner join rental r 
on i.inventory_id = r.inventory_id
inner join customer c 
on r.customer_id = c.customer_id
where 
	lower(concat(c.first_name, ' ', c.last_name)) = lower('Tammy Sanders') 
	and r.return_date is null
order by f.title;

--54. Encuentra los nombres de los actores que han actuado en al menos una
-- 	  película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados
--    alfabéticamente por apellido. 
select 
	concat(a.first_name, ' ', a.last_name) as Actor 
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id
inner join film f 
	on fa.film_id = f.film_id
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
where c."name" = 'Sci-Fi'
group by a.actor_id
order by a.last_name;

--55. Encuentra el nombre y apellido de los actores que han actuado en
-- 	  películas que se alquilaron después de que la película ‘Spartacus
--    Cheaperʼ se alquilara por primera vez. Ordena los resultados
--    alfabéticamente por apellido.
select  
	concat(a.first_name, ' ', a.last_name) as Actor 
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id
inner join film f 
	on fa.film_id = f.film_id
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
inner join inventory i 
	on f.film_id = i.film_id 
inner join rental r 
	on i.inventory_id = r.inventory_id 
where r.rental_date > (select
							min(r2.rental_date)
					   from rental r2
					   inner join inventory i2 
					   	  on r2.inventory_id = i2.inventory_id 
					   inner join film f2 
						  on i2.film_id = f2.film_id 
					   where lower(f2.title) = lower('Spartacus Cheaper') 
				       )
group by a.actor_id
order by a.last_name;
		
--56. Encuentra el nombre y apellido de los actores que no han actuado en
--    ninguna película de la categoría ‘Musicʼ.
select 
	concat(a.first_name, ' ', a.last_name) as Actor 
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id
inner join film f 
	on fa.film_id = f.film_id
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
where c."name" not in ('Music')
group by a.actor_id
order by a.last_name;

--57. Encuentra el título de todas las películas que fueron alquiladas por más
--    de 8 días.
select 
	f.title
from film f 
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	on i.inventory_id = r.inventory_id
where (r.return_date - r.rental_date) > interval '8 days'

--58. Encuentra el título de todas las películas que son de la misma categoría
--	  que ‘Animationʼ. 
select
	f.title 
from film f 
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category c 
on fc.category_id = c.category_id
where lower(c."name") = lower('Animation');

--59. Encuentra los nombres de las películas que tienen la misma duración
-- 	  que la película con el título ‘Dancing Feverʼ. Ordena los resultados
--	  alfabéticamente por título de película.
select 
	f.title,
	f.length 
from film f 
where f.length = (select
				  	f2.length 
			      from film f2 
			      where lower(f2.title) = lower('Dancing Fever'));

--60. Encuentra los nombres de los clientes que han alquilado al menos 7
-- 	  películas distintas. Ordena los resultados alfabéticamente por apellido.
select
 	concat(c.first_name, ' ', c.last_name) as Cliente 
from customer c
inner join rental r 
	on c.customer_id = r.customer_id
inner join inventory i 
	on r.inventory_id = i.inventory_id 
group by cliente
having count(distinct i.film_id ) >= 7
order by c.last_name;
			      
			      
--61. Encuentra la cantidad total de películas alquiladas por categoría y
--    muestra el nombre de la categoría junto con el recuento de alquileres.
select
	count(r.rental_id) as qty_rented,
	c."name" as categoria
from rental r 
inner join inventory i 
	on r.inventory_id = i.inventory_id
inner join film f 
	on i.film_id = f.film_id
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
group by c."name" 
order by qty_rented; 
	
--62. Encuentra el número de películas por categoría estrenadas en 2006.
select
	count(f.film_id) as peliculas,
	c."name" as categorias
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id  
group by f.release_year, c."name"  
having f.release_year = '2006'
order by count(f.film_id);

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
-- 	  que tenemos.
select 
	s.*
from staff s 
cross join store s2 

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y
-- 	  muestra el ID del cliente, su nombre y apellido junto con la cantidad de
-- 	  películas alquiladas.
select
	c.customer_id as id_cliente,
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	count(r.rental_id) as qty_rental
from rental r 
right join customer c 
on r.customer_id = c.customer_id
group by c.customer_id
order by c.customer_id;



