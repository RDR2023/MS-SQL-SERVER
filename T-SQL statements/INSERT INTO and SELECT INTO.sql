
select OBJECT_ID('tempDB..#tempTable' , N'U')
--Max paid Employee by Gender 
IF OBJECT_ID(N'tempDB..#tempTable' , N'U') is not null 
	Drop table #tempTable
GO
--CREATE TABLE #tempTable(GENDER VARCHAR(1),RATE Money,Type Varchar(10))

--select * insert into - creates the table on fly
select 
e.Gender
,max(eph.Rate) as 'Rate'
,'Highest' as 'Type'
INTO #tempTable
from HumanResources.Employee e
inner join HumanResources.EmployeePayHistory eph on eph.BusinessEntityID = e.BusinessEntityID
where eph.RateChangeDate = (select max(ph.RateChangeDate)
							From HumanResources.EmployeePayHistory ph
							group by ph.BusinessEntityID
							having ph.BusinessEntityID = eph.BusinessEntityID)
Group by e.Gender

--use insert into to add additional records to temp table
INSERT INTO #tempTable(Gender,Rate,Type)
select 
e.Gender
,min(eph.Rate) as 'Rate'
,'Lowest' as 'Type'
from HumanResources.Employee e
inner join HumanResources.EmployeePayHistory eph on eph.BusinessEntityID = e.BusinessEntityID
where eph.RateChangeDate = (select max(ph.RateChangeDate)
							From HumanResources.EmployeePayHistory ph
							group by ph.BusinessEntityID
							having ph.BusinessEntityID = eph.BusinessEntityID)
GROUP by e.Gender

select * from #tempTable

select p.FirstName + ' ' + p.LastName
,e.BusinessEntityID,eph.Rate,e.Gender
from HumanResources.Employee e
inner join PErson.PErson p on e.BusinessEntityID = p.BusinessEntityID
inner join HumanResources.EmployeePayHistory eph on eph.BusinessEntityID = e.BusinessEntityID
inner join #tempTable t on e.gender = t.Gender and eph.Rate = t.Rate