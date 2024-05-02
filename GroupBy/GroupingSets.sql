select * from dbo.Sales
select Region,Country,sum(sales)
from dbo.Sales
group by Country,Region

--group by
select Country,sum(sales)
from dbo.Sales
group by Country

--group by rollup
select Country,region, sum(sales)
from dbo.Sales
group by Rollup(country,region)

--group by cube
select Country,region,sum(sales)
from dbo.Sales
group by cube(country,region)


--grouping sets
select Country, region, sum(sales)
from dbo.Sales
group by Rollup(country,region)
Union All
select country,region, sum(sales)
from dbo.Sales
group by cube(country,region)

select * into tempGroupByTbl from dbo.Sales

select * from tempGroupByTbl

--grouping sets
select country,region,sum(Sales)
from dbo.Sales
Group by grouping sets(Rollup(country,region),cube(country,region))

select country,region,sum(sales) as TotalSales
from dbo.Sales
group by Grouping sets((),cube(country,region))