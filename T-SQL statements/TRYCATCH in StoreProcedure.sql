select * from Production.WorkOrder where WorkOrderID = 15
select * from Production.WorkOrderRouting where WorkOrderID = 15
GO

CREATE OR ALTER PROCEDURE Production.myDeleteWorkOrder (@workOrderID as INT)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @tran1 as VARCHAR(50) = 'TRANSACTION1'
	BEGIN TRAN @tran1
	BEGIN TRY
		--DELETE works on child table first and then on parent table
		--change the order to raise error
		--parent table deletion
			DELETE From Production.WorkOrder  
			OUTPUT DELETED.*
			where WorkOrderID = 14

		-- child table deletion
			DELETE FROM Production.WorkOrderRouting 
			OUTPUT DELETED.*
			where WorkOrderID = 14

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT>0
			ROLLBACK TRAN @tran1

		declare @error_msg VARCHAR(4000), @error_severity INT;
		SELECT @error_msg=ERROR_MESSAGE(),@error_severity= ERROR_SEVERITY();
		RAISERROR(@error_msg,@error_severity,1);
	END CATCH
END

GO 

EXEC Production.myDeleteWorkOrder @WorkOrderID = 15