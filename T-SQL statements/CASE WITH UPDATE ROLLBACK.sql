select e.BusinessEntityID, e.SalariedFlag
,e.VacationHours
from HumanResources.Employee e

DECLARE @transactionName Varchar(10) = 'Transaction1';
BEGIN TRAN @transactionName

UPDATE HumanResources.Employee 
SET VacationHours = (
CASE 
WHEN ((VacationHours -10.00) <0) THEN VacationHours + 40.00
ELSE
VacationHours + 20.00
END)

OUTPUT Deleted.BusinessEntityID,
    Deleted.VacationHours AS BeforeValue,
    Inserted.VacationHours AS AfterValue
WHERE SalariedFlag = 0;

ROLLBACK TRAN @transactionName
