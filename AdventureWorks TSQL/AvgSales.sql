-- Suggested testing environments
-- For MS SQL:
-- https://sqliteonline.com/ with language set as MS SQL
-- For PostgreSQL:
-- https://sqliteonline.com/ with language set as PostgreSQL
-- For MySQL:
-- https://www.db-fiddle.com/ with MySQL version set to 8
-- For SQLite:
-- http://sqlite.online/
-- Put the following without '--' at the top to enable foreign key support in SQLite.
-- PRAGMA foreign_keys = ON;

-- Example case create statement:

drop table regions
drop table states
drop table employees
drop table Tsales
CREATE TABLE regions(
  id INTEGER PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE states(
  id INTEGER PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  regionId INTEGER NOT NULL,
  FOREIGN KEY (regionId) REFERENCES regions(id)
); 

drop table employees
CREATE TABLE employees (
  id INTEGER PRIMARY KEY,
  name VARCHAR(50) NOT NULL, 
  stateId INTEGER NOT NULL,
  FOREIGN KEY (stateId) REFERENCES states(id)
);

CREATE TABLE Tsales (
  id INTEGER PRIMARY KEY,
  amount INTEGER NOT NULL,
  employeeId INTEGER NOT NULL,
  FOREIGN KEY (employeeId) REFERENCES employees(id)
);

INSERT INTO regions(id, name) VALUES(1, 'North');
INSERT INTO regions(id, name) VALUES(2, 'South');
INSERT INTO regions(id, name) VALUES(3, 'East');
INSERT INTO regions(id, name) VALUES(4, 'West');
INSERT INTO regions(id, name) VALUES(5, 'Midwest');

INSERT INTO states(id, name, regionId) VALUES(1, 'Minnesota', 1);
INSERT INTO states(id, name, regionId) VALUES(2, 'Texas', 2);
INSERT INTO states(id, name, regionId) VALUES(3, 'California', 3);
INSERT INTO states(id, name, regionId) VALUES(4, 'Columbia', 4);
INSERT INTO states(id, name, regionId) VALUES(5, 'Indiana', 5);

INSERT INTO employees(id, name, stateId) VALUES(1, 'Jaden', 1);
INSERT INTO employees(id, name, stateId) VALUES(2, 'Abby', 1);
INSERT INTO employees(id, name, stateId) VALUES(3, 'Amaya', 2);
INSERT INTO employees(id, name, stateId) VALUES(4, 'Robert', 3);
INSERT INTO employees(id, name, stateId) VALUES(5, 'Tom', 4);
INSERT INTO employees(id, name, stateId) VALUES(6, 'William', 5);

INSERT INTO Tsales(id, amount, employeeId) VALUES(1, 2000, 1);
INSERT INTO Tsales(id, amount, employeeId) VALUES(2, 3000, 2);
INSERT INTO Tsales(id, amount, employeeId) VALUES(3, 4000, 3);
INSERT INTO Tsales(id, amount, employeeId) VALUES(4, 1200, 4);
INSERT INTO Tsales(id, amount, employeeId) VALUES(5, 2400, 5);

declare @max integer

select Top(1) @max=COALESCE(sum(t.amount)/count(e.id),0) 
from Tsales t
inner join employees e on t.employeeId = e.id
inner join states s on s.id = e.StateID
right join regions r on r.id = s.regionId
group by r.id,r.name
order by COALESCE(sum(t.amount)/count(e.id),0) desc 

select @max

select r.name
--,sum(t.amount) as 'totalsales'
,COALESCE(sum(t.amount)/count(e.id),0)
,@max - COALESCE(sum(t.amount)/count(e.id),0)
from Tsales t
inner join employees e on t.employeeId = e.id
inner join states s on s.id = e.StateID
right join regions r on r.id = s.regionId
group by r.id,r.name

-- e.g. 'Minnesota' is the only state under the 'North' region. 
-- Total sales made by employees 'Jaden' and 'Abby' for the state of 'Minnesota' is 5000 (2000 + 3000)
-- Total employees in the state of 'Minnesota' is 2
-- Average sales per employee for the 'North' region = Total sales made for the region (5000) / Total number of employees (2) = 2500
-- Difference between the average sales of the region with the highest average sales ('South'), 
-- and the average sales per employee for the region ('North') = 4000 - 2500 = 1500.
-- Similarly, no sale has been made for the only state 'Indiana' under the region 'Midwest'.
-- So the average sales per employee for the region is 0.
-- And, the difference between the average sales of the region with the highest average sales ('South'), 
-- and the average sales per employee for the region ('Midwest') = 4000 - 0 = 4000.

-- Expected output (rows in any order):
-- name     average   difference
-- -----------------------------
-- North	2500	  1500             
-- South 	4000	  0
-- East		1200   	  2800
-- West		2400	  1600
-- Midwest  	0         4000