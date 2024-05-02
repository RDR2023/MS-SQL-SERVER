select * from dbo.messages
select * from dbo.alerts
select * from dbo.notifications

truncate table dbo.alerts
truncate table dbo.notifications
GO
create or alter Procedure Parsemessages
as
begin
insert into dbo.alerts
select id, left(data,15) 
from dbo.messages where type = 'alert'

insert into dbo.notifications
select id,data
from dbo.messages where type = 'notification'
end

GO
exec dbo.Parsemessages
GO