SELECT e.BusinessEntityID , e.SalariedFlag
from HumanResources.Employee e
order by e.SalariedFlag DESC, e.BusinessEntityID


SELECT sp.BusinessEntityID
,sp.FirstName + ' ' + sp.LastName as 'Name'
,sp.TerritoryName
,sp.CountryRegionName
from Sales.vSalesPerson sp
Where sp.TerritoryName IS NOT NULL
ORDER BY sp.CountryRegionName


SELECT sp.BusinessEntityID
,sp.FirstName + ' ' + sp.LastName as 'Name'
,sp.TerritoryName
,sp.CountryRegionName
from Sales.vSalesPerson sp
Where sp.TerritoryName IS NOT NULL
ORDER BY 
CASE CountryRegionName
	WHEN 'United States' THEN sp.TerritoryName
	ELSE sp.CountryRegionName
END