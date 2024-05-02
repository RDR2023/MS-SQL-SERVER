select p.Name 
,p.ListPrice
,RANK() over ( order by p.ListPrice desc) as 'Price Rank'
from Production.Product p
where p.ListPrice <> 0


--find max price for a product in a subcategory and rank by price within a subcategory
select p.Name
,p.ListPrice
,p.ProductSubcategoryID
,max(p.ListPrice) over (Partition by p.ProductSubCategoryID ) as 'MaxPrice in subcategory'
,RANK() over (Partition by p.ProductSubCategoryID order by p.ListPRice desc) as 'Price Rank in a subcategory'
from PRoduction.Product p
where p.ListPrice <> 0

select p.Name
,p.ListPrice
,max(p.ListPrice) over (Partition by p.ProductSubCategoryID ) as 'MaxPrice in subcategory'
,p.ProductSubcategoryID
,RANK() over (order by p.ListPRice desc) as 'Price Overall Rank'
,RANK() over (Partition by p.ProductSubCategoryID order by p.ListPRice desc) as 'Price Rank in a subcategory'
,DENSE_RANK() over (Partition by P.ProductSubCategoryID order by p.ListPrice desc) as 'Price d_rank in SubCategory'
from PRoduction.Product p
where p.ListPrice <> 0 
and p.ProductSubcategoryID = 1
order by p.ListPrice desc

--ROWNUMBER
select p.Name
,p.ListPrice
,ROW_NUMBER() over(Order by p.ListPrice desc) as 'Row number by Price'
,RANK() over(order by p.ListPrice desc) as 'Price Rank'
,DENSE_RANK() over (order by p.ListPrice desc) as 'Price Dense Rank'
from Production.Product p
where p.ListPrice is not null