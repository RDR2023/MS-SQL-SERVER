--insert new records

--insert some new records into the employee

INSERT INTO dbo.Employee(empid,name,SALARY) values (10,'Ryan',30.00);
INSERT INTO dbo.Employee(empid,name,SALARY) values (11,'Josh',24.00);

INSERT INTO dbo.temp_tbl(empid,name,SALARY) values (12,'Pam',25.00);
INSERT INTO dbo.temp_tbl(empid,name,SALARY) values (13,'Dane',33.00);


--joins
select * from dbo.employee  
order by empid

select * from dbo.temp_tbl 
order by empid
--Employee tbl is missing 3 and temp tbl is missing 2 and 9

--inner join
-- shows only the matching records
--shows 6,7,8
select e.*
from dbo.Employee e
inner join dbo.temp_tbl t on e.empID = t.empid

--left join
-- shows matching records + records that are in employee e table but not in temp_tbl
-- shows 2,6,7,8,9,10,11
-- like just left.*
select e.*
from dbo.employee e
left join dbo.temp_tbl t on e.empID = t.empID
order by e.empid
--changing to t.*
--shows null records for id:2,9,10 and 11, but does not show 3 as its not there in employee table
select t.*
from dbo.employee e
left join dbo.temp_tbl t on e.empID = t.empID
order by t.empid


--right join
--shows records 6,7,8 as they are matching records. 
--since we chose e.*, shows a null record for record 3,12,13 in temp_tbl
-- does not show 2 and 9 from employee table as we use right join, records 2 and 9 does not xists in temp tbl and 
select e.*
from dbo.employee e
right join dbo.temp_tbl t on t.empid = e.empid

--shows all records from temp tbl even the ones that does not match
select t.*
from dbo.employee e
right join dbo.temp_tbl t on t.empid = e.empid
order by t.empid

--inner join with exists
select e.*
from dbo.employee e where Exists (select t.empid from dbo.temp_tbl t where e.empid = t.empid)

--shows only the records 2, 9,10 and 11
select e.*
from dbo.employee e
except
select t.* from dbo.temp_tbl t 

--OR using a subquery

select e.*
from dbo.Employee e where e.empID not in (select t.empid from dbo.temp_Tbl t)

--OR using Exists
select e.*
from dbo.Employee e where NOT Exists(select t.empid from dbo.temp_tbl t where t.empid = e.empid)
order by e.empid

select * from employee