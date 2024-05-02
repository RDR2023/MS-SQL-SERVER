
drop table SSusers;
GO
drop table Friends;
GO
create table SSusers(
id integer IDENTITY(1,1) Primary key,
name varchar(10) not null,
sex varchar(1)
)

create table friends(
user1 int not null,
user2 int not null)
GO
select * from SSusers
select * from Friends

truncate table SSusers
truncate table Friends 

insert into SSusers(name,sex) values('Ann',NULL);
insert into ssusers(name,sex) values('Steve','m');
insert into ssusers(name,sex) values('Mary','f');
insert into ssusers(name,sex) values('Brenda','f')

insert into Friends(user1,user2) values(1,2)
insert into Friends(user1,user2) values(1,3)
insert into Friends(user1,user2) values(2,3)

select SSusers.name,count(*) as count
FROM SSusers
left join friends on SSusers.id = friends.user1 or SSusers.id = friends.user2
where SSusers.sex='f'
Group by SSusers.id,SSusers.name

select SSusers.name
FROM SSusers
left join friends on SSusers.id = friends.user1 or SSusers.id = friends.user2
where SSusers.sex='f'
Group by SSusers.id,SSusers.name