CREATE TABLE Adresses(
	AdressID int NOT NULL PRIMARY KEY,
	City varchar(255) NOT NULL,
	Street varchar(255),
	Number int
);
CREATE TABLE Clients (
    ClientID int NOT NULL PRIMARY KEY,
	ClientName varchar(255) NOT NULL,
	ClientAge int,
	AdressID int FOREIGN KEY REFERENCES Adresses(AdressID)
	
);

CREATE TABLE Accounts (
	AccountID int NOT NULL PRIMARY KEY,
	AccountName varchar(255),
	Overdraft int,
	Balance DECIMAL(12,2),
	CreationDate date,
	ClientID int FOREIGN KEY REFERENCES Clients(ClientID),
	);

CREATE TABLE Cards (
	CardID int NOT NULL PRIMARY KEY,
	CardColor varchar(255),
	ExpirationDate date,
	Pin varchar(255),
	AccountID int UNIQUE FOREIGN KEY REFERENCES  Accounts(AccountID)
);

CREATE TABLE SafeBoxes (
	SafeBoxID int NOT NULL PRIMARY KEY,
	Code varchar(255),
	EstimatedValue DECIMAL(12,2),
	ClientID int FOREIGN KEY REFERENCES Clients(ClientID)
);

CREATE TABLE Wings (
	WingID int NOT NULL PRIMARY KEY,
	WingName varchar(255),
	Floors int,
);

CREATE TABLE Offices (
	OfficeID int NOT NULL PRIMARY KEY,
	OfficeNumber int UNIQUE,
	OfficeName varchar(255),
	OfficeCapacity int,
	OfficeColor varchar(255),
	WingID int FOREIGN KEY REFERENCES Wings(WingID)
);

CREATE TABLE Employees (
	EmployeeID int NOT NULL PRIMARY KEY,
	EmployeeName varchar(255) NOT NULL,
	EmployeeSalary DECIMAL(12,2),
	Age int,
	AdressID int FOREIGN KEY REFERENCES Adresses(AdressID),
	OfficeID int FOREIGN KEY REFERENCES Offices(OfficeID)
);

CREATE TABLE Positions (
	PositionID int NOT NULL PRIMARY KEY,
	PositionName varchar(255) UNIQUE,
	PositionMinimumSalary DECIMAL(12,2),
	PositionMaximumSalary DECIMAL(12,2),
);

CREATE TABLE Departments (
	DepartmentID int NOT NULL PRIMARY KEY,
	DepartmentName varchar(255),
	Leader int FOREIGN KEY REFERENCES Employees(EmployeeId)
);

CREATE TABLE Advice (
	ClientID int FOREIGN KEY REFERENCES Clients(ClientID),
	EmployeeID int FOREIGN KEY REFERENCES  Employees(EmployeeID)
	PRIMARY KEY(ClientID, EmployeeID),
	DomainOfAdvice varchar(255)
);

CREATE TABLE Employees_Departments (
	EmployeeID int FOREIGN KEY REFERENCES Employees(EmployeeID),
	DepartmentID int FOREIGN KEY REFERENCES Departments(DepartmentID),
	YearsOfActivity int
	PRIMARY KEY(EmployeeID,DepartmentID)
);

CREATE TABLE Employees_Positions (
	EmployeeID int FOREIGN KEY REFERENCES Employees(EmployeeID),
	PositionID int FOREIGN KEY REFERENCES Positions(PositionID),
	PRIMARY KEY(EmployeeID,PositionID),
	EmployeeLevel int,
	HiringDate date
);

DROP TABLE Adresses;
DROP TABLE Clients;
DROP TABLE Accounts;
DROP TABLE Cards;
DROP TABLE SafeBoxes;
DROP TABLE Employees;
DROP TABLE Positions;
DROP TABLE Departments;
DROP TABLE Wings;
DROP TABLE Offices;


DROP TABLE Advice;
DROP TABLE Employees_Departments;
DROP TABLE Employees_Positions;









