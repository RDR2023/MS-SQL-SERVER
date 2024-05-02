
--For every customer with a 'Main Office' in Dallas show AddressLine1 of the 'Main Office' 
--and AddressLine1 of the 'Shipping' address - if there is no shipping address leave it blank. Use one row per customer.
select 
a.AddressLine1
,bea.AddressTypeID
,t.Name
,a.City
,s.Name
,c2.FirstName + ' ' + c2.LastName
from Sales.Customer c 
inner join Sales.CustomerPII c2 on c.CustomerID = c2.CustomerID
inner join Sales.Store s on s.BusinessEntityID = c.StoreID
inner join Person.BusinessEntityAddress bea on c.StoreID = bea.BusinessEntityID and bea.AddressTypeID IN (3,5)
inner join Person.AddressType t on t.AddressTypeID = bea.AddressTypeID
inner join Person.Address a on a.AddressID = bea.AddressID and a.City = 'Dallas'


--12.
--For each order show the SalesOrderID and SubTotal calculated three ways:
--A) From the SalesOrderHeader
--B) Sum of OrderQty*UnitPrice
--C) Sum of OrderQty*ListPrice

select sod.SalesOrderID
,sum(sod.OrderQty * sod.UnitPrice) as 'UnitPrice'
,sum(sod.OrderQty * p.ListPrice) as 'ListPrice'
,SubTotal
from Sales.SalesOrderDetail sod
inner join Sales.SalesOrderHeader soh on sod.SalesOrderID = soh.SalesOrderID
inner join Production.Product p on sod.ProductID = p.ProductID
Group by sod.SalesOrderID,SubTotal
--where sod.SalesOrderID = 43659


--Best Selling item by value
select Top(1)
sod.ProductID
,p.Name
,count(sod.ProductID) as 'No. of times sold'
,max(sod.UnitPrice) as 'unit Price of Product'
from Sales.SalesOrderDetail sod
inner join Production.Product p on p.ProductID = sod.ProductID
Group by sod.ProductID, sod.unitPrice ,p.Name
order by max(sod.unitPrice) desc, count(sod.ProductID) desc

/*
Show how many orders are in the following ranges (in $):

    RANGE      Num Orders      Total Value
    0-  99
  100- 999
 1000-9999
10000-
*/

select '0 - 99' as [Range],count(soh.salesOrderID) [No.Of Orders]
From Sales.SalesOrderHeader soh 
where soh.SubTotal >0 and soh.SubTotal < 100 
UNION
select '100 - 999' as [Range],count(soh.salesOrderID) [No.Of Orders]
From Sales.SalesOrderHeader soh 
where soh.SubTotal >=100 and soh.SubTotal < 1000
UNION
select '1000 - 9999' as [Range],count(soh.salesOrderID) [No.Of Orders]
From Sales.SalesOrderHeader soh 
where soh.SubTotal >=1000 and soh.SubTotal < 10000
UNION
select '10000 - ' as [Range],count(soh.salesOrderID) [No.Of Orders]
From Sales.SalesOrderHeader soh 
where soh.SubTotal >=10000

--Identify the three most important cities. Show the break down of top level product category against city.
