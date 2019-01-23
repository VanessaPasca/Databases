

CREATE TABLE PROCS(
	ProcedureId INT PRIMARY KEY NOT NULL,
	PName VARCHAR(255),
	ReverseId INT,
	FOREIGN KEY(ReverseId) references Procs(ProcedureId)
	)

INSERT INTO Procs values
(1,'modifyColumn',2),
(2,'modifyColumn_reverse',1),
(3,'addColumn',4),
(4,'addColumn_reverse',3),
(5,'addDefault',6),
(6,'addDefault_reverse',5),
(7,'removePrimaryKey',8),
(8,'removePrimaryKey_reverse',7),
(9,'removeCandidateKey',10),
(10,'removeCandidateKey_reverse',9),
(11,'removeForeignKey',12),
(12,'removeForeignKey_reverse',11),
(13,'createTable',14),
(14,'createTable_reverse',13);

CREATE TABLE Versions(
	VersionId INT PRIMARY KEY NOT NULL,
	ProcedureId INT,
	Foreign Key(ProcedureId) references Procs(ProcedureId)
	)
go 

CREATE TABLE CurrentVersion(
	VId INT,
	VersionId INT )