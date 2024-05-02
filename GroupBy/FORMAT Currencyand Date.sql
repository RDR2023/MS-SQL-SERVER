--https://learn.microsoft.com/en-us/sql/t-sql/functions/format-transact-sql?view=sql-server-ver16

--FORMAT DATE, CURRENCY

Declare @d DATE = '4/12/2024';
SELECT FORMAT(@d,'d','en-US') 'US format'
	, FORMAT(@d,'d','en-gb') 'British English'
	,FORMAT(@d,'d','de-de') 'German'
	,FORMAT(@d,'d','zh-cn') 'China';

	
SELECT FORMAT(@d,'D','en-US') 'US format'
	, FORMAT(@d,'D','en-gb') 'British English'
	,FORMAT(@d,'D','de-de') 'German'
	,FORMAT(@d,'D','zh-cn') 'China';

Declare @d2 DATE = GETDATE();

SELECT FORMAT(@d2,'dd/MMM/yyyy','en-US')
,FORMAT(@d2,'dd/MM/yyyy','en-US')
,FORMAT(3035658899,'(###)-###-####','en-US')
,FORMAT(3035658899,'##,##,###','en-US')

USE AdventureWorks2016_EXT
select Top(5) scr.CurrencyRateID
,scr.EndOfDayRate
,FORMAT(scr.EndOfDayRate,'N','en-us')'Numeric Format'
,FORMAT(scr.EndOfDayRate,'G','en-us')'Generic Format'
,FORMAT(scr.EndOfDayRate,'C','en-us')'Currency Format'
from Sales.CurrencyRate scr

--Time Type Formats
select FORMAT(cast('07:33' as time),'hh/.mm','en-US') -- returns NULL, escape .
select FORMAT(cast('07:33' as time),'hh\.mm','en-US')
select FORMAT(cast('09:45' as time),'hh\:mm','en-us')
,FORMAT(SYSDATETIME(),N'hh:mm tt','en-us')
,FORMAT(SYSDATETIME(),N'hh:mm t','en-us')

SELECT FORMAT(CAST('2024-04-12 10:14' as datetime2),N' dd/MM/yyyy hh:mm tt')
,FORMAT(CAST('2024-12-23 08:45' as datetime), N'hh:mm t') 'Display AM/PM'
,FORMAT(CAST('2024-12-23 15:45' as datetime), N'dd/MMM/yyyy hh:mm t')'display PM'
,FORMAT(CAST('2024-12-23 15:45' as datetime), N'dd/MMM/yyyy HH:mm') '24 hr format'

select Format(Cast('2024/02/25 03:45'as datetime),'MMM dd/MMM/yyyy hh:mm tt', 'en-us')

select Format(getDate(),'D','en-us')
select Format(Cast('2024/02/25 03:45'as datetime),'D','en-us')
select Format(GetDate(),'hh:mm tt')
select Format(getDate(),'dd') as 'Day',Format(getDate(),'MM') as 'Month',Format(getDate(),'yyyy') as 'year'
select DATEPART(D,getDate()) as 'Day',DAtePART(mm,getDate()) as 'Month',DatePart(YYYY,getDate()) as 'year'
select DATEADD(D,1,getDate()) as '1 day ahead',DAteADD(mm,1,getDate()) as '1 Month Ahead',DateADD(YYYY,1,getDate()) as '1 year ahead'

select cast('2024-04-26 10:44:18.540' as datetime) - getdate()
select cast('2024-04-26 10:44:18.540' as datetime) - 2
select DATEDIFF(yyyy,'2025-04-30',getDate()), DATEDIFF(m,'2025-04-30',getDate()), DATEDIFF(d,'2025-04-30',getDate())
