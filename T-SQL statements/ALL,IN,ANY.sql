USE AdventureWorks2016_EXT;
GO
--It finds the products whose list prices are greater than or equal to the maximum list price of any product subcategory.
/*
For each Product subcategory, the inner query finds the maximum list price. 
The outer query looks at all of these values and determines which individual product's list prices are greater than or equal 
to any product subcategory's maximum list price. 
If ANY is changed to ALL, the query returns only those products whose list price is greater than or equal to all the list prices 
returned in the inner query.

If the subquery doesn't return any values, the entire query fails to return any values.

The = ANY operator is equivalent to IN. 
For example, to find the names of all the wheel products that Adventure Works Cycles makes, you can use either IN or = ANY.
*/
SELECT [Name]
FROM Production.Product
WHERE ListPrice >= ALL
    (SELECT MAX (ListPrice)
     FROM Production.Product
     GROUP BY ProductSubcategoryID);

SELECT [Name]
FROM Production.Product
WHERE ListPrice >= ANY
    (SELECT MAX (ListPrice)
     FROM Production.Product
     GROUP BY ProductSubcategoryID);

GO

--For example, to find the names of all the wheel products that Adventure Works Cycles makes, you can use either IN or = ANY.
--solution 1 --
select * 
from Production.Product p
where p.ProductSubcategoryID = 2

select * from PRoduction.ProductSubcategory where name like '%Wheels%'

--solution 2--
select p.Name,ps.Name
from PRoduction.PRoduct p
inner join Production.ProductSubcategory ps on p.ProductSubcategoryID = ps.ProductSubcategoryID
and ps.name like '%Wheels%'

--solution 3 --
select p.Name
from Production.Product p
where p.ProductSubcategoryID = ANY( select ps.ProductSubCategoryID
from Production.ProductSubcategory ps where ps.name like '%wheels%')

--solution 4--
select p.Name
from Production.Product p
where p.ProductSubcategoryID IN ( select ps.ProductSubCategoryID
from Production.ProductSubcategory ps where ps.name like '%wheels%')

