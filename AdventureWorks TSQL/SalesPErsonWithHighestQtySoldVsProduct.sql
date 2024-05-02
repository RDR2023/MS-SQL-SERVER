declare @tcursor as Cursor
declare @product as INT, @maxQty as INT;
declare @table as TABLE (
	ProductID INT not null,
	MaxOrderQty INT not null,
	SalesPersonID INT not null
);
SET @tcursor =  cursor for
select 
sod.ProductID
,max(sod.OrderQty) as 'MaxOrderQty'
from Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID and soh.SalesPersonID is not null
group by sod.ProductID
order by sod.ProductID;

open @tcursor;

FETCH NEXT FROM @tcursor INTO @product,@maxQty;

WHILE @@FETCH_STATUS = 0
BEGIN

INSERT INTO @table
select 
sod.ProductID
,max(sod.OrderQty) as 'MaxOrderQty'
,soh.SalesPersonID
from Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID and soh.SalesPersonID is not null
group by sod.ProductID,soh.SalesPersonID
having max(sod.OrderQty) = @maxQty and sod.ProductID = @product

FETCH NEXT FROM @tcursor INTO @product,@maxQty;

END

close @tcursor;
Deallocate @tcursor;
select * from @table
GO

--option 2 much faster--
select OBJECT_ID('t1','U')
drop table t1
select 
sod.ProductID
,max(sod.OrderQty) as 'MaxOrderQty'
INTO T1
from Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID and soh.SalesPersonID is not null
group by sod.ProductID
order by sod.ProductID;

select * from t1
select 
sod.ProductID
,max(sod.OrderQty) as 'MaxOrderQty'
,soh.SalesPersonID 
,DENSE_RANK() over(order by t1.MaxOrderQty desc) as 'DENSE_Rank'
,RANK() over(order by t1.MaxOrderQty desc) as 'Rank'
from Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID and soh.SalesPersonID is not null
inner join t1 on t1.ProductID = sod.ProductID and sod.OrderQty = t1.MaxOrderQty
group by sod.ProductID,soh.SalesPersonID,t1.MaxOrderQty
order by 'DENSE_RANK',sod.ProductID

--rank sales person with regard to sales order qty within a product
select *
from (
select 
sod.ProductID
,ROW_NUMBER() OVER (PARTITION By sod.ProductID Order by sum(sod.OrderQty) desc) as [RowNumber] 
,sum(sod.OrderQty) as [TotalQtySold]
,soh.SalesPersonID 
,DENSE_RANK() over(order by sum(sod.OrderQty) desc) as [Overall Rank1]
--,RANK() over(order by sum(sod.OrderQty) desc) as 'Rank'
from Sales.SalesOrderHeader soh
inner join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID and soh.SalesPersonID is not null
group by sod.ProductID,soh.SalesPersonID
--having ProductID = 900
--order by [TotalQtySold] desc
) as T2  where RowNumber <=3
order by ProductID ,RowNumber




