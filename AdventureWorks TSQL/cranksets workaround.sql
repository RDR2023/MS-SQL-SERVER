select  sod.ProductID,sum(sod.OrderQty) 'QtySold'
FROM Sales.SalesOrderDetail sod  where sod.ProductID in (949,950,951)
GROUP BY sod.ProductID

SELECT soh.CustomerID, count(soh.CustomerID)
FROM Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID and sod.ProductID in (949,950,951)
GROUP BY soh.CustomerID

SELECT DISTINCT soh.CustomerID
FROM Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID and sod.ProductID in (949,950,951)

SELECT c.PersonID,c.StoreID
FROM Sales.Customer c
where c.customerID IN (SELECT DISTINCT soh.CustomerID
FROM Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID and sod.ProductID in (949,950,951))

SELECT bea.AddressID,bea.BusinessEntityID
FROM Person.BusinessEntityAddress bea 
where bea.BusinessEntityID IN (
SELECT c.StoreID
FROM Sales.Customer c
where c.customerID IN (SELECT DISTINCT soh.CustomerID
FROM Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID and sod.ProductID in (949,950,951)))

SELECT a.AddressID,a.City
FROM Person.Address a
where a.AddressID IN (
SELECT bea.AddressID
FROM Person.BusinessEntityAddress bea 
where bea.BusinessEntityID IN (
SELECT c.StoreID
FROM Sales.Customer c
where c.customerID IN (SELECT DISTINCT soh.CustomerID
FROM Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID and sod.ProductID in (949,950,951))))



SELECT bea.AddressID,bea.BusinessEntityID 
INTO CranksetsTbl
FROM Person.BusinessEntityAddress bea 
where bea.BusinessEntityID IN (
SELECT c.StoreID
FROM Sales.Customer c
where c.customerID IN (SELECT DISTINCT soh.CustomerID
FROM Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID and sod.ProductID in (949,950,951)))


select s.Name,a.City
from CranksetsTbl c
inner join Sales.Store s on c.BusinessEntityID = s.BusinessEntityID
inner join Person.Address a on a.AddressID = c.AddressID and a.City like 'London'

select  sod.ProductID,sum(sod.OrderQty) 'QtySold'
FROM Sales.SalesOrderDetail sod  
where sod.ProductID in (949,950,951)
GROUP BY sod.ProductID