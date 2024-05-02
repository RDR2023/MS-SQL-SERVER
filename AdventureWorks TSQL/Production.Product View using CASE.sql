/*SELECT distinct ProductLine from Production.PRoduct
select * from Production.Product
select * from Production.ProductModel
select * from Production.ProductDescription
select * from Production.ProductModelProductDescriptionCulture
select * from Production.ProductCategory
*/

Select p.ProductID
,p.Name [ProductName]
,pm.Name [ModelName]
,p.ProductLine
,CASE p.ProductLine
	WHEN 'R' THEN 'Road'
	WHEN 'M' THEN 'Mountain'
	WHEN 'T' THEN 'Touring'
	WHEN 'S' THEN 'Other Sale Items'
	ELSE 'Not for Sale'
 END as 'Category'
 ,p.ListPrice
 ,CASE 
	WHEN p.ListPrice=0 THEN 'Mfg item - not for resale'
	WHEN p.ListPrice < 50 THEN ' Under $50'
	WHEN p.ListPrice >=50 and p.ListPrice< 250 THEN 'Under $250'
	WHEN p.ListPrice >=250 AND p.ListPrice <1000 THEN 'Under $1000'
	ELSE 'Over $1000'
 END as 'PriceRange'
,pd.Description
,pmx.CultureID
from Production.Product p
inner join Production.ProductModel pm on p.ProductModelID = pm.ProductModelID
inner join Production.ProductModelProductDescriptionCulture pmx
	on pmx.ProductModelID=pm.ProductModelID
inner join Production.ProductDescription pd 
	on pd.ProductDescriptionID = pmx.ProductDescriptionID

