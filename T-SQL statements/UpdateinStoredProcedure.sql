--update in StoredProcedure
--When the employee is paid hourly (SalariedFlag = 0),
--VacationHours is set to the current number of hours plus the value specified in @NewHours; otherwise, 
--VacationHours is set to the value specified in @NewHours.
IF OBJECT_ID('HumanResources.myUpdate_VacationHrs ', 'P') IS NOT NULL
	DROP PROCEDURE HumanResources.myUpdate_VacationHrs ;
GO
CREATE PROCEDURE HumanResources.myUpdate_VacationHrs 
		@NewHrs smallint,
		@RowCount int output
AS
BEGIN
SET NOCOUNT ON;
DECLARE  @trans1 as NVARCHAR(10) = 'TRAN1';
DECLARE @myTableVar	as Table(
	BusinessEntityID int not null,
	SalariedFlag int,
	OldVacationHrs INT,
	NewVacationHrs INT,
	modifiedDate DATETIME
);

BEGIN TRAN @trans1

UPDATE HumanResources.Employee 
SET VacationHours = (
	CASE SalariedFlag
		WHEN 0 THEN VacationHours  + @NewHrs
	ELSE
		@NewHrs
	END
)
OUTPUT INSERTED.BusinessEntityID,
		Inserted.SalariedFlag,
		deleted.VacationHours,
		Inserted.VacationHours,
		Inserted.ModifiedDate
INTO @myTableVar
WHERE CurrentFlag = 1;

SELECT * from @myTableVar;

SET @RowCount = @@ROWCOUNT;

ROLLBACK TRAN @trans1
END

GO
DECLARE @rowCount int
EXEC HumanResources.myUpdate_VacationHrs @NewHrs = 40, @rowCount = @rowCount;

SELECT @rowCount