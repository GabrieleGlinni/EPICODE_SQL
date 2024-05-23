/* Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. */

SELECT 
    product.productname, 
    YEAR(sales.saledate) AS sale_year, 
    SUM(sales.saleamount) AS total_revenue
FROM 
    toysgroup.product
JOIN 
    toysgroup.sales ON product.idproduct = sales.idproduct
WHERE 
    sales.saleamount > 0
GROUP BY 
    product.productname, YEAR(sales.saledate)
ORDER BY 
    total_revenue DESC;
    
/* Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.  */

SELECT 
    region.regionname, 
    YEAR(sales.saledate) AS sale_year, 
    SUM(sales.saleamount) AS total_revenue
FROM 
    toysgroup.sales
JOIN 
    toysgroup.product ON sales.idproduct = product.idproduct
JOIN 
    toysgroup.region ON product.idproduct = region.idproduct
WHERE 
    sales.saleamount > 0
GROUP BY 
    region.regionname, YEAR(sales.saledate)
ORDER BY 
    sale_year, total_revenue DESC;
    
    /* Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato? */
    
 SELECT 
    product.productcategory,
    SUM(sales.saleamount) AS total_revenue
FROM 
    toysgroup.sales
JOIN 
    toysgroup.product ON sales.idproduct = product.idproduct
WHERE 
    sales.saleamount > 0
GROUP BY 
    product.productcategory
ORDER BY 
    total_revenue DESC
LIMIT 1;

/* Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti.  */

/* Approccio 1: Usando una Left Join */

SELECT 
    product.productname, sales.saleamount
FROM
    toysgroup.product
        LEFT JOIN
    toysgroup.sales ON product.idproduct = sales.idproduct
WHERE
    sales.idproduct IS NULL;
    
    /* Approccio 2: Usando una NOT IN Subquery */
    
    SELECT 
    product.productname, sales.salesamount
FROM 
    toysgroup.product
WHERE 
    product.idproduct NOT IN (SELECT idproduct FROM toysgroup.sales);
    
    /* Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente). */
    
SELECT 
    product.productname,
    MAX(sales.saledate) AS last_sale_date
FROM 
    toysgroup.product
LEFT JOIN 
    toysgroup.sales ON product.idproduct = sales.idproduct
GROUP BY 
    product.productname
    ORDER BY
    last_sale_date DESC;