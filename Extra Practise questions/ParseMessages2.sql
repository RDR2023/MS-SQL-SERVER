CREATE OR ALTER PROCEDURE dbo.ParseMessages2
as
Begin

DECLARE @cursor_msgtbl as CURSOR;
DECLARE @id as int, @type as Varchar(20),@msg as Varchar(1000);

SET @cursor_msgtbl = CURSOR 
FOR 
SELECT id,type,data
FROM dbo.messages

open @cursor_msgtbl

FETCH Next from @cursor_msgtbl into @id,@type,@msg

WHILE @@FETCH_STATUS = 0
BEGIN

	print CAST(@id as varchar(10)) + @type + @msg;
	IF (@type = 'notification') 
		INSERT into dbo.notifications(id,message) values (@id,@msg)

	if (@type = 'alert')
		INSERT INTO dbo.alerts(id,shortmessage) values(@id,LEFT(@msg,15))

	FETCH Next from @cursor_msgtbl into @id,@type,@msg;

END

close @cursor_msgtbl;
deallocate @cursor_msgtbl;


End
GO


EXEC dbo.ParseMessages2