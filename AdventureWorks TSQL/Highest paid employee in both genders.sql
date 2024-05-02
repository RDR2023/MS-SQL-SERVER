
--find highest paid employee in both genders
select *  
from HumanResources.Employee e
where e.SalariedFlag = 1

select eph.BusinessEntityID,count(eph.BusinessEntityID)
from HumanResources.EmployeePayHistory eph
group by eph.BusinessEntityID
having count(eph.BusinessEntityID)>1

select max(eph.ratechangedate)
from HumanResources.EmployeePayHistory eph
where eph.BusinessEntityID = 16

select eph.BusinessEntityID,eph.Rate,eph.RateChangeDate
from HumanResources.EmployeePayHistory eph
where eph.RateChangeDate = (select max(ph.RateChangeDate)
							From HumanResources.EmployeePayHistory ph
							group by ph.BusinessEntityID
							having ph.BusinessEntityID = eph.BusinessEntityID)

--Highest pay by gender 
select e.BusinessEntityID
,e.Gender
,eph.Rate
--,eph.RateChangeDate
,DENSE_RANK() over(order by eph.Rate desc) as 'Overall Highest Pay'
,DENSE_RANK() over(Partition by e.gender order by eph.rate desc) as 'Gender Wise Highest Pay'
from HumanResources.Employee e
inner join HumanResources.EmployeePayHistory eph on eph.BusinessEntityID = e.BusinessEntityID
where eph.RateChangeDate = (select max(ph.RateChangeDate)
							From HumanResources.EmployeePayHistory ph
							group by ph.BusinessEntityID
							having ph.BusinessEntityID = eph.BusinessEntityID)

--Show Top 5 highest pay in Male and Female employees
select Top(10) * 
from (
select e.BusinessEntityID
,e.Gender
,eph.Rate
--,eph.RateChangeDate
,DENSE_RANK() over(order by eph.Rate desc) as 'Overall Highest Pay'
,DENSE_RANK() over(Partition by e.gender order by eph.rate desc) as 'Gender Wise Highest Pay'
from HumanResources.Employee e
inner join HumanResources.EmployeePayHistory eph on eph.BusinessEntityID = e.BusinessEntityID
where  eph.RateChangeDate = (select max(ph.RateChangeDate)
							From HumanResources.EmployeePayHistory ph
							group by ph.BusinessEntityID
							having ph.BusinessEntityID = eph.BusinessEntityID)
) as B where B.[Gender Wise Highest Pay] Between 1 and 5


--Last_Value
select e.BusinessEntityID
,e.Gender
,eph.Rate
--,LAST_VALUE(e.BusinessEntityID) over (order by eph.Rate desc) as 'Least Paid Employee' 
,LAST_VALUE(e.BusinessEntityID) over (order by eph.Rate desc ROWS bETWEEN UNBOUNDED PRECEDING  AND UNBOUNDED FOLLOWING) as 'LEast Paid Employee'
,LAST_VALUE(e.BusinessEntityID) over (order by eph.Rate asc ROWS bETWEEN UNBOUNDED PRECEDING  AND UNBOUNDED FOLLOWING) as 'Highest Paid Employee'
,CONCAT(LAST_VALUE(e.BusinessEntityID) over (PARTITION By e.Gender order by eph.Rate desc ROWS bETWEEN UNBOUNDED PRECEDING  AND UNBOUNDED FOLLOWING),' --',
LAST_VALUE(eph.rate) over(PARTITION By e.Gender order by eph.Rate desc ROWS bETWEEN UNBOUNDED PRECEDING  AND UNBOUNDED FOLLOWING)) as 'LEast Paid Employee by Gender'
from HumanResources.Employee e
inner join HumanResources.EmployeePayHistory eph on eph.BusinessEntityID = e.BusinessEntityID
where eph.RateChangeDate = (select max(ph.RateChangeDate)
							From HumanResources.EmployeePayHistory ph
							group by ph.BusinessEntityID
							having ph.BusinessEntityID = eph.BusinessEntityID)



