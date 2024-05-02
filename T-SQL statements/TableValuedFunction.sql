--TableValued Function

CREATE OR ALTER FUNCTION dbo.MyGetContactInfo(@BusinessEntityID INT)
RETURNS @retContatInfo TABLE(
	BusinessEntityID int NOT NULL,
	FirstName NVARCHAR(50) NULL,
	LastName NVARCHAR(50) NULL,
	ContactType NVARCHAR(50) NULL,
	PRIMARY KEY CLUSTERED(BusinessEntityID ASC)
)
AS
BEGIN
	DECLARE @FirstName NVARCHAR(50),
			@LastName NVARCHAR(50),
			@ContactType NVArchar(50);

	SELECT @FirstName = p.FirstName,
			@LastName = p.LastName,
			@BusinessEntityID = p.BusinessEntityID
	From Person.Person p
	where p.BusinessEntityID = @BusinessEntityID;

	SELECT @ContactType = CASE
		WHEN EXISTS(
		--check for Employee
			SELECT 1
			FROM HumanResources.Employee e
			where e.BusinessEntityID = @BusinessEntityID
		)THEN 'Employee'

		WHEN EXISTS(
		--check for Vendor
			SELECT 1
			FROM Person.BusinessEntityContact bec
			where bec.BusinessEntityID = @BusinessEntityID
		)THEN 'Vendor'

		WHEN EXISTS(
		--check for Store
			SELECT 1
			FROM Purchasing.Vendor v
			WHERE v.BusinessEntityID= @BusinessEntityID
		)THEN 'Store Contact'

		WHEN EXISTS(
		--Direct Customer
			SELECT 1
			FROM Sales.Customer c
			WHERE c.PersonID = @BusinessEntityID
		)THEN 'Consumer'
	END

	--REturn the info in the table
	IF (@BusinessEntityID is NOT NULL) 
	BEGIN
		INSERT INTO @retContatInfo
		SELECT @BusinessEntityID,
				@FirstName,
				@LastName,
				@ContactType
	END
	RETURN;

END

GO
SELECT BusinessEntityID,
FirstName,
LastName,
ContactType
FROM dbo.MyGetContactInfo(1031)

