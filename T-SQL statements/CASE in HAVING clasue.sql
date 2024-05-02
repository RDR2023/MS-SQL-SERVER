--returns the hourly rate for each job title in the HumanResources.Employee table
SELECT * from HumanResources.Employee e where e.BusinessEntityID =89
SELECT * from HumanResources.EmployeePayHistory eph where eph.BusinessEntityID = 89

SELECT e.BusinessEntityID,eph.Rate
FROM HumanResources.Employee e
inner join HumanResources.EmployeePayHistory eph on e.BusinessEntityID =eph.BusinessEntityID
WHERE e.SalariedFlag = 0

--SALARY for each job title
SELECT e.JobTitle,eph.Rate
FROM HumanResources.Employee e
inner join HumanResources.EmployeePayHistory eph on e.BusinessEntityID =eph.BusinessEntityID
WHERE e.SalariedFlag = 1

--Max Pay Rate for each job title
--INSERT INTO tempTbl1
SELECT e.JobTitle,
e.SalariedFlag,
Max(eph.Rate)
FROM HumanResources.Employee e
inner join HumanResources.EmployeePayHistory eph on e.BusinessEntityID =eph.BusinessEntityID
WHERE e.SalariedFlag = 1 or e.SalariedFlag = 0
GROUP BY e.JobTitle, e.SalariedFlag

--Max PayRate if SalariedFlag is 1 and payrate > 40
--Max PayRate if SalariedFlaf is 0 and payrate > 15
--INSERT INTO tempTbl2
SELECT e.JobTitle,
e.SalariedFlag,
Max(eph.Rate) [MaxPayRate]
FROM HumanResources.Employee e
inner join HumanResources.EmployeePayHistory eph on e.BusinessEntityID =eph.BusinessEntityID
GROUP BY e.JobTitle,e.SalariedFlag
Having (
	MAX(CASE 
		WHEN e.SalariedFlag = 1 THEN eph.Rate
		ELSE NULL
	END)>40.00
	OR 
	MAX(CASE 
		WHEN e.SalariedFlag = 0 THEN eph.Rate
		ELSE NULL
	END)>15.00
)
ORDER BY [MaxPayRate]


--check the results
select * 
from dbo.tempTbl1 t1
Left Outer join dbo.tempTbl2 t2 on t1.JobTitle = t2.JobTitle

Select * FROM tempTbl1

select * 
from dbo.tempTbl1 t1
inner join dbo.tempTbl2 t2 on t1.JobTitle = t2.JobTitle