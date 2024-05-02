USE tempdb
GO

-- Cursor as an output of a stored procedure
CREATE PROCEDURE dbo.usp_cursor_db
@cursor_db CURSOR VARYING OUTPUT
AS
BEGIN
   DECLARE
      @database_id INT, 
      @database_name   VARCHAR(255);

   SET @cursor_db = CURSOR
   FOR SELECT 
         database_id, name
      FROM sys.master_files;

   OPEN @cursor_db;

END
GO

-- Code to retrieve the cursor resultset output from the stored procedure
DECLARE 
    @cursor_db CURSOR

DECLARE
    @database_id INT, 
    @database_name   VARCHAR(255);

EXEC dbo.usp_cursor_db @cursor_db = @cursor_db OUTPUT

FETCH NEXT FROM @cursor_db INTO 
   @database_id, @database_name;

WHILE @@FETCH_STATUS = 0
BEGIN
   PRINT @database_name + ' id:' + CAST(@database_id AS VARCHAR(10));

   FETCH NEXT FROM @cursor_db INTO 
      @database_id, 
      @database_name;
END;

CLOSE @cursor_db;

DEALLOCATE @cursor_db;
GO