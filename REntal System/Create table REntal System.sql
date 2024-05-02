CREATE TABLE dbo.Complexes(
ComplexID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
ComplexName varchar(100) NOT NULL
)

CREATE TABLE dbo.Buildings(
BuildingID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
ComplexID int NOT NULL,
BuildingName varchar(100) NOT NULL UNIQUE,
[Address] varchar(500) NOT NULL,
Foreign key (ComplexID) references Complexes(complexID)
)

CREATE TABLE dbo.Apartments(
AptID int IDENTITY(1,1) Not NULL PRIMARY KEY,
UnitNumber varchar(10) NOT NULL,
BuildingID int NOT NULL,
Foreign key (buildingID) references Buildings(BuildingID)
)

CREATE TABLE dbo.Tenants(
TenantID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
TenantName varchar(100) NOT NULL
)

CREATE TABLE AptTenants(
TenantID int NOT NULL,
AptID int not NULL,
PRIMARY KEY (TenantID,AptID),
Foreign key (TenantID) references Tenants(TenantID)
)

Create Table dbo.Requests(
RequestID int IDENTITY(1,1) Not null Primary key,
Status varchar(100) Not null,
AptID int not null,
Description varchar(500)
Foreign key(AptID) references Apartments(AptID)
)