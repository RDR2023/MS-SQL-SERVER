/*
The <> ANY operator, however, differs from NOT IN:

<> ANY means not = a, or not = b, or not = c
NOT IN means not = a, and not = b, and not = c
<> ALL means the same as NOT IN
*/

--finds customers located in a territory not covered by any sales persons.

select c.CustomerID
from Sales.Customer c
where c.TerritoryID NOT IN (
select distinct TerritoryID
from Sales.SalesPerson sp)

select c.CustomerID,c.TerritoryID
from Sales.Customer c
where c.TerritoryID <> ALL(
select distinct TerritoryID
from Sales.SalesPerson sp)

--<> ANY returns all customers ,except customers with sales territory as NULL
select c.CustomerID,c.TerritoryID
from Sales.Customer c
where c.TerritoryID <> ANY(
select distinct TerritoryID
from Sales.SalesPerson sp)

--finds the prices of all mountain bike products, their average price,
--and the difference between the price of each mountain bike and the average price.

select p.Name,p.ListPrice
from PRoduction.Product p
where p.ProductSubcategoryID= 1


select p.Name
,p.ListPrice
,(SELECT AVG(p.ListPRice)
		from Production.Product p
		group by p.ProductSubcategoryID
		having p.ProductSubcategoryID = 1)as 'AVG Price'
,p.ListPrice - (SELECT AVG(p.ListPRice)
		from Production.Product p
		group by p.ProductSubcategoryID
		having p.ProductSubcategoryID = 1) as 'Difference'
from PRoduction.Product p
where p.ProductSubcategoryID= 1

--wrong--
select p.Name
,p.ListPrice
,AVG(p.ListPRice)
from Production.Product p
group by p.ProductSubcategoryID,p.Name,p.ListPrice
having p.ProductSubcategoryID = 1

select ProductSubcategoryID from PRoduction.ProductSubcategory where name like 'Mountain Bikes'