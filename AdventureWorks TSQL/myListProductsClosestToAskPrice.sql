IF OBJECT_ID(N'Production.myListProductsClosestToAskPrice',N'TF') IS NOT NULL
	DROP Function Production.myListProductsClosestToAskPrice;

GO

CREATE FUNCTION Production.myListProductsClosestToAskPrice(
	@ProductName NVARCHAR(50),
	@AskPrice money)
	RETURNS @RetList TABLE(
						ProductName NVARCHAR(50),
						ListPrice money)
AS
BEGIN
DECLARE @closestToAskPrice money;

select  @closestToAskPrice = MAX(p.ListPrice)
from Production.Product p
inner join Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID
where s.Name like @ProductName and p.ListPrice < @AskPrice

INSERT INTO @RetList
select p.Name,p.ListPrice
from Production.Product p
inner join Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID
where s.Name like @ProductName and p.ListPrice = @closestToAskPrice

RETURN

END

GO
SELECT * from Production.myListProductsClosestToAskPrice('%Bikes%',700)
GO