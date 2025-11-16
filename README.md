# Master 2 - Proyecto 1 SQL
Proyecto SQL - Master Data & Analytics

Pasos seguidos:
1- Importación base de datos
2- Selección base de datos
3- Creación de consultas

Sobre los ejercicios:

## **Ejercicio 2:** Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.

```sql
select 
	f.title as titulo,
	f.rating as clasificacion
from film f
where f.rating = 'R';
```

## **Ejercicio 3:** Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.

## **Ejercicio 4:** Obtén las películas cuyo idioma coincide con el idioma original.

## **Ejercicio 5:** Ordena las películas por duración de forma ascendente. 

## **Ejercicio 6:** Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.

## **Ejercicio 7:** Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.

## **Ejercicio 8:** Encuentra el título de todas las películas que son ‘PG13ʼ o tienen una duración mayor a 3 horas en la tabla film.


## **Ejercicio 9:** Encuentra la variabilidad de lo que costaría reemplazar las películas.

## **Ejercicio 10:** Encuentra la mayor y menor duración de una película de nuestra BBDD.

## **Ejercicio 11:** Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

## **Ejercicio 12:** Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.

## **Ejercicio 13:** Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

## **Ejercicio 14:** Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

## **Ejercicio 15:** ¿Cuánto dinero ha generado en total la empresa?

## **Ejercicio 16:** Muestra los 10 clientes con mayor valor de id.

## **Ejercicio 17:** Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.

## **Ejercicio 18:** Selecciona todos los nombres de las películas únicos.

## **Ejercicio 19:** Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.

## **Ejercicio 20:** Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

## **Ejercicio 21:** ¿Cuál es la media de duración del alquiler de las películas?

## **Ejercicio 22:** Crea una columna con el nombre y apellidos de todos los actores y actrices.

## **Ejercicio 23:** Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

## **Ejercicio 24:** Encuentra las películas con una duración superior al promedio.

## **Ejercicio 25:** Averigua el número de alquileres registrados por mes.

## **Ejercicio 26:** Encuentra el promedio, la desviación estándar y varianza del total pagado.

## **Ejercicio 27:** ¿Qué películas se alquilan por encima del precio medio?

## **Ejercicio 28:** Muestra el id de los actores que hayan participado en más de 40 películas.

## **Ejercicio 29:** Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

## **Ejercicio 30:** Obtener los actores y el número de películas en las que ha actuado. 

## **Ejercicio 31:** Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

## **Ejercicio 32:** Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

## **Ejercicio 33:** Obtener todas las películas que tenemos y todos los registros de alquiler.

## **Ejercicio 34:** Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

## **Ejercicio 35:** Selecciona todos los actores cuyo primer nombre es 'Johnny'.

## **Ejercicio 36:** Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.

## **Ejercicio 37:** Encuentra el ID del actor más bajo y más alto en la tabla actor.

## **Ejercicio 38:** Cuenta cuántos actores hay en la tabla “actorˮ.
 
## **Ejercicio 39:** Selecciona todos los actores y ordénalos por apellido en orden ascendente.

## **Ejercicio 40:** Selecciona las primeras 5 películas de la tabla “filmˮ.

## **Ejercicio 41:** Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido? 

## **Ejercicio 42:** Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

## **Ejercicio 43:** Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
 
## **Ejercicio 44:** Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

## **Ejercicio 45:** Encuentra los actores que han participado en películas de la categoría 'Action'.

## **Ejercicio 46:** Encuentra todos los actores que no han participado en películas.

## **Ejercicio 47:** Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

## **Ejercicio 48:** Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.

## **Ejercicio 49:** Calcula el número total de alquileres realizados por cada cliente.

## **Ejercicio 50:** Calcula la duración total de las películas en la categoría 'Action'.

## **Ejercicio 51:** Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente. 

## **Ejercicio 52:** Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.

## **Ejercicio 53:** Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

## **Ejercicio 54:** Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido. 

## **Ejercicio 55:** Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

## **Ejercicio 56:** Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.

## **Ejercicio 57:** Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

## **Ejercicio 58:** Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

## **Ejercicio 59:** Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.

## **Ejercicio 60:** Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

## **Ejercicio 61:** Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

## **Ejercicio 62:** Encuentra el número de películas por categoría estrenadas en 2006.

## **Ejercicio 63:** Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

## **Ejercicio 64:** Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.