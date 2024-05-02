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
CREATE TABLE Vemployees (
  id INTEGER NOT NULL PRIMARY KEY,
  managerId INTEGER, 
  name VARCHAR(30) NOT NULL,
  FOREIGN KEY (managerId) REFERENCES employees(id)
);

INSERT INTO Vemployees(id, managerId, name) VALUES(1, NULL, 'John');
INSERT INTO Vemployees(id, managerId, name) VALUES(2, 1, 'Mike');

select coAlesce(NULL,0)

select id ,coalesce(managerid,0),name from employees

select * from Vemployees

--workers who are not managers
select * from Vemployees
where id not in (select distinct managerID from Vemployees where managerId is not null)

--workers who are managers but not managed by anyone
select name from Vemployees
where COALESCE(managerId,0) not in (select distinct managerID from Vemployees where managerid is not null)

--workers who are managers
select name from Vemployees
where id in (select distinct managerID from Vemployees where managerid is not null)




-- Expected output (in any order):
-- name
-- ----
-- Mike

-- Explanation:
-- In this example.
-- John is Mike's manager. Mike does not manage anyone.
-- Mike is the only employee who does not manage anyone.