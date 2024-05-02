CREATE PROCEDURE HumanResources.myDepartmentXJobTitleXHeadCount
AS
BEGIN

SET NOCOUNT ON;

SELECT 
d.GroupName
,d.Name
,e.JobTitle
,COUNT(e.BusinessEntityID) as 'Count'
FROM HumanResources.Employee e
inner join HumanResources.EmployeeDepartmentHistory edh on e.BusinessEntityID = edh.BusinessEntityID
inner join HumanResources.Department d on d.DepartmentID = edh.DepartmentID
Group by ROLLUP (d.GroupName,d.Name,e.JobTitle)
order By d.GroupName 

END