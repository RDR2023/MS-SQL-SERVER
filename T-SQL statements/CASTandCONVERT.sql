USE AdventureWorks2016_EXT;
GO

SELECT p.FirstName,
    p.LastName,
	p.Title,
	e.SickLeaveHours,
    SUBSTRING(p.Title, 1, 25) AS Title,
    CAST(e.SickLeaveHours AS CHAR(1)) AS [Sick Leave]
FROM HumanResources.Employee e
INNER JOIN Person.Person p
    ON e.BusinessEntityID = p.BusinessEntityID
WHERE NOT e.BusinessEntityID > 5;
GO

SELECT CAST(10.6496 AS INT) AS trunc1,
       CAST(-10.6496 AS INT) AS trunc2,
       CAST(10.6496 AS NUMERIC) AS round1,
       CAST(-10.6496 AS NUMERIC) AS round2;

SELECT CAST(10.3496847 AS money);
SELECT FORMAT(CAST(10.3496847 AS money),'c','en-us');

--retrieve the name of the product, for those products that have a 3 as the 
--first digit of list price, and converts their ListPrice values to int.

SELECT SUBSTRING(Name, 1, 30) AS ProductName,
    ListPrice
FROM Production.Product
WHERE CAST(ListPrice AS INT) LIKE '33%';
GO

select p.Name
,p.ListPrice
,cast(p.ListPrice as INT)
,p.StandardCost
from Production.Product p
where cast(p.ListPrice as INT) like '3%'

SELECT p.name,'The list price is ' + CAST(p.ListPrice AS VARCHAR(12)) AS ListPrice
FROM Production.Product p
WHERE p.ListPrice BETWEEN 350.00 AND 400.00;

SELECT p.FirstName,
    p.LastName,
    s.SalesYTD,
    s.BusinessEntityID
FROM Person.Person AS p
INNER JOIN Sales.SalesPerson AS s
    ON p.BusinessEntityID = s.BusinessEntityID
WHERE CAST(CAST(s.SalesYTD AS INT) AS CHAR(20)) LIKE '2%';
GO

select p.Name
,p.ListPrice
,cast(p.ListPrice as INT)
,p.StandardCost
from Production.Product p
where convert(INT , p.ListPrice) like '3%'

SELECT  sp.BusinessEntityID,
sp.SalesYTD
,sp.CommissionPct
,cast(sp.salesYTD as INT) 'salesyeartodate'
,ROUND(sp.SalesYTD/sp.CommissionPct,0)
,CAST(ROUND(sp.SalesYTD/sp.CommissionPct,0) as INT)
from Sales.SalesPerson sp
where sp.CommissionPct >0

select GETDATE() as 'UnconvertedDateTime'
,cast(GETDATE() as NVARCHAR(30)) as 'ConvertedDateTime'
,CONVERT(NVARCHAR(30), GETDATE(), 126) AS 'UsingConvertTo_ISO8601'

select '2024-04-12 18:17:53.983' as 'Unconverted Text'
,CAST('2024-04-12 18:17:53.983' as DATETIME) as 'used CAST'
,CONVERT(DATETIME,'2024-04-12T18:20:28.470',126) as 'UsingConvertTo_ISO8601'

--convert date time data types
DECLARE @d1 DATE,
    @t1 TIME,
    @dt1 DATETIME;

SET @d1 = GETDATE();
SET @t1 = GETDATE();
SET @dt1 = GETDATE();
SET @d1 = GETDATE();

-- When converting date to datetime the minutes portion becomes zero.
SELECT @d1 AS [DATE],
    CAST(@d1 AS DATETIME) AS [date as datetime];

-- When converting time to datetime the date portion becomes zero
-- which converts to January 1, 1900.
SELECT @t1 AS [TIME],
    CAST(@t1 AS DATETIME) AS [time as datetime];

-- When converting datetime to date or time non-applicable portion is dropped.
SELECT @dt1 AS [DATETIME],
    CAST(@dt1 AS DATE) AS [datetime as date],
    CAST(@dt1 AS TIME) AS [datetime as time],
	CAST(@dt1 as TIME),
	FORMAT(@dt1,N'hh:mm tt')