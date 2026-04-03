-- Esplora la tabelle dei prodotti (DimProduct)
select * from dimproduct;

-- Interroga la tabella dei prodotti DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag.
-- Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno.
select 
	ProductKey as cod_prodotto,
    ProductAlternateKey as modello,
    EnglishProductName as nome_prodotto,
    Color as colore,
    StandardCost as costo_standard,
    FinishedGoodsFlag as prodotto_finito
from dimproduct;

-- Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.
select
	ProductKey as cod_prodotto,
    ProductAlternateKey as modello,
	EnglishProductName as nome_prodotto,
    Color as colore,
    StandardCost as costo_standard,
    FinishedGoodsFlag as prodotto_finito
from dimproduct
where FinishedGoodsFlag = 1;

-- Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK.
-- Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost) e il prezzo di listino (ListPrice).
select
	ProductKey as cod_prodotto,
	ProductAlternateKey as modello,
    EnglishProductName as nome_prodotto,
    StandardCost as costo_standard,
    ListPrice as prezzo_listino
from dimproduct
where ProductAlternateKey like 'FR%' or ProductAlternateKey like 'BK%';

-- Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dallʼazienda (ListPrice - StandardCost)
select
	ProductKey as cod_prodotto,
	ProductAlternateKey as modello,
    EnglishProductName as nome_prodotto,
    StandardCost as costo_standard,
    ListPrice as prezzo_listino,
    ListPrice - StandardCost as markup
from dimproduct
where ProductAlternateKey like 'FR%' or ProductAlternateKey like 'BK%';

-- Scrivi unʼaltra query al fine di esporre lʼelenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.
select
	ProductKey as cod_prodotto,
	ProductAlternateKey as modello,
    EnglishProductName as nome_prodotto,
	FinishedGoodsFlag as prodotti_finiti
from dimproduct
where FinishedGoodsFlag = 1 and ListPrice < 2000 and ListPrice > 1000;

-- Esplora la tabella degli impiegati aziendali DimEmployee)
select *
from dimemployee;

-- Esponi, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti.
-- Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a 1.
select *
from dimemployee
where SalesPersonFlag = 1;

-- Interroga la tabella delle vendite (FactResellerSales).
-- Esponi in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214.
-- Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).
select *,
	SalesAmount - TotalProductCost as profitto
from factresellersales
where
	OrderDate >= 2020-01-01
    and (ProductKey = 597
    or productkey = 598
    or productkey = 477
    or productkey = 214);