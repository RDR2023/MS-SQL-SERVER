CREATE OR ALTER View  Sales.myCustomerTotalSales 
as 
select  soh.CustomerID
,st.CountryRegionCode
,sum(soh.TotalDue) as 'TotalSales'
from Sales.SalesOrderHeader soh
inner join Sales.Customer c on soh.CustomerID = c.CustomerID
inner join Sales.SalesTerritory st on st.TerritoryID = c.TerritoryID
group by soh.CustomerID,st.CountryRegionCode
--order by sum(soh.TotalDue) desc

