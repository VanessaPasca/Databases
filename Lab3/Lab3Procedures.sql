
USE bankingSystem
go
------------------------------------------------------------------------------------------------------------

--MODIFY TYPE OF A COLUMN

go
CREATE PROCEDURE modifyColumn @Traversing int = 0
AS
	ALTER TABLE dbo.Safeboxes
	ALTER COLUMN EstimatedValue INT;
	
	--update the current version
	declare @oldVersion int 
	select @oldVersion=max(CV.VersionId)
	from CurrentVersion CV

	UPDATE CurrentVersion 
	SET VersionId=@oldVersion+1
	WHERE CurrentVersion.VId=1
	
	-- Traversing  = 0 means that we don't call this procedure in the process of traversing the versions
	-- If we don't do that, that means we introduce a new version, and all the rest bigger than the current one will
	-- be erased
	-- Also we register the call in the Versions table only if it is not in the traversing process
	if @Traversing = 0 
	begin
		DELETE FROM Versions WHERE Versions.VersionId>@oldVersion
	
		--finds last id from the versions
		DECLARE @REZ INT, @proc varchar(255)
		SET @REZ=0
		set @proc='maxId'
		EXEC @proc @result=@rez output
		--creates new entry in the VERSIONS TABLE
		declare @newId INT =@rez+1
		insert into Versions values (@newId,1)
	end
	
GO


--reverse
CREATE PROCEDURE modifyColumn_reverse
AS
	ALTER TABLE Safeboxes
	ALTER COLUMN EstimatedValue DECIMAL


GO



--ADD/REMOVE A COLUMN

CREATE PROCEDURE addColumn @Traversing INT=0
AS
	ALTER TABLE Employees
	ADD MasterDegree INT

	--update the version
	declare @oldVersion int 
	select @oldVersion=max(CV.VersionId)
	from CurrentVersion CV

	UPDATE CurrentVersion 
	SET VersionId=@oldVersion+1
	WHERE CurrentVersion.VId=1

	if @Traversing = 0 
	begin
		DELETE FROM Versions WHERE Versions.VersionId>@oldVersion
	
		--finds last id from the versions
		DECLARE @REZ INT, @proc varchar(255)
		SET @REZ=0
		set @proc='maxId'
		EXEC @proc @result=@rez output
		--creates new entry in the VERSIONS TABLE
		declare @newId INT =@rez+1
		insert into Versions values (@newId,3)
	end

	
GO
--REVERSE
CREATE PROCEDURE addColumn_reverse
AS
	ALTER TABLE Employees
	DROP COLUMN MasterDegree
GO

--ADD/REMOVE A DEFAULT CONSTRAINT

CREATE PROCEDURE addDefault @Traversing INT =0
AS
	ALTER TABLE Adresses
	ADD CONSTRAINT defaultConstr DEFAULT 'Cluj-Napoca' for City


	--update the version
	declare @oldVersion int 
	select @oldVersion=max(CV.VersionId)
	from CurrentVersion CV

	UPDATE CurrentVersion 
	SET VersionId=@oldVersion+1
	WHERE CurrentVersion.VId=1

	if @Traversing = 0 
	begin
		DELETE FROM Versions WHERE Versions.VersionId>@oldVersion
	
		--finds last id from the versions
		DECLARE @REZ INT, @proc varchar(255)
		SET @REZ=0
		set @proc='maxId'
		EXEC @proc @result=@rez output
		--creates new entry in the VERSIONS TABLE
		declare @newId INT =@rez+1
		insert into Versions values (@newId,5)
	end

	
GO



CREATE PROCEDURE addDefault_reverse
AS
	ALTER TABLE Adresses DROP CONSTRAINT newConstr
GO

 
--ADD/REMOVE A PRIMARY KEY

CREATE PROCEDURE removePrimaryKey @Traversing INT =0
AS
	ALTER TABLE SafeBoxes
	DROP CONSTRAINT PK__SafeBoxe__D7B89E6D1413D12B

	--update the version
	declare @oldVersion int 
	select @oldVersion=max(CV.VersionId)
	from CurrentVersion CV

	UPDATE CurrentVersion 
	SET VersionId=@oldVersion+1
	WHERE CurrentVersion.VId=1

	if @Traversing = 0 
	begin
		DELETE FROM Versions WHERE Versions.VersionId>@oldVersion
	
		--finds last id from the versions
		DECLARE @REZ INT, @proc varchar(255)
		SET @REZ=0
		set @proc='maxId'
		EXEC @proc @result=@rez output
		--creates new entry in the VERSIONS TABLE
		declare @newId INT =@rez+1
		insert into Versions values (@newId,7)
	end



	
GO


--REVERSE

CREATE PROCEDURE removePrimaryKey_reverse
AS
	ALTER TABLE SafeBoxes
	ADD CONSTRAINT PK__SafeBoxe__D7B89E6D1413D12B
	PRIMARY KEY(SafeBoxId)
GO 
--ADD/REMOVE A CANDIDATE KEY


CREATE PROCEDURE removeCandidateKey @Traversing INT =0
AS
	ALTER TABLE Offices
	DROP COLUMN OfficeNumber

	--update the version
	declare @oldVersion int 
	select @oldVersion=max(CV.VersionId)
	from CurrentVersion CV

	UPDATE CurrentVersion 
	SET VersionId=@oldVersion+1
	WHERE CurrentVersion.VId=1

	if @Traversing = 0 
	begin
		DELETE FROM Versions WHERE Versions.VersionId>@oldVersion
	
		--finds last id from the versions
		DECLARE @REZ INT, @proc varchar(255)
		SET @REZ=0
		set @proc='maxId'
		EXEC @proc @result=@rez output
		--creates new entry in the VERSIONS TABLE
		declare @newId INT =@rez+1
		insert into Versions values (@newId,9)
	end


GO

--REVERSE

CREATE PROCEDURE removeCandidateKey_reverse
AS
	ALTER TABLE Offices
	ADD OfficeNumber INT
	FOREIGN KEY(WingId) references Wings(WingId)
GO

--ADD/REMOVE A FOREIGN KEY
CREATE PROCEDURE removeForeignKey @traversing INT =0
AS
	ALTER TABLE Safeboxes
	DROP CONSTRAINT  FK__SafeBoxes__Clien__2B0A656D


	--update the version
	declare @oldVersion int 
	select @oldVersion=max(CV.VersionId)
	from CurrentVersion CV

	UPDATE CurrentVersion 
	SET VersionId=@oldVersion+1
	WHERE CurrentVersion.VId=1

	if @Traversing = 0 
	begin
		DELETE FROM Versions WHERE Versions.VersionId>@oldVersion
	
		--finds last id from the versions
		DECLARE @REZ INT, @proc varchar(255)
		SET @REZ=0
		set @proc='maxId'
		EXEC @proc @result=@rez output
		--creates new entry in the VERSIONS TABLE
		declare @newId INT =@rez+1
		insert into Versions values (@newId,11)
	end


GO

--REVERSE
CREATE PROCEDURE removeForeignKey_reverse
AS 
	ALTER TABLE Safeboxes
	ADD CONSTRAINT FK__SafeBoxes__Clien__2B0A656D
	FOREIGN KEY (ClientID) references Clients(ClientID)
GO

--CREATE/REMOVE A TABLE

CREATE PROCEDURE createTable @Traversing INT = 0
AS
	CREATE TABLE Morgages(
		MId varchar(255) primary key,
		Amount DECIMAL(8,2),
		LeftToPay DECIMAL(8,2),
		ClientID INT,
		FOREIGN KEY(ClientID) references Clients(ClientID)
		)

	--update the version
	declare @oldVersion int 
	select @oldVersion=max(CV.VersionId)
	from CurrentVersion CV

	UPDATE CurrentVersion 
	SET VersionId=@oldVersion+1
	WHERE CurrentVersion.VId=1

	declare @T INT
	set @T = @Traversing
	if @T = 0 
	begin
		DELETE FROM Versions WHERE Versions.VersionId>@oldVersion
	
		--finds last id from the versions
		DECLARE @REZ INT, @proc varchar(255)
		SET @REZ=0
		set @proc='maxId'
		EXEC @proc @result=@rez output
		--creates new entry in the VERSIONS TABLE
		declare @newId INT =@rez+1
		insert into Versions values (@newId,13)
	end

GO

create PROCEDURE createTable_reverse 
AS
	DECLARE @Here varchar(max)='DROP TABLE MORGAGES'
	exec (@HERE)
	
GO




go
create procedure maxId @result int output
as
	declare @nr int =0
	select @nr=count(*)
	from Versions
	if @nr=0 set @result=0
	else
		select @result=max(VersionId)
		from Versions
go


create procedure getVersion @versionId int
AS
	declare @current int 

	select @current=max(CV.VersionId)
	from CurrentVersion CV

	while @current>@versionId
	begin
		declare @fctName varchar(100),@fId int,@rId int

		select @fId=V.ProcedureId
		from Versions V
		where V.VersionId=@current

		print @fId

		select @rId=P.ReverseId
		from PROCS P
		where P.ProcedureId=@fId

		print @rId

		select @fctName=P.PName
		from PROCS P
		where P.ProcedureId=@rId

		

		exec @fctName

		set @current=@current-1

		
	end

	while @current<@versionId
	begin
		set @current=@current + 1

		declare @fctName2 varchar (100), @fId2 int
		
		select @fId2=V.ProcedureId
		from Versions V
		where V.VersionId=@current

		select @fctName2=P.PName
		from PROCS P
		where P.ProcedureId=@fId2

		set @fctName2=@fctName2

		exec @fctName2 1
		print @fctName2

		
		
	end

	UPDATE CurrentVersion
	SET VersionId=@versionId
	WHERE VId=1

go













