# Master 2 - Proyecto 1 SQL
Proyecto SQL - Master Data & Analytics

Pasos seguidos:
1. Importación base de datos
2. Selección base de datos
3. Creación de consultas

Sobre los ejercicios:

## **Ejercicio 2:** Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.

1. He seleccionado los atributos que he considerado importantes (*film.title*, *film.rating*)

2. He utilizado WHERE para filtrar los resultados donde *film.rating* sea igual a 'R'.

```sql
select 
	f.title as titulo,
	f.rating as clasificacion
from film f
where f.rating = 'R';
```

## **Ejercicio 3:** Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.

1. Para mostrar el nombre del actor, he aprovechado para usar un CONCAT y unir el nombre con el apellido (*actor.first_name* y *actor.last_name*.)

2. He utilizado WHERE para filtrar los resultados donde *actor.actor_id* esté entre 30 y 40, para ello he hecho uso de BETWEEN.

```sql
select 
	concat(a.first_name, ' ', a.last_name)
from actor a
where a.actor_id between 30 and 40;
```

## **Ejercicio 4:** Obtén las películas cuyo idioma coincide con el idioma original.

1. He seleccionado los atributos que he considerado importantes (*film.title*, *film.language_id* y *film.original_language_id*.)

2. He utilizado WHERE para filtrar los resultados donde *film.language_id* sea igual a *film.original_language_id*.

**Nota:** Este ejercicio me volvió loco, no me daba ningún resultado y resulta que ninguna pelicula tiene valor en *film.original_language_id*, es decir, todos son *NULL*. 

```sql
select 
	f.title, 
	f.language_id, 
	f.original_language_id  
from film f
where f.language_id = f.original_language_id;
```

## **Ejercicio 5:** Ordena las películas por duración de forma ascendente.

1. Selecciono todos los valores de las películas dentro de la tabla *film*.

2. He utilizado ORDER BY con *film.length* y ASC.

```sql
select 
	*
from film f
order by f.length asc;

```

## **Ejercicio 6:** Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.

1. Selecciono nombre(*actor.first_name*) y apellido(*actor.last_name*) y los juntos con CONCAT.

2. He utilizado WHERE para filtrar y buscar aquellos registros en los que incluyan en el apellido la palabra 'Allen'. Como las búsquedas son **CASE SENSITIVE** he utilizado ILIKE en vez de LIKE para hacer un buen filtrado. Otra forma sería usar el like o un == y hacer un lower() a ambos parametros. Por ejemplo: *where lower(a.last_name) = lower('Allen')*

```sql
select 
	concat(a.first_name ,' ', a.last_name)
from actor a
where a.last_name ILIKE 'Allen';
```

## **Ejercicio 7:** Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.

1. He contado la cantidad de peliculas que hay a nivel de registros *film.film_id* mediante COUNT() y lo he "renombrado" como pelicula. También he mostrado el tipo de clasificación.

2. He agrupado la cantidad de peliculas contadas por el tipo de clasificación *film.rating*.

3. (extra) He ordenado de manera ascendente a través de ORDER BY las tablas utilizando *qty_pelicula* como referencia.


```sql
select 
	count(f.film_id) as qty_pelicula, 
	f.rating as clasificacion
from film f
group by f.rating 
order by qty_pelicula;
```

## **Ejercicio 8:** Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.

1. Muestro 3 columnas que considero importantes (*film.title*, *film.rating* y *film.length*).

2. He utilizado un filtrado donde considero las dos opciones:
	1. Son 'PG-13'		-> *film.rating = 'PG-13'*
	2. Duración > 3 h 	-> *film.length > 3*60*

	**Nota**: He realizado una operación por facilitarme el código, si hubiese especificado el tiempo en minutos, habría puesto los 180 directamente.

3. Posteriormente, he aprovechado para ordenar la tabla, primeramente por la clasificación y posteriormente por la duración.


```sql
select 
	f.title as titulo,
	f.rating as clasificacion,
	f.length as duracion
from film f
where f.rating = 'PG-13' or f.length > 3*60
order by f.rating asc, f.length asc;
```

## **Ejercicio 9:** Encuentra la variabilidad de lo que costaría reemplazar las películas.

1. Creo que es lo que se solicita, sin más.

```sql
select 
	variance(f.replacement_cost)
from film f; 
```

## **Ejercicio 10:** Encuentra la mayor y menor duración de una película de nuestra BBDD.

1. He utilizado las funciones MIN() y MAX() para determinar cual es la duración mínima y máxima dentro de todas las peliculas.

```sql
select 
	min(f.length) as menor_duracion,
	max(f.length) as mayor_duracion 
from film f;
```

## **Ejercicio 11:** Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

1. Muestro los datos *payment.amount* y *payment_date* para mostrar el coste y el día.

2. He ordenador los datos resultantes mediante ORDER BY a través de *payment.payment_date* de manera descendente con DESC.

3. Para conseguir el antepenúltimo registro, he usado un OFFSET con valor '2' y he limitado los resultados a '1' registro con LIMIT.

```sql
select 
	p.amount, 
	p.payment_date 
from payment p 
order by p.payment_date desc
offset 2
limit 1;
```

## **Ejercicio 12:** Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.

1. He realizado mi consulta sobre *film.title* y *film.rating*

2. He filtrado mediante WHERE los casos que no se incluyan en una lista mediante NOT IN.

3. (extra) He ordenador los resultados con ORDER BY a través de *film.rating*

```sql
select 
	f.title as titulo, 
	f.rating as clasificacion
from film f 
where f.rating not in ('NC-17', 'G')
order by f.rating;
```

## **Ejercicio 13:** Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

1. He realizado la consulta sobre la clasificacion *film.rating* y la longitud *film.length*, para la longitud, al buscar el promedio, he utilizado AVG para conseguirlo, y como el resultado tenía demasiados dígitos, he utilizado un ROUND() con 2 digitios max.

2. He agrupado los resultados por la clasificación *film.rating*.

```sql
select 
	f.rating as clasificacion,
	round(avg(f.length), 2) as promedio_duracion
from film f 
group by f.rating;
```

## **Ejercicio 14:** Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

1. He seleccionado *film.title* y *film.length*, esta segunda no sería necesaría, pero estaba interesado en tener este dato para confirmar el resultado de la consulta.

2. He filtrado la duración de la película con WHERE siendo la duración > 180.

3. (extra) He ordenador los resultados con ORDER BY mediante *film.length*.

```sql
select
	f.title,
	f.length 
from film f
where f.length > 180
order by f.length;
```

## **Ejercicio 15:** ¿Cuánto dinero ha generado en total la empresa?

1. He sumando todas las cantidades de *payment.amount* mediante SUM()

```sql
select 
	sum(p.amount)
from payment p;
```

## **Ejercicio 16:** Muestra los 10 clientes con mayor valor de id.

1. He seleccionado todos los datos de la tabla "customer".

2. He ordenador desciendentemente los resultados usando el PK *customer.customer_id*.

3. He limitado los resultados con LIMIT a '10'.

```sql
select 
	*
from customer c 
order by c.customer_id desc
limit 10;
```

## **Ejercicio 17:** Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.

1. Selecciono Nombre y Apellido en una misma tabla con CONCAT(), también selecciono el título de la película.

2. Como estoy buscando principalmente los nombres de los actores, uso la tabla *actor* como referencia con FROM.

3. Realizo las uniones necesarias para alcanzar la tabla *film*. He utilizado los join tipo inner para buscar las uniones existentes entre elementos.

4. Realizo una filtro mediante WHERE donde *film.title* contenga con ILIKE 'Egg Igby', como hemos mencionado anteriormente, con ILIKE filtro case sensitive.

```sql
select
	concat(a.first_name ,' ', a.last_name ),
	f.title 
from actor a
inner join film_actor fa 
	on a.actor_id = fa.actor_id
inner join film f 
	on fa.film_id = f.film_id
where f.title ILIKE 'Egg Igby';
```

## **Ejercicio 18:** Selecciona todos los nombres de las películas únicos.

1. He seleccionado los títulos únicos de la tabla film.

2. Los he ordenador ascendentemente mediante ORDER BY con *film.title*.

```sql
select 
	distinct title as film_unico
from film f
order by f.title ;
```

## **Ejercicio 19:** Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.

1. Para ver que la consulta es correcta, he seleccionado:
	1. titulo como *film.title*
	2. duracion como *film.length*
	3. categoria como *category.name*

2. Cómo lo que estamos buscando principalmente es el título, usamos en FROM la tabla *film* y vamos uniendo tablas desde *film*, pasando por *film_category* hasta llegar a *category*. Se ha utilizado INNER JOIN porque buscamos relaciones existentes que tengan datos relacionables.

3. Filtramos con WHERE las dos condiciones que buscamos mediante AND.
	1. Duración 	-> filtramos con "*film.length* > 180"
	2. Categoria 	-> filtramos con ILIKE (case sensitive) *category.name* ILIKE 'Comedy'

4. (extra) Ordeno los resultados mediante ORDER BY a través de *film.length* de manera ascendente.

```sql
select 
	f.title as titulo,
	f.length as duracion,
	c.name as categoria
from film f
inner join film_category fc 
	on fc.film_id = f.film_id 
inner join category c 
	on fc.category_id = c.category_id 
where f.length > 180 and c.name ILIKE 'Comedy'
order by f.length;
```

## **Ejercicio 20:** Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

1. He seleccionado:
	1. cantidad -> He contado cuantos registros hay con count(*film.film_id*)
	2. promedio_duracion -> He hecho el promedio y redondeado a 2 decimales con AVG() y ROUND()
	3. categoría -> *category.name*

2. He cogido la consulta desde *film* hasta *category* pasando por *film_category*. He utilizado INNER JOIN por que busco los resultados que coincidan.

3. He agrupado los resultados con GROUP BY por el nombre de la categoría *category.name*

4. He ordenado la lista mediante ORDER BY por *cantidad* que es el nombre que hemos puesto a la columna del contaje de peliculas.

```sql
select
	count(f.film_id) as cantidad,
	round(avg(f.length),2) as promedio_duracion,
	c.name as categoria
from film f
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
group by c.name
having avg(f.length) > 110
order by cantidad;
```

## **Ejercicio 21:** ¿Cuál es la media de duración del alquiler de las películas?

1. Creo que se pide esto, no tiene más que comentar.

```sql
select 
	avg(f.rental_duration) 
from film f;
```

## **Ejercicio 22:** Crea una columna con el nombre y apellidos de todos los actores y actrices.

1. Creo que se pide esto, no tiene más que comentar.

```sql
select
	concat(a.first_name, ' ',a.last_name)
from actor a;
```

## **Ejercicio 23:** Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

1. He seleccionado dos items:
	1. num_alquileres 	-> El contaje de todos los registros de la tabla *rental* mediante COUNT() y *rental.rental_id*.
	2. dia_alquiler 	-> Uso la funcion DATE() para buscar la fecha sin importar la hora.

2. He agrupado los resultados mediante DATE(*rental.rental_date*)

3. He ordenado los resultados mediante ORDER BY de manera DESC (descendente) utilizando *num_alquileres* que es el alias del *count(rental.rental_id)*

```sql
select 
	count(r.rental_id) as num_alquileres,
	date(r.rental_date) as dia_alquiler
from rental r
group by date(r.rental_date)
order by num_alquileres desc;
```

## **Ejercicio 24:** Encuentra las películas con una duración superior al promedio.

1. He seleccionado todos los registros de film

2. He filtrado los registros con una subconsulta utilizando WHERE
	1. En la subconsulta buscamos un único dato, el AVG(*film.length*), que viene a ser el promedio de las películas, ese dato lo utilizo para compararlo con la duración de los registros y con ello muestro solo los registros que necesitamos.

```sql
select 
	*
from film f
where f.length > (	select 
						avg(length) 
					from film);
```

## **Ejercicio 25:** Averigua el número de alquileres registrados por mes.

1. Los campos que muestro en mi consulta son:
	1. anio_mes -> Esta variable se compone de una extracción de la *rental.rental_date*
		1. El año lo extraigo con EXTRACT(YEAR FROM date)
		2. El mes lo extraigo con EXTRACT(MONTH FROM date)
		3. Teniendo estos datos, con un CONCAT(), genero una nuevo formato fecha AÑO-MES
	2. num_alquileres -> El contaje de todos los registros de la tabla *rental*.

2. Agrupo los registros con GROUP BY por el nuevo campo *anio_mes*

3. Ordeno los registros con ORDER BY por el nuevo campo *anio_mes*

```sql
select  
    concat(extract(year from r.rental_date), '-', extract(month from r.rental_date)) as anio_mes,
    count(r.rental_id) as num_alquileres
from rental r
group by anio_mes
order by anio_mes;
```

## **Ejercicio 26:** Encuentra el promedio, la desviación estándar y varianza del total pagado.

1. Para mostrar lo solicitado:
	1. Promedio 	-> AVG()
	2. Desviación 	-> STDDEV()
	3. Varianza 	-> VARIANCE()

```sql
select
	round(avg(p.amount) ,2) as promedio_total,
	round(stddev(p.amount) ,2) as desviacion_total,
	round(variance(p.amount) ,2) as varianza_total
from payment p;
```

## **Ejercicio 27:** ¿Qué películas se alquilan por encima del precio medio?

1. Selecciono los campos *film.title* y *film.rental_rate*

2. Buscamos Peliculas, por lo que utilizamos *film* en FROM y hacemos las uniones correspondientes para llegar hasta *rental*, pasando por *inventory*. Utilizamos INNER JOIN porque queremos las relaciones existentes.

3. Para filtrar he generado una subconsulta que busca en film la media de alquiler con AVG(*film.rental_rate*). Esta subconsulta la he utlizado en el WHERE para compararlo con el *film.rental_rate* unitario.

4. Finalmente, he ordenado los datos obtenidos por precio_medio de manera ascendente ASC.

```sql
select
	f.title as pelicula_cara,
	f.rental_rate as precio_medio  
from film f 
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	on i.inventory_id = r.inventory_id
where f.rental_rate > (	select 
							avg(rental_rate) 
						from film )
order by precio_medio asc;
```

## **Ejercicio 28:** Muestra el id de los actores que hayan participado en más de 40 películas.

1. He mostrado los datos más relevantes:
	1. Id del actor -> *actor.actor_id*
	2. Nombre actor -> usando CONCAT() de los campos *actor.first_name* y *actor.last_name*.
	3. Total Peliculas -> usando COUNT() he contado los registros de *film_actor*, ya que son los que vinculos con *film*, como no necesitamos saber que película en sí, ese sirve.

2. He unido las tablas *actor* y *film_actor* con inner join, ya que busco lo que hayan participado, es decir, los que tengan relaciones.

3. He agrupado por *actor.actor_id*

4. He utilizado HAVING para filtrar aquellos que hayan realizado > X peliculas, mediante el COUNT() de los registros de *film_actor.film_id*.

```sql
select 
	a.actor_id as actor,
	concat(a.first_name, ' ', a.last_name),
	count(fa.film_id) as total_peliculas
from actor a
inner join film_actor fa 
	on a.actor_id = fa.actor_id
group by a.actor_id
having count(fa.film_id) > 40;
```

## **Ejercicio 29:** Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

1. He seleccionado los campos:
	1. id -> *film.film_id*
	2. titulo -> *film.title*
	3. qty -> Usando COUNT(), el contaje de todos los *inventory.film_id*

2. He unido las tablas *film* y *inventory* con FULL JOIN, porque quiero todas las relaciones, existan o no existan.

3. He agrupado por *film.film_id* ya que busco TODAS las películas.

4. He ordenado por *film.film_id*.

```sql
select 
	f.film_id as id,
	f.title as titulo,
	count(i.film_id) as qty
from film f 
full join inventory i
	on i.film_id = f. film_id 
group by f.film_id 
order by f.film_id;
```

## **Ejercicio 30:** Obtener los actores y el número de películas en las que ha actuado. 

1. He seleccionado:
	1. Actor -> CONCAT del nombre y apellido
	2. Qty_Movies -> COUNT de *film.film_id*

2. He unido *actor* con *film_actor* con *film* 

3. He agroupado por *actor.actor_id*

4. He ordenado por *qty_movies*

```sql
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
```

## **Ejercicio 31:** Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

1. Parto de film porque quiero todas las películas.

2. Uso LEFT JOIN hacia film_actor y actor para no perder las películas sin actores.

```sql
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
```

## **Ejercicio 32:** Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

1. Parto de actor porque quiero todos los actores.

2. Uso LEFT JOIN hacia *film_actor* y *film* para no perder actores sin películas.

```sql
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
```

## **Ejercicio 33:** Obtener todas las películas que tenemos y todos los registros de alquiler.

1. Parto de film.

2. Me uno a *inventory* y *rental* con LEFT JOIN para incluir películas sin alquileres.

```sql
select
	f.title, 
	r.rental_id 
from film f
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	on i.inventory_id = r.inventory_id;
```

## **Ejercicio 34:** Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

1. Sumo *payment.amount* por cliente.

2. Ordeno de mayor a menor y me quedo con 5.

```sql
select 
	concat(c.first_name, ' ', c.last_name ) as cliente_fav,
	sum(p.amount) as dinero_gastado
from customer c 
inner join rental r 
	on c.customer_id = r.customer_id
inner join payment p 
	on c.customer_id = p.customer_id
group by c.customer_id 
order by dinero_gastado desc
limit 5;
```

## **Ejercicio 35:** Selecciona todos los actores cuyo primer nombre es 'Johnny'.

1. Trabajo directamente sobre la tabla actor.

2. Filtro por el nombre igual a 'Johnny' con ILIKE para evitar case sensitive en la columna *actor.first_name*.

```sql
select 
	concat (a.first_name, ' ', a.last_name ) as Actor
from actor a
where a.first_name ilike 'Johnny'; 
```

## **Ejercicio 36:** Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.

1. Selecciono solo las columnas first_name y last_name y les cambio el nombre con AS a nombre y apellido.

```sql
select 
	a.first_name as nombre,
	a.last_name as apellido
from actor a;
```

## **Ejercicio 37:** Encuentra el ID del actor más bajo y más alto en la tabla actor.

1. Uso funciones de agregación MIN() y MAX() sobre *actor.actor_id*.

2. Renombro los resultados para identificar claramente mínimo y máximo.

```sql
select
	min(a.actor_id) as id_bajo,
	max(a.actor_id) as id_alto
from actor a;
```

## **Ejercicio 38:** Cuenta cuántos actores hay en la tabla “actorˮ.

1. Quiero saber cuántos actores hay, así que uso COUNT() y cuento los registros dentro de *actor*, es decir, *actor.actor_id*.

2. Doy un alias al resultado para que sea más legible.

```sql
select
	count(a.actor_id) as num_actores
from actor a;
```
 
## **Ejercicio 39:** Selecciona todos los actores y ordénalos por apellido en orden ascendente.

1. Selecciono todos los actores.

2. Ordeno por last_name ascendente y, como segundo criterio, por first_name.

```sql
select 
	*
from actor a
order by a.last_name asc;
```

## **Ejercicio 40:** Selecciona las primeras 5 películas de la tabla “filmˮ.

1. Selecciono todas las columnas de *film*.

2. Ordeno por *film.film_id*.

3. Uso LIMIT 5 para mostrar solo las primeras 5 películas.

```sql
select 
	*
from film f 
limit 5;
```

## **Ejercicio 41:** Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido? 

1. Agrupo actores por el campo first_name.

2. Cuento cuántos actores tiene cada nombre con COUNT(*).

3. Ordeno descendente para ver primero los más repetidos.

```sql
select 
	a.first_name,
	count(a.first_name) as qty
from actor a
group by a.first_name
order by qty desc;
```

## **Ejercicio 42:** Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

1. Parto de la tabla *rental* porque quiero todos los alquileres.

2. Uno la tabla con INNER JOIN con *customer* para obtener el nombre del cliente. Uso INNER JOIN porque necesito vinculos existentes.

3. Muestro el id de alquiler y el nombre completo del cliente.

```sql
select
	r.rental_id,
	concat(c.first_name, ' ', c.last_name) as Cliente 
from rental r 
inner join customer c 
	on r.rental_id = c.customer_id;
```

## **Ejercicio 43:** Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

1. Parto de customer porque quiero mostrar todos los clientes, tengan o no alquileres.

2. Uso LEFT JOIN con *rental* para no perder clientes sin alquileres.

3. Ordeno por cliente y posteriormente con fecha de alquiler.

```sql
select 
	concat(c.first_name, ' ', c.last_name) as cliente,
	r.rental_id 
from customer c
left join rental r 
	on c.customer_id = r.customer_id
order by c.customer_id, r.rental_id;
```
 
## **Ejercicio 44:** Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

1. Hago un CROSS JOIN entre film y category.

2. Esto genera todas las combinaciones posibles película–categoría, aunque no tengan relación real.

Yo pienso que no aporta valor, una pelicula no puede tener todos las categorías.

Un cross join podría servir por ejemplo, para ver las posibilidades de un numero de loteria de navidad, es decir, donde creas 5 tablas con el valor de cada numero y haces el cross join de las 5 tablas dandote las posibilidades que hay... 
(mejor no hacer... que depresion)

```sql
select 
	*
from film f 
cross join category c;
```

## **Ejercicio 45:** Encuentra los actores que han participado en películas de la categoría 'Action'.

1. Necesito actores + categoría 'Action'.

2. Relaciono *actor* -> *film_actor* -> *film* -> *film_category* -> *category*. Utilizo INNER JOINS porque necesito vinculos con datos.

3. Filtro en WHERE por *category.name* ilike 'Action'.

```sql
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
 where c.name ilike 'Action'
 group by a.actor_id;
```

## **Ejercicio 46:** Encuentra todos los actores que no han participado en películas.

1. Quiero actores sin películas.

2. Hago LEFT JOIN de actor con *film_actor*, hago esto, porque quiero todos los registros de los actores, indistintamente de que hayan o no participado en películas.

3. En el WHERE filtro por los casos donde no haya relación (fa.actor_id IS NULL).

```sql
select 
	a.*
from actor a
left join film_actor fa 
	on a.actor_id = fa.actor_id
where fa.film_id is null
group by a.actor_id ;
```

## **Ejercicio 47:** Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

1. Parto de actor y lo uno con *film_actor* mediante INNER JOIN, necesito relaciones entre tablas.

2. Cuento cuántas películas tiene cada actor con COUNT(*film_acto.film_id*).

3. Agrupo por el identificador del actor *actor.actor_id*.

4. Ordeno por cantidad de películas.

```sql
select
	a.first_name as actor,
	count(fa.film_id) as peliculas
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id
group by a.actor_id
order by peliculas; 
```

## **Ejercicio 48:** Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.

1. Reutilizo la lógica del ejercicio 47.

2. En vez de SELECT normal, creo una vista con CREATE VIEW.

```sql
CREATE VIEW "actor_num_peliculas" AS
select
	a.first_name, 
	count(fa.film_id)
from actor a
inner join film_actor fa 
	on a.actor_id = fa.actor_id
group by a.actor_id
order by a.actor_id;
```

## **Ejercicio 49:** Calcula el número total de alquileres realizados por cada cliente.

1. Parto de *customer* para listar clientes.

2. Hago LEFT JOIN con rental para contar alquileres por cliente y mostrar todos los clientes, tengan o no alquileres.

3. Uso COUNT(r.rental_id) y agrupo por customer_id.

4. Ordeno por número de alquileres de mayor a menor.

```sql
select 
    concat(c.first_name, ' ', c.last_name) as cliente,
    count(r.rental_id) as num_alquileres
from customer c
left join rental r 
    on c.customer_id = r.customer_id
group by c.customer_id
order by num_alquileres desc;
```

## **Ejercicio 50:** Calcula la duración total de las películas en la categoría 'Action'.

1. Quiero la suma de duración por categoría 'Action'.

2. Relaciono *film* -> *film_category* -> *category*.

3. Filtro WHERE c.name ilike 'Action'.

4. Aplico SUM(*film.length*) y agrupo por categoría.

```sql
select
	c.name as categoria,
	sum(f.length) as duracion_total
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id 
where c.name ilike 'Action'
group by categoria;
```

## **Ejercicio 51:** Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente. 

1. Calculo los alquileres por cliente igual que en el 49.

2. Creo una tabla temporal con CREATE TEMPORARY TABLE ... AS SELECT ....

```sql
create temporary table cliente_rentas_temporal as
select 
    concat(c.first_name, ' ', c.last_name) as cliente,
    count(r.rental_id) as num_alquileres
from customer c
left join rental r 
    on c.customer_id = r.customer_id
group by c.customer_id
order by num_alquileres desc;
```

## **Ejercicio 52:** Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.

1. Necesito películas con al menos 10 alquileres.

2. Relaciono *film* -> *inventory* -> *rental*.

3. Cuento alquileres por película con COUNT(*rental.rental_id*).

4. Filtro con HAVING >= 10 y ordeno por *qty_rented*.

5. Guardo el resultado en una tabla temporal.

```sql
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
```

## **Ejercicio 53:** Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

1. Identifico al cliente ‘Tammy Sanders’.

2. Relaciono film -> inventory -> rental -> customer.

3. Filtro por:
	1. nombre y apellidos.
	2. Filtro por return_date IS NULL.

4. Ordeno alfabéticamente con ORDER BY mediante *film.title*.

```sql
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
	(concat(c.first_name, ' ', c.last_name) ILIKE 'Tammy Sanders') 
	and r.return_date is null
order by f.title;
```

## **Ejercicio 54:** Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido. 

1. Busco actores que hayan actuado en alguna película de categoría 'Sci-Fi'.

2. Relaciono *actor* -> *film_actor* -> *film* -> *film_category* -> *category*.

3. Filtro WHERE c.name ilike 'Sci-Fi'.

4. Agrupo con GROUP BY por *actor.actor_id* y ordeno con ORDER BY por *actor.last_name*.

```sql
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
where c.name ilike 'Sci-Fi'
group by a.actor_id
order by a.last_name;
```

## **Ejercicio 55:** Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

1. Primero necesito la fecha del primer alquiler de ‘Spartacus Cheaper’. En una subconsulta calculo MIN(*rental_date*) para esa película. Con esa fecha, busco todos los alquileres posteriores.

2. Relaciono esos alquileres con los actores.

3. Agrupo con GROUP BY con *actor.actor_id*

4. Ordeno con ORDER BY con *actor.last_name* ascendentemente.

```sql
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
					   where f2.title ilike 'Spartacus Cheaper') 
group by a.actor_id
order by a.last_name;
```

## **Ejercicio 56:** Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.

1. Quiero actores que no tengan películas de categoría 'Music'.

2. Uso WHERE NOT IN 'Music' para excluir el caso en que sí tenga alguna película de esa categoría.

3. Agrupo por el *actor.actor_id*

4. Ordenor por el apellido *actor.last_name*

```sql
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
where c.name not in ('Music')
group by a.actor_id
order by a.last_name;
```

## **Ejercicio 57:** Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

1. Calculo la duración del alquiler como diferencia entre return_date y rental_date con ( x - y ) > interval usando '8 days' como la cantidad de días a comparar.

```sql
select 
	f.title
from film f 
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	on i.inventory_id = r.inventory_id
where (r.return_date - r.rental_date) > interval '8 days'
```

## **Ejercicio 58:** Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

1. Como buscamos películas, usamos la tabla *film* desde FROM

2. Vinculamos esta tabla con *film_category* y posteriormente *category* para consultar la categoría.

3. Hago un filtro WHERE donde *category.name* sea 'Animation' con ILIKE.

```sql
select
	f.title 
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id 
inner join category c 
	on fc.category_id = c.category_id
where c.name ilike 'Animation';
```

## **Ejercicio 59:** Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.

1. En una subconsulta obtengo la duración de ‘Dancing Fever’.

2. Selecciono todas las películas con la misma duración.

```sql
select 
	f.title,
	f.length 
from film f 
where f.length = (	select
						f2.length 
			      	from film f2 
			      	where f2.title ilike 'Dancing Fever');
```

## **Ejercicio 60:** Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

1. Selecciono el nombre completo del cliente concatenando con CONCAT() *customer.first_name* y *customer.last_name* y lo renombro como Cliente.

2. Uno las tablas con INNER JOIN para tener relaciones existentes.

3. Agrupo los resultados por el alias Cliente con GROUP BY.

4. Utilizo HAVING para comprobar que hay 7 o más películas alquiladas.

5. Finalmente, ordeno el resultado por el apellido del cliente usando ORDER BY *customer.last_name*.

```sql
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
```

## **Ejercicio 61:** Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

1. Selecciono:
	1. Cuento la cantidad total de alquileres (COUNT(r.rental_id)) y renombro el resultado como qty_rented. 
	2. Selecciono el nombre de la categoría desde la tabla category y lo renombro como categoria.

2. Relaciono las tablas mediante INNER JOIN para obtener la categoría de cada alquiler.

3. Agrupo los registros por el nombre de la categoría (GROUP BY *customer.name*) para obtener un recuento por cada una.

4. Ordeno el resultado por la cantidad de alquileres (qty_rented) de forma ascendente (ORDER BY *qty_rented*).

```sql
select
	count(r.rental_id) as qty_rented,
	c.name as categoria
from rental r 
inner join inventory i 
	on r.inventory_id = i.inventory_id
inner join film f 
	on i.film_id = f.film_id
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
group by c.name 
order by qty_rented; 
```

## **Ejercicio 62:** Encuentra el número de películas por categoría estrenadas en 2006.

1. Selecciono el recuento de películas COUNT() y el nombre de la categoría.

2. Uno las tablas necesarias para obtener la categoría de cada película.

3. Agrupo por año y categoría para poder contar por cada grupo.

4. Filtro en HAVING solo el año 2006.

5. Ordeno ascendentemente por la cantidad de películas.

```sql
select
	count(f.film_id) as peliculas,
	c.name as categorias
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id  
group by f.release_year, c.name
having f.release_year = '2006'
order by count(f.film_id);
```

## **Ejercicio 63:** Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

1. No mucho que decir, saco todas las uniones posibles.

```sql
select 
	s.*
from staff s 
cross join store s2 
```

## **Ejercicio 64:** Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

1. Selecciono el id, el nombre completo del cliente y el número de alquileres.

2. Uso RIGHT JOIN para mostrar todos los clientes aunque no tengan alquileres.

3. Agrupo por el id del cliente *customer.customer_id* para poder contar sus alquileres.

4. Ordeno el resultado por el id del cliente *customer.customer_id*.

```sql
select
	c.customer_id as id_cliente,
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	count(r.rental_id) as qty_rental
from rental r 
right join customer c 
	on r.customer_id = c.customer_id
group by c.customer_id
order by c.customer_id;
```
