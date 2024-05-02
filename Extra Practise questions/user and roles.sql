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
CREATE TABLE users (
  id INTEGER NOT NULL PRIMARY KEY,
  userName VARCHAR(50) NOT NULL
);

CREATE TABLE roles (
  id INTEGER NOT NULL PRIMARY KEY,
  role VARCHAR(20) NOT NULL
);

select * from users
select * from roles

INSERT INTO users(id, userName) VALUES(1, 'Steven Smith');
INSERT INTO users(id, userName) VALUES(2, 'Brian Burns');

INSERT INTO roles(id, role) VALUES(1, 'Project Manager');
INSERT INTO roles(id, role) VALUES(2, 'Solution Architect');

-- Improve the create table statement below:
drop table usersRoles

CREATE TABLE usersRoles (
  id integer IDENTITY(1,1) PRIMARY KEY,
  userId INTEGER NOT NULL,
  roleId INTEGER NOT NULL,
  FOREIGN key(roleID) references Roles(id),
  FOREIGN Key(userId) references Users(id),
  UNIQUE(userid,roleid)
);

select * from users
select * from roles

-- The statements below should pass.
INSERT INTO usersRoles(userId, roleId) VALUES(1, 1);
INSERT INTO usersRoles(userId, roleId) VALUES(1, 2);
INSERT INTO usersRoles(userId, roleId) VALUES(2, 2);

-- The statement below should fail.
INSERT INTO usersRoles(userId, roleId) VALUES(2, NULL);

--statemnt shud fail
INSERT INTO usersRoles(userId, roleId) VALUES(NULL, 1);
