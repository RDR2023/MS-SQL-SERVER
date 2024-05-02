--How many items with ListPrice more than $1000 have been sold?

SELECT p.ProductID,p.Name,sum(sod.OrderQty) as [Qtycount]
FROM Production.Product p
inner join Sales.SalesOrderDetail sod on p.ProductID = sod.ProductID
where p.ListPrice>1000
GROUP BY p.ProductID,p.Name
order by [Qtycount] desc

--Give the CompanyName of those customers with orders over $100000. Include the subtotal plus tax plus freight.
select s.name [StoreName]
,s.BusinessEntityID
,p.FirstName + ' ' + p.LastName as 'Owner'
,p.BusinessEntityID
,p.PersonType
,CASE p.PersonType
WHEN 'SC' THEN 'STore Contact'
WHEN 'IN' THEN 'Individual Customer'
WHEN 'EM' THEN 'Employee'
WHEN 'SP' THEN 'Sales PErson'
WHEN 'VC' THEN 'Vendor Contact'
WHEN 'GC' THEN 'Global Customer'
ELSE NULL
END
from Sales.SalesOrderHeader soh 
inner join Sales.customer c on soh.CustomerID = c.CustomerID and c.StoreID is NOT NULL
inner join Sales.Store s on s.BusinessEntityID = c.StoreID
inner join Person.Person p on p.BusinessEntityID = c.PersonID
where soh.TotalDue > 100000

--How many items with ListPrice more than $1000 have been sold?
select sod.ProductID,p.Name,sum(sod.OrderQty) as 'Qty'
from Sales.SalesOrderDetail sod 
inner join Production.Product p on p.ProductID = sod.ProductID and p.ListPrice > 1000
Group by sod.ProductID,p.Name
order by  Qty

--or 
SElect p.ProductID
,p.Name
,p.ProductSubcategoryID
,ps.Name
,p.ListPrice
,sod.UnitPrice
,sod.UnitPriceDiscount
,(p.ListPrice - sod.UnitPrice) as 'Discount'
from Sales.SalesOrderDetail sod 
inner join Production.Product p on p.ProductID = sod.ProductID and p.ListPrice > 1000
inner join Production.ProductSubcategory ps on p.ProductSubcategoryID= ps.ProductSubcategoryID
order by p.ListPrice 

--How many Items with ListPrice > 1000 are sold with Profit or Loss
SElect p.ProductID
,p.Name
,sum(sod.OrderQty) as [Items Sold]
,Format(sum(p.ListPrice),'c','en-us') as[Production PRice]
,Format(sum(sod.UnitPRice),'c','en-us') as [Sales PRice]
,Format(sum(p.ListPrice) - sum(sod.UnitPrice),'c','en-us') as [Difference]
,CASE
	WHEN (sum(sod.UnitPrice) - sum(p.ListPrice)) > 0 THEN 'PROFIT'
	ELSE 'Loss'
END as [Profit/Loss]
from Sales.SalesOrderDetail sod 
inner join Production.Product p on p.ProductID = sod.ProductID and p.ListPrice > 1000
--where sod.UnitPrice > 1000
GROUP BY p.ProductID,p.Name

--Find the number of left racing socks ('Racing Socks, L') ordered by CompanyName 'Riding Cycles'
select s.Name
,sum(sod.OrderQty) as [Qty]
,sod.ProductID
from Sales.SalesOrderDetail sod 
inner join Sales.SalesOrderHeader soh on sod.SalesOrderID = soh.SalesOrderID 
inner join Sales.Customer c on soh.CustomerID = c.CustomerID 
inner join Sales.Store s on c.StoreID = s.BusinessEntityID and s.Name like 'Riding Cycles'
where sod.ProductID in (
select ProductID
from Production.Product where name like 'Racing Socks, L')
Group by sod.ProductID,s.Name

