select  sod.ProductID,sum(sod.OrderQty)
--,a.City
FROM Sales.SalesOrderDetail sod 
inner join PRoduction.Product p on sod.ProductID = p.ProductID
inner join Production.ProductSubcategory ps on p.ProductSubcategoryID = ps.ProductSubcategoryID and ps.Name like 'Cranksets'
GROUP BY sod.ProductID,sod.OrderQty


select p.ProductID,soh.SalesOrderID,soh.CustomerID,p1.BusinessEntityID,p1.FirstName + ' ' + p1.LastName
--,a.City
FROM Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID
inner join PRoduction.Product p on sod.ProductID = p.ProductID
inner join Production.ProductSubcategory ps on p.ProductSubcategoryID = ps.ProductSubcategoryID and ps.Name like 'Cranksets'
inner join Sales.Customer c on c.CustomerID = soh.CustomerID
inner join Person.Person p1 on p1.BusinessEntityID IN (c.PersonID, c.StoreID) 
LEFT join Person.BusinessEntityAddress bea on bea.BusinessEntityID = p1.BusinessEntityID
LEFT join Person.Address a on a.AddressID = bea.AddressID --and a.City like 'London'

