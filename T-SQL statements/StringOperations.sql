select * from Person.Person where FirstName like 'R%' order by FirstName asc

SELECT * FROM Person.Person where FirstName like 'R_b'

select distinct PersonType from Person.Person where PersonType <> 'EM'

select * from Person.Person where PersonType in ('EM','SC','SP') 

select * from Person.EmailAddress where EmailAddress like '%[^0-9]@adventure-works.com'

select * from Person.EmailAddress where EmailAddress like '%[0-9]@adventure-works.com'
select * from Person.EmailAddress where EmailAddress like '%[0-3]@adventure-works.com'
select * from Person.EmailAddress where EmailAddress like '%[0-2]@adventure-works.com'

select CHARINDEX('free','THis is the free watch word for freedominCode Camp')

select * from Production.Product where Name like '%Nut%'
select * from Production.Product where CHARINDEX('Nut',name,0)>0
select * from Production.Product where CHARINDEX('computer',name,0)>0

select * from Production.Product where CHARINDEX('bell',name,0)>0

select PATINDEX('%ava%','Javascript is the jack of all trades')
select PATINDEX('ava%','ava Javascript ava is the jack of all trades')
select name, PATINDEX('%ball%',name) position from 
Production.Product
where name like '%ball%'

select name, PATINDEX('%ball%',name) position from 
Production.Product
where PATINDEX('%ball%',name) >0

select distinct PersonType from Person.Person where PersonType in ('EM','SC','SP') 

SELECT ProductID, Name, ProductNumber,ProductLine FROM Production.Product WHERE ProductLine = 'T';

select * from Person.EmailAddress where EmailAddress like '%0@adventure-works.com'

select * from Person.Person 
where YEAR(ModifiedDate) = 2011 
and Month(ModifiedDate) = 1
and (DAY(ModifiedDate) >=1 and DAY(ModifiedDate)<=15)

select count(1) from Person.Person
select @@ROWCOUNT

select Person.FirstName, count(1) as 'Count'
from Person.Person
where Person.FirstName like 'Rob%'
Group by Person.FirstName
having count(1)>=10

select p.FirstName + ' ' + p.LastName ,p.PersonType, 
e.BusinessEntityID, e.OrganizationLevel,e.OrganizationNode,e.HireDate
from Person.Person p
inner join HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID
where e.OrganizationLevel = 1

select p.PersonType , e.OrganizationLevel, count(e.BusinessEntityID) as 'Count'
from Person.Person p
inner join HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID
group by e.OrganizationLevel, p.PersonType

select p.[FirstName]
    ,p.[LastName]
    ,p.[BusinessEntityID]
    ,e.[BusinessEntityID]
	,p.[PersonType]
    ,e.[HireDate]
from Person.Person p
left outer join HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID
where e.HireDate is null


select * from HumanResources.vEmployee where BusinessEntityID = 1
