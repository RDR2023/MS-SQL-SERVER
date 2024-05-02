select *
from 
inner join Sales.Customer c on soh.CustomerID = c.CustomerID
inner join Sales.Store s on s.BusinessEntityID = c.StoreID
inner join PErson.Person p on p.BusinessEntityID = c.PersonID

Sales.myCustomerTotalSales cts
where CountryRegionCode = 'US' and TotalSales = 989184.082


Select CountryRegionCode, max(TotalSAles)
from Sales.MyCustomerTotalSales
group by CountryREgionCode