--"Single Item Order" is a customer order where only one item is ordered. 
--Show the SalesOrderID and the UnitPrice for every Single Item Order.

select sod.SalesOrderID, sod.ProductID,sod.UnitPrice
FROM Sales.SalesOrderDetail sod 
where sod.SalesOrderID IN (
SElect sod.SalesOrderID
from Sales.SalesOrderDetail sod
Group by sod.SalesOrderID
having count(sod.SalesOrderDetailID)=1)
--below is only to check
--Group by sod.SalesOrderID,sod.ProductID,sod.UnitPrice
--Having count(sod.SalesOrderID) = 1


--Where did the racing socks go? List the product name and the CompanyName for all Customers who ordered ProductModel 'Racing Socks'.
Select sod.SalesOrderID,soh.CustomerID,p.Name[Product Name]
,c.PersonID,c.StoreID,p1.PersonType,s.Name[StoreName]
,p1.FirstName + ' ' + p1.LastName [Name]
FRom Sales.SalesOrderHeader soh
inner join SAles.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID
inner join Sales.Customer c on c.CustomerID = soh.CustomerID
LEFT OUTER join Person.Person p1 on p1.BusinessEntityID = c.PersonID
LEFT OUTER JOIN Sales.Store s on s.BusinessEntityID = c.StoreID
inner join Production.Product p on sod.ProductID = p.ProductID
inner join Production.ProductModel pm on p.ProductModelID = pm.ProductModelID and pm.Name like 'Racing Socks'

--Using above result set, find how many are Individual customers and how many are Store Customers
select sod.SalesOrderID,soh.CustomerID,p.Name[Product Name]
,c.PersonID,c.StoreID,p1.PersonType,s.Name[StoreName]
,p1.FirstName + ' ' + p1.LastName [Name]
INTO Table1 
FRom Sales.SalesOrderHeader soh
inner join SAles.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID
inner join Sales.Customer c on c.CustomerID = soh.CustomerID
LEFT OUTER join Person.Person p1 on p1.BusinessEntityID = c.PersonID
LEFT OUTER JOIN Sales.Store s on s.BusinessEntityID = c.StoreID
inner join Production.Product p on sod.ProductID = p.ProductID
inner join Production.ProductModel pm on p.ProductModelID = pm.ProductModelID and pm.Name like 'Racing Socks'


select t.PersonType
,CASE t.PersonType
WHEN 'IN' THEN 'Individual Customer'
WHEN 'SC' THEN 'StoreContact'
END
,count(t.PersonID) 'CustomerCount'
from Table1 t
Group By t.PersonType

--Show the product description for culture 'fr' for product with ProductID 736.
select ProductID,ProductModelID from Production.Product where ProductID = 736
select * from Production.ProductModelProductDescriptionCulture where ProductModelID = 9 and CultureID = 'fr'
select * from Production.ProductDescription where ProductDescriptionID = 1571
select pd.Description
from Production.Product p 
inner join Production.ProductModelProductDescriptionCulture pc on p.ProductModelID = pc.ProductModelID and pc.CultureID = 'fr'
inner join Production.ProductDescription pd on pc.ProductDescriptionID = pd.ProductDescriptionID 
where p.ProductID = 736

--Use the SubTotal value in SaleOrderHeader to list orders from the largest to the smallest. 
--For each order show the CompanyName and the SubTotal and the total weight of the order.
select soh.CustomerId,s.Name,Soh.SalesOrderID,soh.Freight,soh.SubTotal
From Sales.SalesOrderHeader soh 
inner join Sales.Customer c on soh.CustomerID = c.CustomerID and c.StoreID is Not NULL
inner join Sales.Store s on s.BusinessEntityID = c.StoreID
order by soh.Freight desc

--How many products in ProductCategory 'Cranksets' have been sold to an address in 'London'?
select sod.ProductID
--,soh.salesOrderID
,ps.Name
,s.Name
,a.City
,sum(sod.OrderQty)
FROM Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID
inner join PRoduction.Product p on sod.ProductID = p.ProductID
inner join Production.ProductSubcategory ps on p.ProductSubcategoryID = ps.ProductSubcategoryID and ps.Name like 'Cranksets'
inner join Sales.Customer c on c.CustomerID = soh.CustomerID
inner join Sales.Store s on s.BusinessEntityID = c.StoreID 
inner join Person.BusinessEntityAddress bea on bea.BusinessEntityID = s.BusinessEntityID
inner join Person.Address a on a.AddressID = bea.AddressID and a.City like 'London'
GROUP BY sod.ProductID,ps.Name,s.Name,a.City

