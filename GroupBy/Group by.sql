select * from Sales.SalesOrderHeader
select * from Sales.SalesOrderDetail

select s.SalesOrderID,sum(s.LineTotal) as 'TotalSales'
from Sales.SalesOrderDetail s
group by s.SalesOrderID 
order by s.SalesOrderID

--retrieves the number of employees for each City from the Address table joined to the EmployeeAddress table.
select a2.City, count(a.BusinessEntityID) as 'EmployeeCount'
from Person.Person p
inner join Person.BusinessEntityAddress a on a.BusinessEntityID = p.BusinessEntityID and p.PersonType = 'EM'
inner join Person.Address a2 on a2.AddressID = a.AddressID
group by a2.City
order by a2.City

--Retrieve total sales for each year
select Year(soh.OrderDate) as 'Year',Format(sum(soh.TotalDue),'c','en-us') as 'TotalSales'
from Sales.SalesOrderHeader soh
group by YEAR(soh.OrderDate)
order by YEAR(soh.OrderDate)

select DATEPART(YYYY,soh.OrderDate) as 'Year',FORMAT(sum(soh.TotalDue),'C','en-US') as 'TotalSales'
from Sales.SalesOrderHeader soh
group by Datepart(yyyy,soh.OrderDate)
order by DATEPART(YYYY,soh.OrderDate)

select DATEPART(YYYY,soh.OrderDate) as 'Year',
DATEPART(mm,soh.OrderDate) as 'Month'
,FORMAT(sum(soh.TotalDue),'C','en-US') as 'TotalSales'
from Sales.SalesOrderHeader soh
group by Datepart(yyyy,soh.OrderDate),DATEPART(mm,soh.OrderDate)
order by DATEPART(YYYY,soh.OrderDate),DATEPART(mm,soh.OrderDate)