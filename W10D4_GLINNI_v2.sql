/* 1.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory). */

/* SELECT 
    Prod.EnglishProductName, 
    SubCat.EnglishProductSubcategoryName
FROM
    adv.dimproduct AS Prod
        JOIN
    dimproductsubcategory AS SubCat ON Prod.ProductSubCategoryKey = SubCat.ProductSubCategoryKey; */
    
    /* puoi soprannominare in qualsiasi momento le colonne */
    
/* 2.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory). */

/* SELECT 
    Prod.EnglishProductName,
    Cat.EnglishProductCategoryName,
    SubCat.EnglishProductSubcategoryName
FROM
    adv.dimproduct AS Prod
        JOIN
    dimproductsubcategory AS SubCat ON Prod.ProductSubCategoryKey = SubCat.ProductSubCategoryKey
        JOIN
    dimproductcategory AS Cat ON Cat.ProductCategoryKey = SubCat.ProductCategoryKey; */
    
/* 3.Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales). */

/* SELECT 
    dimproduct.EnglishProductName,
    factresellersales.SalesOrderNumber,
    factresellersales.SalesAmount,
    factresellersales.productkey,
    factresellersales.orderquantity,
    factresellersales.unitprice,
    dimproduct.finishedgoodsflag
FROM
    adv.factresellersales
        INNER JOIN
    dimproduct ON factresellersales.productkey = dimproduct.productkey
WHERE
    SalesAmount > 0
ORDER BY SalesAmount ASC; */

/*4.Esponi l’elenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).*/

/* SELECT 
    dp.EnglishProductName,
    dp.finishedgoodsflag,
    frs.salesordernumber
FROM
    adv.dimproduct AS dp
JOIN 
    adv.factresellersales AS frs ON dp.ProductKey = frs.ProductKey
WHERE
    dp.finishedgoodsflag = 1
    AND NOT frs.ProductKey = dp.ProductKey; */
    
    /* 5.Esponi l’elenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct) */
    
   /* SELECT 
    frs.SalesOrderNumber,
    frs.ProductKey,
    dp.EnglishProductName,
    frs.salesamount
FROM
    adv.factresellersales AS frs
JOIN 
    adv.dimproduct AS dp ON frs.ProductKey = dp.ProductKey
    WHERE salesamount > 0
    ORDER BY salesamount ASC */
    
  
/*	6.Esponi l’elenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.*/
/* SELECT
    SALES.SalesOrderNumber, SALES.SalesOrderLineNumber, CAT.EnglishProductCategoryName, PROD.EnglishProductName
FROM
    factresellersales AS SALES
        JOIN
    dimproduct AS PROD ON SALES.ProductKey = PROD.ProductKey
        JOIN
    dimproductsubcategory AS SUBCAT ON PROD.ProductSubcategoryKey = SUBCAT.ProductSubcategoryKey
        JOIN
    dimproductcategory AS CAT ON SUBCAT.ProductCategoryKey = CAT.ProductCategoryKey;
*/
/*	7.Esplora la tabella DimReseller.*/
/* SELECT *
FROM dimreseller; */

/*	8.Esponi in output l’elenco dei reseller indicando, per ciascun reseller, anche la sua area geografica.*/
/* SELECT 
    dimreseller.ResellerName AS Nome,
    dimgeography.EnglishCountryRegionName AS Stato,
    dimgeography.City AS Citta
FROM
    dimgeography
        JOIN
    dimreseller ON dimgeography.GeographyKey = dimreseller.GeographyKey; */

/*	9.Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi: 
	SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
	Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, 
    il nome del reseller e l’area geografica.*/
/* SELECT 
    SALES.SalesOrderNumber AS NumOrdine,
    SALES.SalesOrderLineNumber AS LineOrdine,
    SALES.OrderDate AS DataOrdine,
    SALES.UnitPrice AS PrezzoUnitario,
    SALES.OrderQuantity AS Quantita,
    SALES.TotalProductCost AS Costo,
    PROD.EnglishProductName AS Prodotto,
    CAT.EnglishProductCategoryName AS Categoria,
    RESELLER.ResellerName AS Reseller,
    LUOGO.EnglishCountryRegionName AS Stato,
    LUOGO.City AS Citta
FROM
    factresellersales AS SALES
    JOIN dimproduct AS PROD ON SALES.ProductKey = PROD.ProductKey
    JOIN dimproductsubcategory AS SUBCAT ON PROD.ProductSubcategoryKey = SUBCAT.ProductSubcategoryKey
    JOIN dimproductcategory AS CAT ON SUBCAT.ProductCategoryKey = CAT.ProductCategoryKey
    JOIN dimreseller AS RESELLER ON SALES.ResellerKey = RESELLER.ResellerKey
    JOIN dimgeography AS LUOGO ON RESELLER.GeographyKey = LUOGO.GeographyKey;
    */
    
    