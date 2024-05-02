INSERT INTO dbo.Complexes(ComplexName) Values('ABC Complex');
INSERT INTO dbo.Complexes(ComplexName) Values('FGH Complex');

select * from dbo.Complexes

insert into dbo.Buildings(ComplexID,BuildingName,[Address])
values(1,'Garden Building A' ,'125 street, NY')
insert into dbo.Buildings(ComplexID,BuildingName,[Address])
values(1,'Garden Building B' ,'524 street, NY')
insert into dbo.Buildings(ComplexID,BuildingName,[Address])
values(2,'Forest Center A' ,'567 street, NY')
insert into dbo.Buildings(ComplexID,BuildingName,[Address])
values(2,'Sea Center B' ,'345 street, NY')

select * from dbo.Buildings

insert into dbo.Apartments(UnitNumber,BuildingID)
values(101,1)
insert into dbo.Apartments(UnitNumber,BuildingID)values(102,1)
insert into dbo.Apartments(UnitNumber,BuildingID)values(103,1)
insert into dbo.Apartments(UnitNumber,BuildingID)values(104,1)
insert into dbo.Apartments(UnitNumber,BuildingID)values(105,1)
insert into dbo.Apartments(UnitNumber,BuildingID)values(201,2)
insert into dbo.Apartments(UnitNumber,BuildingID)values(202,2)
insert into dbo.Apartments(UnitNumber,BuildingID)values(203,2)
insert into dbo.Apartments(UnitNumber,BuildingID)values(204,2)
insert into dbo.Apartments(UnitNumber,BuildingID)values(301,5)
insert into dbo.Apartments(UnitNumber,BuildingID)values(302,5)
insert into dbo.Apartments(UnitNumber,BuildingID)values(303,5)
insert into dbo.Apartments(UnitNumber,BuildingID)values(401,6)
insert into dbo.Apartments(UnitNumber,BuildingID)values(402,6)
select * from dbo.Apartments

insert into dbo.Tenants(TenantName) Values ('Tom')
insert into dbo.Tenants(TEnantName) Values ('Sam')
insert into dbo.Tenants(TEnantName) Values ('Jim')
insert into dbo.Tenants(TEnantName) Values ('Kelly')
insert into dbo.Tenants(TEnantName) Values ('Peter')
insert into dbo.Tenants(TEnantName) Values ('John')

select * from dbo.Tenants

insert into dbo.AptTenants(TenantID,AptID) values(1,1)
insert into dbo.AptTenants(TenantID,AptID) values(2,3)
insert into dbo.AptTenants(TenantID,AptID) values(3,4)
insert into dbo.AptTenants(TenantID,AptID) values(4,5)
insert into dbo.AptTenants(TenantID,AptID) values(5,6)
insert into dbo.AptTenants(TenantID,AptID) values(5,12)
insert into dbo.AptTenants(TenantID,AptID) values(2,13)



insert into dbo.Requests(Status,AptID,description)values('open',7,'abc..')
insert into dbo.Requests(Status,AptID,description)values('open',8,'abc..')
insert into dbo.Requests(Status,AptID,description)values('open',9,'abc..')
insert into dbo.Requests(Status,AptID,description)values('open',10,'abc..')
insert into dbo.Requests(Status,AptID,description)values('closed',11,'abc..')
