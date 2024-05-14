/* Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?/*
*/
/* SELECT 
    KCU.COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC
    INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU
        ON TC.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME
        AND TC.TABLE_NAME = KCU.TABLE_NAME
WHERE 
    TC.TABLE_NAME = 'DimProduct'
    AND TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
    AND KCU.COLUMN_NAME = 'ProductKey'; */
    /* Commento: Se la query restituisce una riga con il nome della colonna ProductKey, allora ProductKey è una chiave primaria nella tabella DimProduct. Se non restituisce alcun risultato, ProductKey non è una chiave primaria.*/
    
    
    
/* 2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.*/

/* SELECT 
    KCU.COLUMN_NAME
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC
        INNER JOIN
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU ON TC.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME
        AND TC.TABLE_NAME = KCU.TABLE_NAME
WHERE
    TC.TABLE_NAME = 'factresellersales'
        AND TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
        AND (KCU.COLUMN_NAME = 'SalesOrderNumber'
        OR KCU.COLUMN_NAME = 'SalesOrderLineNumber')
ORDER BY KCU.ORDINAL_POSITION; */
    
    /* Commento: Se la query restituisce entrambe le colonne SalesOrderNumber e SalesOrderLineNumber, significa che la combinazione di questi due campi costituisce una chiave primaria nella tabella specificata.*/
    
    
    /* 3.Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.*/
    
  /* SELECT 
    OrderDate AS Data,
    COUNT(SalesOrderLineNumber) AS Numero_Transazioni
FROM 
    adv.factresellersales
WHERE 
    OrderDate >= '2020-01-01'
GROUP BY 
    OrderDate
ORDER BY 
    OrderDate; */
    
    /* 4.Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
    Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!
    */
    
/* SELECT 
    factresellersales.OrderDate AS Data,
    dimproduct.EnglishProductName AS Nome_Prodotto,
    SUM(factresellersales.SalesAmount) AS Totale_Vendite,
    SUM(factresellersales.OrderQuantity) AS Totale_Quantita,
    AVG(factresellersales.UnitPrice) AS Media_Vendita
FROM 
    ADV.dimproduct
JOIN 
    ADV.factresellersales ON dimproduct.ProductKey = factresellersales.ProductKey
WHERE 
    factresellersales.OrderDate >= '2020-01-01'
GROUP BY 
    factresellersales.OrderDate,
    dimproduct.EnglishProductName
ORDER BY 
    factresellersales.OrderDate;
    */
    
    /* 5.Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory). Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!*/
    
/* SELECT 
    dimproductcategory.EnglishProductCategoryName AS Nome_Categoria,
    SUM(factresellersales.SalesAmount) AS Totale_Vendite,
    SUM(factresellersales.OrderQuantity) AS Totale_Quantita
FROM 
    ADV.factresellersales
JOIN 
    ADV.dimproduct ON factresellersales.ProductKey = dimproduct.ProductKey
JOIN 
    ADV.dimproductsubcategory ON dimproduct.ProductSubcategoryKey = dimproductsubcategory.ProductSubcategoryKey
JOIN 
    ADV.dimproductcategory ON dimproductsubcategory.ProductCategoryKey = dimproductcategory.ProductCategoryKey
GROUP BY 
    dimproductcategory.EnglishProductCategoryName
ORDER BY
    dimproductcategory.EnglishProductCategoryName;
*/

/* 6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.*/

SELECT 
    DimGeography.City AS Citta,
    SUM(FactResellerSales.SalesAmount) AS Totale_Vendite
FROM
    ADV.DimGeography
JOIN
    ADV.DimReseller ON DimGeography.GeographyKey = DimReseller.GeographyKey
JOIN
    ADV.FactResellerSales ON DimReseller.ResellerKey = FactResellerSales.ResellerKey
WHERE
    FactResellerSales.OrderDate >= '2020-01-01'
GROUP BY
    DimGeography.City
HAVING
    SUM(FactResellerSales.SalesAmount) > 60000
ORDER BY
    Totale_Vendite ASC;

    