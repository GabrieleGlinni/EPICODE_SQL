/* SELEZIONA TUTTO DALLA TABELLA DIMPRODUCT

SELECT *
FROM adv.dimproduct */

/* SELEZIONARE VARIE TABELLE E RINOMINARLE, CHIAVE TRA 1 E 10

SELECT dimproduct.productkey AS Chiave, dimproduct.productalternatekey AS codice_modello, dimproduct.englishproductname AS English_name, dimproduct.color AS Colore, dimproduct.standardcost AS costo, dimproduct.FinishedGoodsFlag as finito
FROM adv.dimproduct
WHERE productkey BETWEEN 1 AND 10 */

/* SELEZIONARE VARIE TABELLE E FINISHED GOODS = 1

SELECT dimproduct.productkey AS Chiave, dimproduct.productalternatekey AS codice_modello, dimproduct.englishproductname AS English_name, dimproduct.color AS Colore, dimproduct.standardcost AS costo, dimproduct.FinishedGoodsFlag as finito
FROM adv.dimproduct
WHERE FinishedGoodsFlag = 1   */

/* SELEZIONARE codice modello che inizia con FR oppure BK  

SELECT dimproduct.productkey AS Chiave, dimproduct.productalternatekey AS codice_modello, dimproduct.englishproductname AS English_name, dimproduct.color AS Colore, dimproduct.standardcost AS costo, dimproduct.FinishedGoodsFlag as finito
FROM adv.dimproduct
WHERE productalternatekey LIKE "BK%" OR productalternatekey LIKE "FR%"
ORDER BY productalternatekey DESC */

/* SELEZIONARE codice modello che prezzo di listino è compreso tra 1000 e 2000. 

SELECT dimproduct.productkey AS Chiave, dimproduct.productalternatekey AS codice_modello, dimproduct.englishproductname AS English_name, dimproduct.color AS Colore, dimproduct.standardcost AS costo, dimproduct.FinishedGoodsFlag as finito
FROM adv.dimproduct
WHERE standardcost BETWEEN 1000 and 2000
ORDER BY standardcost ASC  */

/* SELEZIONARE Esplora la tabella degli impiegati aziendali (DimEmployee)

SELECT *
FROM adv.dimemployee  */

/* Esponi, interrogando la tabella degli impiegati aziendali, l’elenco dei soli agenti. Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.

SELECT dimemployee.employeekey, dimemployee.firstname, dimemployee.lastname, dimemployee.salespersonflag
FROM adv.dimemployee
WHERE salespersonflag = 1 */

/*Interroga la tabella delle vendite (FactResellerSales). Esponi in output l’elenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214. Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).

SELECT factresellersales.salesordernumber, factresellersales.orderdate, factresellersales.productkey
FROM adv.factresellersales
WHERE orderdate >= '2020-01-01'*/
