/* Effettuate un’esplorazione preliminare del database. Di cosa si tratta? 
Quante e quali tabelle contiene? Fate in modo di avere un’idea abbastanza chiara riguardo a con cosa state lavorando.*/

SELECT *
FROM sakila.actor;

/* ESERCIZIO 2: Scoprite quanti clienti si sono registrati nel 2006*/

SELECT COUNT(customer.customer_id) AS N_Clienti_Reg
FROM customer
WHERE YEAR(customer.create_date) = 2006;

/* ESERCIZIO 3: Trovate il numero totale di noleggi effettuati il 14/2/2006*/

SELECT COUNT(rental.rental_id) AS N_Noleggi
FROM rental
WHERE DATE(rental.rental_date) = '2006-02-14';

/* ESERCIZIO 3 alt: Trovate il numero totale di noleggi effettuati il 2005/05/31*/

SELECT COUNT(rental.rental_id) AS N_Noleggi
FROM rental
WHERE DATE(rental.rental_date) = '2005-05-31';

/* ESERCIZIO 4: Elencate tutti i film noleggiati nell’ultima settimana e tutte le informazioni legate al cliente che li ha noleggiati. */

SELECT film.title, customer.first_name, customer.last_name
FROM sakila.rental
JOIN sakila.inventory ON rental.inventory_id = inventory.inventory_id
JOIN sakila.film ON inventory.film_id = film.film_id
JOIN sakila.customer ON rental.customer_id = customer.customer_id
WHERE DATE(rental.rental_date) BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND CURDATE();

/* ESERCIZIO 4 alt: Elencate tutti i film noleggiati tra il 2005/05/31 e il 2005/05/24 e tutte le informazioni legate al cliente che li ha noleggiati. */

SELECT film.title, customer.first_name, customer.last_name, rental.rental_date
FROM sakila.rental
JOIN sakila.inventory ON rental.inventory_id = inventory.inventory_id
JOIN sakila.film ON inventory.film_id = film.film_id
JOIN sakila.customer ON rental.customer_id = customer.customer_id
WHERE DATE(rental.rental_date) BETWEEN '2005-05-24' AND '2005-05-31';

/* ESERCIZIO 5: Calcolate la durata media del noleggio per ogni categoria di film. */

SELECT category.name, 
       AVG(DATEDIFF(rental.return_date, rental.rental_date)) AS Durata_Media
FROM sakila.rental
JOIN sakila.inventory ON rental.inventory_id = inventory.inventory_id
JOIN sakila.film ON inventory.film_id = film.film_id
JOIN sakila.film_category ON film.film_id = film_category.film_id
JOIN sakila.category ON film_category.category_id = category.category_id
GROUP BY category.name;

/* Pratica (2) ESERCIZIO 1: Identificate tutti i clienti che non hanno effettuato nessun noleggio a gennaio 2006.*/

SELECT customer.first_name, customer.last_name
FROM sakila.customer
WHERE NOT EXISTS (
    SELECT 1
    FROM sakila.rental
    WHERE rental.customer_id = customer.customer_id
      AND MONTH(rental.rental_date) = 1
      AND YEAR(rental.rental_date) = 2006
);

/* Pratica (2) ESERCIZIO 2: Elencate tutti i film che sono stati noleggiati più di 10 volte nell’ultimo quarto del 2005.*/

SELECT film.title
FROM sakila.rental
JOIN sakila.inventory ON rental.inventory_id = inventory.inventory_id
JOIN sakila.film ON inventory.film_id = film.film_id
WHERE rental.rental_date BETWEEN '2005-10-01' AND '2005-12-31'
GROUP BY film.title
HAVING COUNT(rental.rental_id) > 10;

/* Pratica (2) ESERCIZIO 2 alt: Elencate tutti i film che sono stati noleggiati più di 2 volte a maggio 2005.*/

SELECT film.title, COUNT(rental.rental_id)
FROM sakila.rental
JOIN sakila.inventory ON rental.inventory_id = inventory.inventory_id
JOIN sakila.film ON inventory.film_id = film.film_id
WHERE rental.rental_date BETWEEN '2005-05-01' AND '2005-05-31'
GROUP BY film.title
HAVING COUNT(rental.rental_id) > 2;

/* Pratica (2) ESERCIZIO 3: Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.*/

SELECT DATE(rental.rental_date) AS rental_date, COUNT(rental.rental_id) AS Totale_noleggi
FROM sakila.rental
WHERE DATE(rental.rental_date) = '2006-01-01'
GROUP BY DATE(rental.rental_date);

/* Pratica (2) ESERCIZIO 3 alt: Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.*/

SELECT DATE(rental.rental_date) AS rental_date, COUNT(rental.rental_id) AS Totale_noleggi
FROM sakila.rental
WHERE DATE(rental.rental_date) = '2005-05-30'
GROUP BY DATE(rental.rental_date);

/* Pratica (2) ESERCIZIO 4: Calcolate la somma degli incassi generati nei weekend (sabato e domenica).*/

SELECT DATE(rental.rental_date) AS Giorno_Noleggio, SUM(payment.amount) AS Somma_Incassi
FROM sakila.payment
JOIN sakila.rental ON sakila.payment.rental_id = sakila.rental.rental_id
WHERE DAYOFWEEK(rental.rental_date) IN (1, 7)
GROUP BY DATE(rental.rental_date);

/* Pratica (2) ESERCIZIO 5: Individuate il cliente che ha speso di più in noleggi.*/

SELECT 
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_spent
FROM
    sakila.customer
JOIN
    sakila.payment ON sakila.customer.customer_id = sakila.payment.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_spent DESC
LIMIT 1;

/* Pratica 2 ESERCIZIO 6: Elencate i 5 film con la maggior durata media di noleggio. */

SELECT film.title, AVG(DATEDIFF(rental.return_date, rental.rental_date)) AS Durata_Media
FROM sakila.film
JOIN sakila.inventory ON film.film_id = inventory.film_id
JOIN sakila.rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id, film.title
ORDER BY Durata_Media DESC
LIMIT 5;

/* Pratica 2 ESERCIZIO 7: Calcolate il tempo medio in giorni tra due noleggi consecutivi da parte di un cliente.*/

SELECT 
    customer.first_name,
    customer.last_name,
    AVG(DATEDIFF(next_rental.rental_date, rental.rental_date)) AS Tempo_Medio_Due_Noleggi
FROM 
    sakila.customer
JOIN 
    sakila.rental ON customer.customer_id = rental.customer_id
LEFT JOIN 
    sakila.rental AS next_rental ON rental.customer_id = next_rental.customer_id 
                                    AND next_rental.rental_date = (
                                        SELECT MIN(nr.rental_date)
                                        FROM sakila.rental nr
                                        WHERE nr.customer_id = rental.customer_id 
                                          AND nr.rental_date > rental.rental_date
                                    )
GROUP BY 
    customer.customer_id, customer.first_name, customer.last_name
ORDER BY 
    Tempo_Medio_Due_Noleggi DESC;
    
    /* Pratica 2 ESERCIZIO 8: Individuate il numero di noleggi per ogni mese del 2005.*/
    
SELECT 
    EXTRACT(MONTH FROM rental.rental_date) AS Month,
    COUNT(*) AS Number_of_Rentals
FROM
    sakila.rental
WHERE
    YEAR(rental.rental_date) = 2005
GROUP BY EXTRACT(MONTH FROM rental.rental_date);
    
 /* Pratica 2 ESERCIZIO 9: Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno.*/
SELECT DISTINCT
    film.title
FROM
    sakila.film
        JOIN
    sakila.inventory ON film.film_id = inventory.film_id
        JOIN
    sakila.rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title , DATE(rental.rental_date)
HAVING COUNT(*) >= 2;
    
 /* Pratica 2 ESERCIZIO 10: Calcolate il tempo medio generale di tutti i film di noleggio.*/
    
SELECT 
    AVG(DATEDIFF(rental.return_date, rental.rental_date)) AS Tempo_Medio_Generale
FROM
    sakila.rental