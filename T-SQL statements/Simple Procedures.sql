CREATE PROCEDURE What_DB_is_this
AS
BEGIN
	SELECT DB_NAME() as ThisDB
END
GO

EXECUTE What_DB_is_this
GO

CREATE PROCEDURE What_DB_is_that @ID int
as
BEGIN
	SELECT DB_NAME(@ID) as ThatDB;
END
GO

EXEC What_DB_is_that 5
GO
-- Passing the function value as a variable.
DECLARE @CheckDate DATETIME = GETDATE();
EXEC dbo.uspGetWhereUsedProductID 819, @CheckDate;
--EXEC dbo.uspGetWhereUsedProductID 819, GETDATE(); can't pass function value as a parameter

GO