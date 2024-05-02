select * from dbo.Complexes
select * from dbo.Buildings
select * from dbo.Apartments
select * from dbo.Tenants
select * from dbo.AptTenants
select * from dbo.Requests

--list of tenanats who are renting more than 1 apartment
select t2.TenantName,B.Count
from (
select t.TenantID, count(AptID) as 'Count'
from AptTenants t
group by t.TenantID
having count(aptID)>1
) B 
inner join dbo.Tenants t2 on b.TenantID = t2.TenantID

--list all buildings and number of open requests
select b.BuildingId,b.BuildingName
from Requests r
inner join Apartments a on a.AptID =r.AptID
inner join Buildings b on b.BuildingID = a.BuildingID
where r.status= 'open'

--implement a  query to close all requests from partments in this building
update dbo.Requests 
SET status = 'closed'
Where AptID in (
select a.AptID
from Apartments a 
inner join Buildings b on a.BuildingID = b.BuildingID and b.BuildingName like 'Garden Building B'
)