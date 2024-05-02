select * from Sales.Customer order by storeID 
select * from Sales.Store where name like 'Bike World'
select * from Person.Person where BusinessEntityID = 281
select * from Sales.SalesPerson sp where sp.BusinessEntityID = 281

SELECT * FROM sALES.sALESoRDERhEADER o where o.CustomerID= 23
select * from Sales.SalesOrderDetail 
select * from Production.Product where name like 'Bike World'

--1.Show the first name and the email address of customer with CompanyName 'Bike World'
select p.FirstName,p.LastName,C.CustomerID
from Sales.Store s
inner join Sales.Customer c on c.StoreID = s.BusinessEntityID
inner join Person.Person p on p.BusinessEntityID = c.CustomerID
inner join Person.EmailAddress e on p.BusinessEntityID = e.BusinessEntityID
where s.Name like 'Bike World'

select * from Sales.vStoreWithContacts where name like 'Bike World'
--2.Show the CompanyName for all customers with an address in City 'Dallas'.

select *
from Sales.Customer c
inner join PErson.Person p on p.BusinessEntityID = c.CustomerID
inner join Person.Address a on a.AddressID = c.