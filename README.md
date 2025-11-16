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

```sql
```

## **Ejercicio 15:** ¿Cuánto dinero ha generado en total la empresa?

```sql
```

## **Ejercicio 16:** Muestra los 10 clientes con mayor valor de id.

```sql
```

## **Ejercicio 17:** Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.

```sql
```

## **Ejercicio 18:** Selecciona todos los nombres de las películas únicos.

```sql
```

## **Ejercicio 19:** Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.

```sql
```

## **Ejercicio 20:** Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

```sql
```

## **Ejercicio 21:** ¿Cuál es la media de duración del alquiler de las películas?

```sql
```

## **Ejercicio 22:** Crea una columna con el nombre y apellidos de todos los actores y actrices.

```sql
```

## **Ejercicio 23:** Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

```sql
```

## **Ejercicio 24:** Encuentra las películas con una duración superior al promedio.

```sql
```

## **Ejercicio 25:** Averigua el número de alquileres registrados por mes.

```sql
```

## **Ejercicio 26:** Encuentra el promedio, la desviación estándar y varianza del total pagado.

```sql
```

## **Ejercicio 27:** ¿Qué películas se alquilan por encima del precio medio?

```sql
```

## **Ejercicio 28:** Muestra el id de los actores que hayan participado en más de 40 películas.

```sql
```

## **Ejercicio 29:** Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

```sql
```

## **Ejercicio 30:** Obtener los actores y el número de películas en las que ha actuado. 

```sql
```

## **Ejercicio 31:** Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

```sql
```

## **Ejercicio 32:** Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

```sql
```

## **Ejercicio 33:** Obtener todas las películas que tenemos y todos los registros de alquiler.

```sql
```

## **Ejercicio 34:** Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

```sql
```

## **Ejercicio 35:** Selecciona todos los actores cuyo primer nombre es 'Johnny'.

```sql
```

## **Ejercicio 36:** Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.

```sql
```

## **Ejercicio 37:** Encuentra el ID del actor más bajo y más alto en la tabla actor.

```sql
```

## **Ejercicio 38:** Cuenta cuántos actores hay en la tabla “actorˮ.

```sql
```
 
## **Ejercicio 39:** Selecciona todos los actores y ordénalos por apellido en orden ascendente.

```sql
```

## **Ejercicio 40:** Selecciona las primeras 5 películas de la tabla “filmˮ.

```sql
```

## **Ejercicio 41:** Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido? 

```sql
```

## **Ejercicio 42:** Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

```sql
```

## **Ejercicio 43:** Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

```sql
```
 
## **Ejercicio 44:** Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

```sql
```

## **Ejercicio 45:** Encuentra los actores que han participado en películas de la categoría 'Action'.

```sql
```

## **Ejercicio 46:** Encuentra todos los actores que no han participado en películas.

```sql
```

## **Ejercicio 47:** Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

```sql
```

## **Ejercicio 48:** Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.

```sql
```

## **Ejercicio 49:** Calcula el número total de alquileres realizados por cada cliente.

```sql
```

## **Ejercicio 50:** Calcula la duración total de las películas en la categoría 'Action'.

```sql
```

## **Ejercicio 51:** Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente. 

```sql
```

## **Ejercicio 52:** Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.

```sql
```

## **Ejercicio 53:** Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

```sql
```

## **Ejercicio 54:** Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido. 

```sql
```

## **Ejercicio 55:** Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

```sql
```

## **Ejercicio 56:** Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.

```sql
```

## **Ejercicio 57:** Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

```sql
```

## **Ejercicio 58:** Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

```sql
```

## **Ejercicio 59:** Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.

```sql
```

## **Ejercicio 60:** Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

```sql
```

## **Ejercicio 61:** Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

```sql
```

## **Ejercicio 62:** Encuentra el número de películas por categoría estrenadas en 2006.

```sql
```

## **Ejercicio 63:** Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

```sql
```

## **Ejercicio 64:** Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

```sql
```
