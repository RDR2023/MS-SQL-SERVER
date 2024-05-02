CREATE OR ALTER PROCEDURE dbo.myCurrencyCursor
		@CurrencyCursor CURSOR VARYING OUTPUT
AS
BEGIN

SET @CurrencyCursor = CURSOR FOR 
SELECT  c.CurrencyCode,c.Name
FROM Sales.Currency c

OPEN @CurrencyCursor;
END

GO

CREATE OR ALTER PROCEDURE dbo.myUseCurrencyCursor
AS 
BEGIN

DECLARE @myCursor as CURSOR,@code as NVARCHAR(10),@name as VARCHAR(50);

EXECUTE DBO.myCurrencyCursor @CurrencyCursor = @myCursor OUTPUT;

FETCH NEXT from @myCursor INTO @code,@name;
PRINT @@FETCH_STATUS;
WHILE(@@FETCH_STATUS = 0)
BEGIN
	PRINT @Code + ' ' + @name;
	SELECT * from Sales.Currency c where c.CurrencyCode = @code;
	FETCH NEXT from @myCursor INTO @code,@name;
END
CLOSE @myCursor;
DEALLOCATE @myCursor;

END
GO

EXECUTE dbo.myUseCurrencyCursor 
GO