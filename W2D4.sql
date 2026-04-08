-- Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria DimProduct, DimProductSubcategory).

select *
from dimproduct as p
inner join dimproductsubcategory as s
on p.ProductSubcategoryKey = s.ProductSubcategoryKey;

-- Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria DimProduct, DimProductSubcategory, DimProductCategory).

select *
from dimproductsubcategory as s
inner join dimproduct as p
	on s.ProductSubcategoryKey = p.ProductSubcategoryKey
inner join dimproductcategory as c
	on s.ProductCategoryKey = c.ProductCategoryKey;

-- Esponi lʼelenco dei soli prodotti venduti (DimProduct, FactResellerSales). 

select *
from dimproduct as p
inner join factresellersales as s
	on p.ProductKey = s.ProductKey;

-- Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).

select *
from dimproduct as p
where FinishedGoodsFlag = 1
	and ProductKey not in (select ProductKey from factresellersales); -- non efficiente

select *
from  dimproduct as p
left join factresellersales as s
	on p.ProductKey = s.ProductKey
where s.ProductKey is null;

-- Esponi lʼelenco delle transazioni di vendita FactResellerSales) indicando anche il nome del prodotto venduto DimProduct)

select s.*, p.englishproductname as nome_prodotto
from factresellersales s
join dimproduct p on s.ProductKey = p.ProductKey;

-- Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.

select f.*, c.productcategorykey
from factresellersales f
join dimproduct p on f.ProductKey = p.ProductKey
join dimproductsubcategory s on p.ProductSubcategoryKey = s.ProductSubcategoryKey
join dimproductcategory c on s.ProductCategoryKey = c.ProductCategoryKey;

-- Esplora la tabella DimReseller.

select *
from dimreseller;

-- Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. 

select d.*, t.SalesTerritoryRegion, t.SalesTerritoryCountry, t.SalesTerritoryGroup
from dimreseller d
join factresellersales f on d.resellerkey = f.ResellerKey
join dimsalesterritory t on f.SalesTerritoryKey = t.SalesTerritoryKey;

-- Esponi lʼelenco delle transazioni di vendita.
-- Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost.
-- Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.

select r.SalesOrderNumber,
	r.SalesOrderLineNumber,
	r.OrderDate,
    r.UnitPrice,
	r.OrderQuantity,
	r.TotalProductCost,
    p.EnglishProductName,
    c.EnglishProductCategoryName,
    l.ResellerName,
    t.SalesTerritoryRegion,
    t.SalesTerritoryCountry,
    t.SalesTerritoryGroup
from factresellersales r
join dimproduct p on r.ProductKey = p.ProductKey
join dimproductsubcategory s on p.ProductSubcategoryKey = s.ProductSubcategoryKey
	join dimproductcategory c on s.ProductCategoryKey = c.ProductCategoryKey
join dimreseller l on r.ResellerKey = l.ResellerKey
join dimsalesterritory t on r.SalesTerritoryKey = t.SalesTerritoryKey;