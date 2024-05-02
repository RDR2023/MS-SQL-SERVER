CREATE PROCEDURE HumanResources.myDepartmentXGroupRollUP
AS
BEGIN

SET NOCOUNT ON;
SELECT 
d.GroupName
,d.Name
,COUNT(e.BusinessEntityID) as 'Count'
FROM HumanResources.Employee e
inner join HumanResources.EmployeeDepartmentHistory edh on e.BusinessEntityID = edh.BusinessEntityID
inner join HumanResources.Department d on d.DepartmentID = edh.DepartmentID
Group by ROLLUP (d.GroupName,d.Name)
order By d.GroupName,d.Name

END

GO 

EXECUTE HumanResources.myDepartmentXGroupRollUP