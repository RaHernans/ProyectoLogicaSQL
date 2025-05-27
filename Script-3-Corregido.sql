-- DATA PROYECT: LógicaConsultasSQL
-- 2. Muestra los nombres de todas las películas con una clasificación por edades 'R'
SELECT title, rating
FROM film AS f 
WHERE rating = 'R'

--3. Encuentra los nombres de los actores que tengan un "actor_id" entre 30 y 40.
SELECT actor_id, first_name
FROM actor AS a 
WHERE actor_id BETWEEN 30 AND 40;

--4. Obten las películas cuyo idioma coincide con el idioma original
SELECT f.original_language_id, l."name"
FROM film AS f 
full JOIN "language" AS l 
ON f.original_language_id = L.language_id;

/* En este caso, NO sé si estaría bien la consulta, ya que en la tabla film la columna `orignal_languaje tiene un 
valor nulo en todas las filas. */

-- 5. Ordena ls películas por duración de forma ascendente.
SELECT length, title 
FROM film AS f 
ORDER BY length ;

--6. Encuentra el nombre y apellido de los actores que tengan "Allen" en su apellido.
SELECT first_name, last_name 
FROM actor AS a 
WHERE last_name ILIKE '%Allen%';

/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla 'film' y muestra la clasificicación
** junto con el recuento.*/
SELECT f.rating, COUNT (f.rating ) AS "Recuento"
FROM film AS f 
GROUP BY rating ;


-- 8. Encuentra la cantidad total de películas que son 'PG-13' o tienen una duración mayor a 3 horas en la tabla film.

SELECT COUNT(*) AS total_peliculas, f.rating AS "Clasificación", f.length AS "Duración"
FROM film AS f
WHERE f.rating = 'PG-13' OR f.length > 180;

SELECT F.title AS "Título", f.rating AS "Clasificación" , F.length AS "Duración"
FROM film AS f 
WHERE f.length >180 OR rating = 'PG-13';

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT ROUND (VARIANCE (f.replacement_cost ),2) AS "Varianza", ROUND (STDDEV (f.replacement_cost),2) AS "Desviación_típica"
FROM film AS f;
 
-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT MIN (F.length) AS "Menor_duración", MAX (f.length) AS "Mayor_duracion"
FROM film AS f ;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT p.amount 
FROM payment AS p 
JOIN rental AS r ON p.rental_id = r.rental_id 
ORDER BY r.rental_date DESC, r.rental_id DESC
OFFSET 2 
LIMIT 1;

--12. Encuentra el título de las películas en la tabla "film" que no sean ni 'NC-17' ni 'G' en cuanto a clasificación.
SELECT f.title, f.rating  
FROM film AS f 
WHERE f.rating NOT in ('NC-17','G');

ROUND (AVG(length));2 AS "Promedio"

*/13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación
junto con el promedio de duración. *//
SELECt rating, ROUND (AVG(length),2) AS "Promedio"
FROM film as f
group by rating;

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT title, length
FROM film
WHERE length >180;

--15. ¿Cuanto dinero ha generado en total la empresa?
SElECT SUM(amount) AS Total_generado
FROM payment as p;

--16. Muestra los 10 clientes con mayor valor de id.
SELECT c.customer_id AS "Id_Cliente", c.first_name AS "Nombre"
FROM customer AS c 
ORDER BY customer_id DESC 
LIMIT 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título 'Egg Igby'.
SELECT f.title AS "Película", CONCAT (a.first_name,' ', a.last_name) AS "Actores"
FROM actor AS a 
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id 
INNER JOIN film AS f ON fa.film_id = f.film_id 
WHERE f.title ilike 'EGG IGBY';

--18. Selecciona todos los nombre de las películas únicos.
SELECT f.title AS "Películas"
FROM film AS f 

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla "film"

SELECT f.title AS "Películas_comedia", f.length AS "Duración"
FROM film AS f 
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
WHERE c."name" = 'Comedy' AND f.length >180;

--*/20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra
--el nombre de la categoría junto con el promedio de duración. */
SELECT c."name" AS "Categoría", round(AVG (f.length),2) AS "Duración_promedio"
FROM film AS f 
INNER JOIN film_category AS fc ON f.film_id = f.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c."name"
HAVING Avg(f.length)> 110;

-- 21. ¿Cual es la media de duración del alquiler de las películas?
SELECT round (AVG (f.rental_duration),2) AS "Media_alquiler"
FROM film AS f 

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT CONCAT (a.first_name,' ' ,a.last_name) AS "Actores"
FROM actor AS a 

--23.Número de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT f.rental_duration AS "Duración_alquiler"
FROM film AS f 
ORDER BY  f.rental_duration DESC;

--24. Encuentra las películas con una duración superior al promedio.
SELECT f.title AS "Título", f.length AS "Duración"
FROM film AS f 
WHERE length >(
	SELECT AVG (length)
	FROM film );

--25. Averigua el número de alquileres registrados por mes.
SELECT EXTRACT (YEAR FROM r.rental_date) AS "Año, EXTRACT (MONTH FROM r.rental_date) AS "mes", COUNT (*) AS "Total_alquileres"
FROM rental AS r
group by "año", "mes"
order by "año", "mes";

--26. Encuentra el promedio, la desviación estándar y la varianza del total pagado
SELECT round (AVG(p.amount),2) AS "Promedio", round(stddev(p.amount),2) AS "Desviación_estándar", round(variance(p.amount),2) AS "Varianza"
FROM payment AS p;

--27.¿Qué películas se alquilan por encima del precio medio?
SELECT f.title AS "Título", f.rental_rate AS "Tarifa_alquiler"
FROM film AS f 
WHERE f.rental_rate  >(
	SELECT avg(rental_rate)
	FROM film)
	ORDER BY f.rental_rate;

--28. Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT fa.actor_id AS "Actor", COUNT(fa.film_id) AS "Total_peliculas"
FROM film_actor AS fa 
GROUP BY fa.actor_id
HAVING count(fa.film_id) >40
ORDER BY "Total_peliculas";

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
SELECT f.title AS "Película", COUNT(i.inventory_id) AS "Cantidad_disponible"
FROM film AS f 
INNER JOIN inventory AS i 
ON f.film_id = i.film_id
GROUP BY f.title
ORDER by "Cantidad_disponible";

--30. Obtener actores y el número de películas en las que ha actuado.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS "Nombre_actor", COUNT(fa.film_id) AS "Total_peliculas"
FROM film_actor AS fa 
INNER JOIN actor AS a ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, "Nombre_actor"
ORDER BY "Total_peliculas";

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas 
-- películas no tienen actores asociados.
SELECT f.title AS "Película", concat(a.first_name, ' ', a.last_name) AS "Actor"
FROM film AS f 
LEFT JOIN film_actor AS fa ON f.film_id = fa.film_id 
LEFT JOIN actor AS a ON fa.actor_id = a.actor_id 
ORDER BY f.title, "Actor";

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado
-- en ninguna película.
SELECT  CONCAT(a.first_name, ' ', a.last_name) AS "Actor", f.title AS "Película"
FROM actor AS a 
LEFT JOIN film_actor AS fa ON a.actor_id =fa.actor_id
LEFT JOIN film AS f ON fa.actor_id = f.film_id
ORDER BY "Actor" , "Película";

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT f.title AS "Película", r.inventory_id AS "Alquiler", r.rental_date AS "Fecha_alquiler"
FROM film AS f 
LEFT JOIN inventory AS i ON f.film_id = i.film_id 
LEFT JOIN rental AS r ON f.film_id = i.inventory_id
ORDER BY "Película", "Alquiler";

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS "Cliente", SUM(P.amount) AS "Importe_gastado"
FROM customer AS c 
INNER JOIN payment AS p ON c.customer_id =p.customer_id
GROUP BY C.first_name, C.last_name
ORDER BY "Importe_gastado" DESC
LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'
SELECT concat(a.first_name, ' ', a.last_name) AS "Nombre_actor"
FROM actor AS a 
WHERE a.first_name ='JOHNNY';

-- 36. Renombra la columna "Fist_name" como Nombre y "Last_name" como Apellido.
SELECT a.first_name AS "Nombre", a.last_name AS "Apellido"
FROM actor AS a ;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT MIN(a.actor_id) AS "Id_bajo", MAX(a.actor_id) AS "Id_alto"
FROM actor AS a;

--38. Cuenta cuántos actores hay en la tabla "Actor"
SELECT COUNT(a.actor_id)
FROM actor AS a;

--39. Selecciona todos los actores y órdenalos por apellido en orden ascendente.
SELECT concat(a.last_name, ' ', a.first_name) AS "Actor"
FROM actor AS a 
ORDER BY a.last_name ASC;

-- 40. Selecciona las 5 primeras películas de la tabla "film"
SELECT f.title AS "Películas"
FROM film AS f 
LIMIT 5;

--41 Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el más repetido?

SELECT a.first_name AS "Actor", COUNT(*) AS "Duplicados"
FROM actor AS a 
GROUP BY a.first_name
ORDER BY "Duplicados" DESC
liMIT 1;


--42. Encuentra todos lo alquileres y los nombres de los clientes que los realizaron.
SELECT r.rental_id AS "Alquiler", CONCAT(c.first_name, ' ', c.last_name) AS "Clientes"
FROM rental AS r 
INNER JOIN customer AS c ON r.customer_id = c.customer_id;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
SELECT r.rental_id AS "Alquiler", c.customer_id AS "Cliente", concat(c.first_name, ' ', c.last_name) AS "Nombre" 
FROM customer AS c 
LEFT JOIN rental AS r ON c.customer_id = r.customer_id;

--44. Realiza un CROSS JOIN  entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? 
SELECT f.film_id, c.category_id
FROM film AS f 
CROSS JOIN category AS c;
-- */ Esas dos tablas están relacionadas a través de de film_category, por lo que sería más recomendable usar INNER JOIN para poder
-- unir las tablas de forma correcta. Con CROSS JOIN nos saldría combinaciones que no serían reales. */

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT concat(a.first_name, ' ', a.last_name) AS "Actores_acción", c."name" AS "Categoría"
FROM actor AS a 
INNER JOIN film_actor AS fa ON a.actor_id  = fa.actor_id
INNER JOIN film AS f ON fa.film_id = f.film_id
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
WHERE c."name" = 'Action';

--46. Encuentra todos los actores que no han participado en películas.
SELECT concat(a.first_name, ' ', a.last_name) AS "Actores_no_participantes"
FROM actor AS a 
left JOIN film_actor AS fa ON a.actor_id = fa.actor_id
WHERE a.actor_id NOT IN (SELECT DISTINCT fa.actor_id FROM film_actor AS fa);

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
SELECT concat (a.first_name, ' ', a.last_name) AS "Nombre_actor", COUNT(fa.film_id) AS "Total_películas"
FROM actor AS a 
LEFT JOIN film_actor AS fa ON a.actor_id =fa.actor_id
GROUP BY a.actor_id;

--48. Crea una vista llamada "actor_num_peliculas" que muestre los nombres de los actores y 
-- número de películas en las que han participado.
CREATE VIEW "actor_num_peliculas" AS 
SELECT concat(a.first_name, ' ', a.last_name) AS "Actor", count(fa.film_id) AS "Total_películas"
FROM actor AS a 
LEFT JOIN film_actor AS fa ON a.actor_id =fa.actor_id
GROUP BY a.actor_id;

SELECT * FROM "actor_num_peliculas";

--49. Calcula el número total de alquileres realizados por cada cliente.
SELECT concat(c.first_name, ' ', c.last_name) AS "Cliente", COUNT(r.rental_id) AS "Total_alquileres"
FROM customer AS c 
LEFT JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY c.customer_id 
ORDER BY "Total_alquileres";

--50. Calcula la duración total de las películas en la categoría 'Action'.
SELECT SUM(f.length) AS "Duración_total", c.name AS "Categoría"
FROM film AS f 
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
WHERE C."name" = 'Action'
GROUP BY c.name;

--51. Crea una tabla temporal llamada "cliente_rentas_temporal" para almacenar el total de alquileres por cliente.
CREATE TEMPORARY TABLE "cliente_rentas_temporal" as
SELECT concat(c.first_name, ' ', c.last_name) AS "Cliente", count (r.rental_id) AS "Total_alquiler"
FROM customer AS c
LEFT JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

SELECT "Cliente", "Total_alquiler"
FROM "cliente_rentas_temporal";

--52. Crea una tabla temporal llamada "Películas_alquiladas" que almacene las películas que han 
--sido alquiladas al menos 10 veces.
CREATE TEMPORARY TABLE "Películas_alquilada" AS 
SELECT f.title AS "Título_película", count (r.rental_id) AS "Duración_alquiler"
FROM film AS f 
INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING count(r.rental_id) >= 10;


SELECT *
FROM "Películas_alquilada";

--53. */Enecuentra el título de las películas que han sido alquiladas por el cliente con el nombre
--'Tammy Sanders' y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.*//
SELECT f.title AS "Películas_sin_devolver", CONCAT(c.first_name, ' ', c.last_name) AS "Cliente"
FROM rental AS r 
INNER JOIN customer AS c ON r.customer_id = c.customer_id
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
INNER JOIN film AS f ON i.film_id = f.film_id
WHERE c.first_name = 'TAMMY'
AND c.last_name ='SANDERS'
ORDER BY f.title;

--54. *Enuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría 'Sci_fi'.
-- Ordena los resultados alfabéticamente por apellido. 
SELECT DISTINCT concat (a.first_name, ' ', a.last_name) AS "Actores", c."name"
FROM actor AS a 
INNER JOIN film_actor AS fa ON a.actor_id =fa.actor_id
INNER JOIN film AS f ON fa.film_id = f.film_id
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
WHERE c."name" = 'Sci-Fi'
ORDER BY "Actores";

--55. */ Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película
-- 'Spartacus Cheaper' se alquilara por primera vez. Ordena los resultados alfbéticamente por apellido.*//
SELECT DISTINCT concat(a.first_name, ' ',a.last_name) AS "Actor", f.title AS "Películas"
FROM actor AS a 
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN film AS f ON fa.film_id = f.film_id
INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (   
	SELECT MIN(rental_date)
	FROM rental AS r
	INNER JOIN inventory AS i2 ON r.inventory_id = i.inventory_id
	INNER JOIN film f ON i.film_id = f.film_id 
	WHERE f.title= 'SPARTACUS CHEAPER'
	)
ORDER BY "Actor";	

--56.Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría 'Music'.
SELECT concat(a.first_name, ' ', a.last_name) AS "Actor_no_music"
FROM actor AS a 
WHERE NOT exists(
	SELECT 1
	FROM film_actor AS fa 
	INNER JOIN film AS f ON fa.film_id = f.film_id 
	INNER JOIN film_category fc ON f.film_id = fc.film_id 
	INNER JOIN category AS c ON fc.category_id = c.category_id 
	WHERE c."name" = 'Music' AND fa.actor_id = a.actor_id
)
ORDER BY "Actor_no_music";

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
SELECT DISTINCT f. title as "Título"
FROM rental as r
INNER JOIN inventory as i ON r.inventory_id = i.inventory_id
INNER JOIN film as f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
AND r.return_date - r.rental_date > INTERVAL '8 days'
ORDER BY f.title;


--58. Encuentra el título de todas las películas que son de la misma categoría 'Animation'.
SELECT f.title AS "Título", c."name" AS "Categoría"
FROM film AS f 
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = 'Animation';

--59. */Encuentra los nombres de las películas que tienen la misma duración que la película con el título
-- 'Dancing Fever'. Ordena los resultados alfabéticamente por título de película.*//
SELECT f.title AS "Título", f.length AS "Duración"
FROM film AS f 
WHERE length = (
	SELECT f.length 
	FROM film AS f
	WHERE f.title = 'DANCING FEVER')
ORDER BY f.title;

--60.*/ Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
-- Ordena los resultados alfabéticamente por apellido. //*
SELECT concat( c.last_name, ', ', c.first_name) AS "Cliente", COUNT(DISTINCT r.inventory_id) AS "Total_películas"
FROM customer AS c 
INNER JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.last_name,  c.first_name
HAVING count(DISTINCT r.inventory_id) >= 7
ORDER BY "Cliente";

--61. */ Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría 
-- junto con el recuento de alquileres.//*
SELECT c."name" AS "Categoría", count (r.rental_id) AS "Total_alquileres"
FROM rental AS r 
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
INNER JOIN film AS f ON i.film_id = f.film_id
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id 
GROUP BY c."name"

--62. Encuentra el número de películas por categoría estrenadas en 2006.
SELECT c."name" AS "Categoría", COUNT(f.film_id) AS "Total_películas", f.release_year AS "Año_estreno"
FROM film AS f 
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
WHERE f.release_year = 2006
GROUP BY c."name", f.release_year;

--63. Obten todas las combinaciones posibles de trabajadores con las tienda que tenemos.
SELECT concat(s.first_name,' ', s.LASt_name) AS "Empleado", s2.store_id AS "Tienda"
FROM staff AS s 
CROSS JOIN  store AS s2;

-- 64. */Encuentra la cantidad total de películas alquiladas por cada cliente y muestra
-- el ID del cliente, su nombre y apellido jundo con la cantidad de películas alquiladas.//*
SELECT c.customer_id AS "ID_cliente", concat (c.first_name, ' ', c.last_name) AS "Nombre_cliente", COUNT(r.rental_id) AS "Total_alquileres"
FROM customer AS c 
LEFT JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY "ID_cliente";















