select p.Name,ps.Name
,count(p.Name) over(PARTITION BY p.ProductSubCategoryID) as 'Count'
,max(p.ListPrice) over (Partition by p.ProductSubCategoryID) as 'Max Priced Product in a sub category'
,min(p.ListPrice) over (Partition by p.ProductSubCategoryID) as 'Min Priced Product in a sub category'
from Production.Product p
inner join Production.ProductSubcategory ps on p.ProductSubcategoryID = ps.ProductSubcategoryID


select soh.SalesPersonID
,sod.ProductID
,count(sod.OrderQty) as 'TotalSales'
--,Max(sod.OrderQty) over (Partition by sod.ProductID)
from Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
group by soh.SalesPersonID,sod.ProductID
having soh.SalesPersonID is not null
order by count(sod.OrderQty) desc

--Find sales person with max Order Qty for each product
select 
max(sod.OrderQty) over(Partition by sod.ProductID),
sod.ProductID
,max(sod.OrderQty) as 'TotalSales'
,soh.SalesPersonID
--,Max(sod.OrderQty) over (Partition by sod.ProductID)
from Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID and soh.SalesPersonID is not null
group by sod.ProductID,soh.SalesPersonID
having sod.ProductID in (707)
order by sod.ProductID

declare 
select 
sod.ProductID
,max(sod.OrderQty) as 'MaxOrderQty'
,soh.SalesPersonID
from Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID and soh.SalesPersonID is not null
group by sod.ProductID,soh.SalesPersonID
having max(sod.OrderQty) = 24
order by sod.ProductID,max(sod.OrderQty)

select 
sod.ProductID
,max(sod.OrderQty) OVER (pARTITION BY SOD.pRODUCTid) as 'MaxOrderQty'
from Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID and soh.SalesPersonID is not null

