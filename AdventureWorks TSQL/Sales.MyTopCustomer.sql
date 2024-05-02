CREATE OR ALTER PROCEDURE Sales.myTopCustomer 
AS
BEGIN
SET NOCOUNT ON;

declare @country_cursor as CURSOR , @CurrentCountry as VARCHAR(3)
DECLARE @TopCustomer_tbl as TABLE(
CustomerID int NOT NULL,
Store VARCHAR(50) not NULL,
Customer VARCHAR(50) not null,
CountryRegionCode VARCHAR(3) not null,
TotalSales money not null);

SET @country_cursor = CURSOR
FOR
SELECT distinct st.CountryRegionCode
From Sales.SalesTerritory st

Open @country_cursor

FETCH Next from @country_cursor into @CurrentCountry

WHILE @@FETCH_STATUS =0
BEGIN

INSERT INTO @TopCustomer_tbl
select Top(1) soh.CustomerID
,s.Name as [Store]
,p.FirstName+' ' + p.LastName as [Customer]
,st.CountryRegionCode
,Format(sum(soh.TotalDue),'c','en-us') as 'TotalSales'
from Sales.SalesOrderHeader soh
inner join Sales.Customer c on soh.CustomerID = c.CustomerID
inner join Sales.Store s on s.BusinessEntityID = c.StoreID
inner join PErson.Person p on p.BusinessEntityID = c.PersonID
inner join Sales.SalesTerritory st on st.TerritoryID = c.TerritoryID
group by soh.CustomerID,s.Name,p.FirstName,p.LastName,st.CountryRegionCode
Having st.CountryRegionCode = @CurrentCountry
order by sum(soh.TotalDue) desc

FETCH Next from @country_cursor into @CurrentCountry

END

SELECT t.CustomerID
,t.Customer
,t.Store
,t.CountryRegionCode
,FORMAT(t.TotalSales,'c','en-us') as 'TotalSales'
From @TopCustomer_tbl t
order by t.TotalSales desc

close @country_cursor;
deallocate @country_cursor;

END
GO

EXEC Sales.myTopCustomer
