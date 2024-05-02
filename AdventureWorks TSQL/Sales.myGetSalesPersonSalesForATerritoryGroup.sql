IF OBJECT_ID('Sales.myGetSalesPersonSalesForATerritoryGroup','P') is NOT NULL
	DROP PROCEDURE Sales.myGetSalesPersonSalesForATerritoryGroup
GO

CREATE PROCEDURE Sales.myGetSalesPersonSalesForATerritoryGroup 
		@TerritoryGroup NVARCHAR(50),
		@CountryRegionName NVARCHAR(50) = NULL,
		@City NVARCHAR(50) = NULL
as
BEGIN

SET NOCOUNT ON;

IF @city is NULL 
	SET @City = '%'
IF @CountryRegionName is NULL
	SET @CountryRegionName = '%'
select 
sp.StateProvinceName
,sp.FirstName + ' ' + sp.LastName
,sp.JobTitle
,sp.City
,sp.CountryRegionName
,sp.TerritoryName
,sp.SalesLastYear
,sp.SalesYTD
from Sales.vSalesPerson sp
where TerritoryGroup like @TerritoryGroup
and sp.CountryRegionName like @CountryRegionName
and sp.City like @City
order by StateProvinceName

END

GO
EXEC Sales.myGetSalesPersonSalesForATerritoryGroup @TerritoryGroup = N'North America',
@CountryREgionName = N'Canada',@City = N'Cal%'