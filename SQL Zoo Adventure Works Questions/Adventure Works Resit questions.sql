--1.List the SalesOrderNumber for the customer 'Good Toys' 'Bike World'

select soh.SalesOrderNumber
,Format(soh.OrderDate,'d','en-us')
,s.Name
From Sales.SalesOrderHeader soh 
inner join Sales.Customer c on soh.CustomerID = c.CustomerID
inner join Sales.Store s on s.BusinessEntityID = c.StoreID where Name like 'Good Toys' or Name like 'Bike World'
order by soh.OrderDate desc

--2.List the ProductName and the quantity of what was ordered by 'Futuristic Bikes'
select sod.ProductID
,p.Name
,sod.OrderQty
,sod.SalesOrderID
,FORMAT(soh.OrderDate,'d','en-us')
From Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
inner join Production.Product p on sod.ProductID = p.ProductID
inner join Sales.Customer c on c.CustomerID = soh.CustomerID
inner join Sales.Store s on s.BusinessEntityID = c.StoreID and s.Name like 'Futuristic Bikes'

--Show the total order value for each CountryRegion. List by value with the highest first.
select Format(sum(soh.TotalDue),'C','en-us') [TotalSales]
,st.CountryRegionCode
from Sales.SalesOrderHeader soh
inner join Sales.SalesTerritory st on soh.TerritoryID = st.TerritoryID
Group by st.CountryRegionCode
order by Sum(soh.TotalDue) desc

--List the name and addresses of companies containing the word 'Bike' (upper or lower case) 
--and companies containing 'cycle' (upper or lower case). Ensure that the 'bike's are listed before the 'cycles's.
select s.Name,a.AddressLine1,a.AddressLine2,a.City,a.PostalCode,sp.Name,sp.CountryRegionCode
from Sales.Store s
inner join Person.BusinessEntityAddress bea on s.BusinessEntityID = bea.BusinessEntityID
inner join Person.Address a on a.AddressID = bea.AddressID
inner join Person.StateProvince sp on sp.StateProvinceID = a.StateProvinceID
where lower(s.Name) like '%bike%'
UNION ALL
select s.Name,a.AddressLine1,a.AddressLine2,a.City,a.PostalCode,sp.Name,sp.CountryRegionCode
from Sales.Store s
inner join Person.BusinessEntityAddress bea on s.BusinessEntityID = bea.BusinessEntityID
inner join Person.Address a on a.AddressID = bea.AddressID
inner join Person.StateProvince sp on sp.StateProvinceID = a.StateProvinceID
where  lower(s.Name) like '%cycle%'

--Find the best customer in each region.
select Top(1) soh.CustomerID
,c.PersonID
,c.StoreID
,s.Name as [Store]
,p.FirstName+' ' + p.LastName as [Customer]
,st.CountryRegionCode
,Format(sum(soh.TotalDue),'c','en-us') as 'TotalSales'
from Sales.SalesOrderHeader soh
inner join Sales.Customer c on soh.CustomerID = c.CustomerID
inner join Sales.Store s on s.BusinessEntityID = c.StoreID
inner join PErson.Person p on p.BusinessEntityID = c.PersonID
inner join Sales.SalesTerritory st on st.TerritoryID = c.TerritoryID
group by soh.CustomerID,s.Name,p.FirstName,p.LastName,st.CountryRegionCode,c.PersonID,c.StoreID
Having st.CountryRegionCode = 'US'
order by sum(soh.TotalDue) desc

--for all regions 
EXEC Sales.myTopCustomer
