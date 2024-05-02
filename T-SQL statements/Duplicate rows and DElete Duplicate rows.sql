/*Use MySimpleDB;
GO

SET NOCOUNT ON;

IF OBJECT_ID('dbo.Employee') is not null
	DROP TABLE dbo.Employee;
ELSE
	PRINT 'Table dosen''t exists'
*/
CREATE TABLE dbo.Employee(
	empID INT NOT NULL,
	Name VarCHAR(10) NULL,
	SALARY money
)
GO

INSERT INTO Dbo.Employee
VALUES (1,'Fred',40.00),
(2,'Sam',20.00),
(3,'Ted',35.00),
(4,'Ron',45.00),
(5,'Lei',40.00),
(6,'Suk',20.00)

Print 'Employee table before Delete'
SElect * from dbo.Employee

DECLARE @myDumpTbl as Table(
	empID INT NOT NULL,
	Name VarCHAR(10) NULL,
	SALARY money
)

DELETE FRom dbo.Employee 
OUTPUT DELETED.* into @myDumpTbl
Where empID in (2,3,6)

Print 'Employee table after delete'
SELECT * from dbo.Employee
Print 'Dump table with deleted employee details'
Select * from @myDumpTbl

--find duplicate records from a table
select empID,NAME,SALAry, count(empID) as duplicates
from dbo.Employee
Group by empID,Name,Salary

select empID,NAME,SALAry, count(empID) as duplicates
from dbo.Employee
Group by empID,Name,Salary
Having count(empID)>1

--DELETE the Duplicate records from the table
DELETE FROM dbo.Employee
WHERE EMPID in (SELECT EMPID
FRom dbo.Employee 
Group by empID,Name,Salary
Having count(empID) > 1)