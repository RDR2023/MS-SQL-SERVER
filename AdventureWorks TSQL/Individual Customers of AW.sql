--Individual customers (names and addresses) that purchase Adventure Works Cycles products online.

select distinct personType from PErson.PErson
Select * from PErson.Person
select * from Person.CountryRegion
Select * from Person.StateProvince
select * from PErson.AddressType
Select * from PErson.BusinessEntityAddress
Select * from PErson.Address
Select * from Person.CountryRegion
select * from Person.PhoneNumberType
select * from Person.PersonPhone

Select 
p.BusinessEntityID
,p.FirstName , p.LastName,p.PersonType
,a.AddressLine1
,a.AddressLine2
,a.City
,sp.Name [StateProvinceName]
,a.PostalCode
,cr.Name [CountryName]
,pp.PhoneNumber
,ea.EmailAddress
,p.EmailPromotion
from Sales.Customer c 
inner join Person.Person p on c.PersonID = p.BusinessEntityID and p.PersonType like 'IN' and c.StoreID is NULL
inner join Person.BusinessEntityAddress bea on bea.BusinessEntityID = p.BusinessEntityID
inner join Person.Address a on bea.AddressID = a.AddressID
inner join Person.StateProvince sp on sp.StateProvinceID = a.StateProvinceID
inner join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode 
left outer join Person.PersonPhone pp on pp.BusinessEntityID = p.BusinessEntityID
left outer join Person.EmailAddress ea on ea.BusinessEntityID = p.BusinessEntityID
order by p.BusinessEntityID
--select * from Sales.vIndividualCustomer