--Total Sales made by the sales Person

select soh.SalesPersonID 
,p.FirstName + ' ' + p.LastName 'Sales Person'
,Format(Sum(soh.TotalDue),'c','en-us') as 'Total Sales'
,count(SalesOrderID) as 'No.Of Sales' 
--,p.PersonType
--,sp.BusinessEntityID
,Format(Sum(soh.TotalDue)-sp.SalesYTD ,'c','en-us') as 'Excess'
,Format(sp.SalesYTD,'c','en-us')
From Sales.SalesOrderHeader soh
inner join HumanResources.Employee e on e.BusinessEntityID = soh.SalesPersonID
inner join Sales.SalesPerson sp on sp.BusinessEntityID = e.BusinessEntityID
inner join Person.Person p on p.BusinessEntityID = soh.SalesPersonID
Group by soh.SalesPersonID, p.FirstName,p.LastName
,p.PersonType,sp.BusinessEntityID,sp.SalesYTD
order by Soh.SalesPersonID
