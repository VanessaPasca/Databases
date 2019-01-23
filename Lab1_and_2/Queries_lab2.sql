SELECT * FROM Employees;
INSERT INTO Advice
VALUES (3,14,'investments'),
(1,4,'loans'),
(2,8,''),
(3,13,'loans'),
(4,4,'cards'),
(6,10,'safe boxes'),
(5,10,'safe boxes'),
(9,8,'accounts'),
(6,5,'investments'),
(7,9,''),
(7,3,'accounts');

SELECT * FROM Advice;

SELECT * FROM Adresses;

--			update data – for at least 3 tables;
--1
UPDATE Adresses
SET City='Cluj-Napoca'
WHERE AdressID=3;

UPDATE Adresses
SET City='Turda'
WHERE AdressID=3;
--2
UPDATE Advice
SET DomainOfAdvice='business'
WHERE ClientID=2 AND EmployeeID=8;

UPDATE Advice
SET DomainOfAdvice=''
WHERE ClientID=2 AND EmployeeID=8;

SELECT * from Offices;
--3
UPDATE Offices
SET OfficeName='Apple pie'
WHERE OfficeID=8;

UPDATE Offices
SET OfficeName='Dusk'
WHERE OfficeID=8;

--			delete data – for at least 2 tables.
ALTER TABLE Clients
ADD CONSTRAINT fk_name
    FOREIGN KEY (AdressId)
    REFERENCES Adresses (AdressId)
    ON DELETE CASCADE;


SELECT * FROM Cards;

--1
DELETE FROM Cards
WHERE YEAR(ExpirationDate)=2022;

INSERT INTO Cards
VALUES 
(5,'blue','2022-05-23','3433',2),
(12,'blue','2022-04-25','8743',10);

--2
DELETE FROM SafeBoxes
WHERE EstimatedValue=543;

INSERT INTO SafeBoxes
VALUES (10,'8349',543,3);

--				a. 2 queries with the union operation; use UNION [ALL] and OR;

--Select those accounts which have the id>5 or overdraft>200
SELECT  AccountID, AccountName, Overdraft
FROM Accounts
WHERE AccountID>5
UNION 
SELECT AccountID, AccountName, Overdraft
FROM Accounts
WHERE Overdraft > 200

--Same
SELECT  AccountID, AccountName, Overdraft
FROM Accounts
WHERE AccountID>5 OR Overdraft>200



--				b. 2 queries with the intersection operation; use INTERSECT and IN;

/* Select those adresses with numbers>10 and where also live clients younger than 50*/
SELECT AdressId
FROM Adresses
where (Number>10)
INTERSECT
SELECT AdressID
FROM Clients
where ClientAge<50;

/* Using IN*/
SELECT AdressId
FROM Adresses
where (Number>10) AND 
	AdressId IN (SELECT 
			AdressID
			FROM Clients
			where ClientAge<50);

			/*c. 2 queries with the difference operation; use EXCEPT and NOT IN; */

/* All the offices with numbers > 10, except the ones with capacity<30*/
SELECT *
FROM Offices
WHERE OfficeNumber>10
EXCEPT
SELECT *
FROM Offices
WHERE OfficeCapacity<30;

/* Using NOT IN */
SELECT *
FROM Offices
WHERE OfficeNumber>10
	AND OfficeID NOT IN(
		SELECT OfficeID FROM Offices
		WHERE OfficeCapacity<30);

				--d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN; one query will join at least 3 tables, while another one will join at least two many-to-many relationships;

		/* Clients along with their adresses */
SELECT ClientID,ClientName,Adresses.City,Adresses.Street,Adresses.Number
FROM Clients
FULL JOIN Adresses ON Clients.AdressID=Adresses.AdressID;

/* Adresses with clients name, NULL name where no client lives*/
SELECT Adresses.City,Adresses.Street,Adresses.Number,Clients.ClientName
FROM Adresses
LEFT JOIN Clients ON Adresses.AdressID=Clients.AdressID;


/* Employees with their offices, with their domain of advice, if any*/
SELECT Employees.EmployeeName,Offices.OfficeNumber,Offices.OfficeName,Advice.DomainOfAdvice
FROM Employees
INNER JOIN Offices ON Offices.OfficeID=Employees.EmployeeID
LEFT JOIN Advice ON Employees.EmployeeID=Advice.EmployeeID;	

/*JOIN n:n */

SELECT * FROM Employees_Positions;

select * from Advice;

/* Displays for each "advice" relation, also the name of the possible positions 
the employee might have ( right join - if there is an advice with the id of an inexistent
employee, it will also be displayed) , also displaying the employees that with their position that don't give advice*/
SELECT DISTINCT Employees_Positions.EmployeeID,Positions.PositionName,Advice.DomainOfAdvice,Advice.ClientID
FROM Employees_Positions
RIGHT JOIN Advice ON Employees_Positions.EmployeeID=Advice.EmployeeID
FULL JOIN Positions ON Employees_Positions.PositionID=Positions.PositionID
ORDER BY EmployeeID

--						e. 2 queries using the IN operator to introduce a subquery in the WHERE clause; in at least one query, 
						--the subquery should include a subquery in its own WHERE clause;

/*First 5 clients which have advisors with salary >4000, ordered by ClientAge desc*/	
	
SELECT TOP 5 Clients.ClientName, ClientAge
FROM Clients
WHERE Clients.ClientID IN
		(SELECT Advice.ClientID FROM Advice
		WHERE Advice.EmployeeID IN 
			(SELECT EmployeeID
			FROM Employees
			WHERE EmployeeSalary>4000))
ORDER BY ClientAge DESC;

/*Adresses designated to a client*/
SELECT TOP 5 Adresses.AdressID,Adresses.City,Adresses.Number
FROM Adresses
WHERE AdressID IN
	(SELECT AdressID FROM Clients)
ORDER BY Number;

--			f. 2 queries using the EXISTS operator to introduce a subquery in the WHERE clause;

/* Clients who have at least 2 accounts*/
SELECT Clients.ClientName,Clients.ClientID
FROM Clients
WHERE EXISTS
(SELECT Accounts.ClientID
FROM Accounts
WHERE ACCOUNTS.ClientID=Clients.ClientID 
GROUP BY Accounts.ClientID
HAVING COUNT(*)>=2);

/*Offices in which we have employees registered*/

SELECT Offices.OfficeID,Offices.OfficeName
FROM Offices
WHERE EXISTS(
SELECT Employees.OfficeID
FROM Employees
WHERE Offices.OfficeID=Employees.OfficeID);

--	g. 2 queries with a subquery in the FROM clause;

/* Streets from Cluj-Napoca */
SELECT B.Street   /* works even without the B here */
FROM (
SELECT * FROM Adresses
WHERE City='Cluj-Napoca') as B;


SELECT * FROM Offices;

/*The offices which are blue , ordered descending*/

SELECT OfficeNumber,OfficeName
FROM (
SELECT * FROM Offices
WHERE OfficeColor='blue') as O
ORDER BY OfficeNumber DESC;

/* GROUP BY*/ 

--			h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 
--			2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: 
--			COUNT, SUM, AVG, MIN, MAX;

/* Offices grouped by color and name*/
SELECT OfficeName,OfficeColor FROM Offices
GROUP BY OfficeColor,OfficeName;

/* Offices grouped, having capacity>10*/
SELECT OfficeName,OfficeColor,OfficeCapacity from Offices
GROUP BY OfficeName,OfficeCapacity,OfficeColor
HAVING OfficeCapacity>10;


/* Offices grouped, which are designated to at least 2 employees*/

SELECT OfficeID,OfficeName,OfficeCapacity from Offices
GROUP BY OfficeID,OfficeName,OfficeCapacity
HAVING OfficeID IN (
	SELECT OfficeID FROM Employees
	WHERE Offices.OfficeID=Employees.OfficeID
	GROUP BY OfficeID
	HAVING COUNT(*)>=2);



	/* Select adresses grouped, but only those where some clients live
	and is either one client whose age is >30 , or are more clients, but the
	yongest has to be >30*/
SELECT AdressID,City,Street,Number
FROM Adresses
GROUP BY AdressID,City,Street,Number
HAVING AdressID IN
(
SELECT AdressID FROM Clients
WHERE Adresses.AdressID=Clients.AdressID
GROUP BY AdressID
HAVING ((COUNT(*)=1 AND SUM(ClientAge)>30) OR MIN(ClientAge)=30));


--				i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause; 
--				  2 of them should be rewritten with aggregation operators, while the other 2 
--				  should also be expressed with [NOT] IN.


--1
/* Select those accounts whose balance is smaller than the value
of all safeboxes*/

SELECT DISTINCT Accounts.AccountID,Accounts.Balance /* Without distinct there will be many rows for the same account*/
FROM Accounts,SafeBoxes
WHERE Balance< ALL (SELECT
	EstimatedValue FROM SafeBoxes);

	/*Replace using MIN*/
SELECT DISTINCT Accounts.AccountID,Accounts.Balance /* Without distinct there will be many rows for the same account*/
FROM Accounts,SafeBoxes
WHERE Balance< (SELECT
	MIN(EstimatedValue) FROM SafeBoxes);

	--2
/* Select those adresses where lives a client or an employee*/

SELECT Adresses.AdressID,City,Adresses.Street FROM 
Adresses
WHERE AdressID= ANY (
	SELECT B.AdressID FROM 
	(SELECT AdressID FROM Clients
	UNION ALL
	SELECT AdressID FROM Employees ) AS B
	WHERE Adresses.AdressID=B.AdressID);

	/*Replace using IN*/
SELECT Adresses.AdressID,City,Adresses.Street FROM 
Adresses
WHERE AdressID IN (
	SELECT B.AdressID FROM 
	(SELECT AdressID FROM Clients
	UNION ALL
	SELECT AdressID FROM Employees ) AS B
	WHERE Adresses.AdressID=B.AdressID);


	--3
/*Those employees who have the salary bigger than all
the balances of the existing accounts*/
SELECT Employees.EmployeeName,Employees.EmployeeSalary
FROM Employees
WHERE EmployeeSalary>ALL(
	SELECT Balance FROM Accounts);


	/* REplace using MAX*/
SELECT Employees.EmployeeName,Employees.EmployeeSalary
FROM Employees
WHERE EmployeeSalary>(
	SELECT MAX(Balance) FROM Accounts);

--4
	/* Select those positions who are hold by any employee 
	that has the salary > 10000*/
SELECT Positions.PositionName
FROM Positions
WHERE PositionID=ANY(
	SELECT PositionID FROM Employees_Positions
	WHERE EmployeeID IN (
			SELECT EmployeeID FROM Employees
			WHERE (EmployeeID=Employees_Positions.EmployeeID AND EmployeeSalary>10000)
			));

/* Replace using IN */
SELECT Positions.PositionName
FROM Positions
WHERE PositionID IN(
	SELECT PositionID FROM Employees_Positions
	WHERE EmployeeID IN (
			SELECT EmployeeID FROM Employees
			WHERE (EmployeeID=Employees_Positions.EmployeeID AND EmployeeSalary>10000)
			));

/* DISTINCT */
SELECT City FROM Adresses
GROUP BY City;

-- Count the cities
SELECT COUNT(DISTINCT City)
FROM Adresses



---------------------------------------------------------------------------------------------------------------









-- Select those offices which are not in the wing C where there is an advisor which advises on investments more than 3 clients, 
-- Clients who have more than 30, own a SafeBox , and Accounts/Account with the total money over 30.000 ,
-- Clients who also live in Cluj


SELECT Rez.EmployeeID,Rez.EmployeeName, Rez.EmployeeSalary , Rez.OfficeID
FROM ( SELECT *
		FROM Employees E
		where E.EmployeeID IN (
				SELECT A.EmployeeID
				FROM Advice A
				WHERE A.EmployeeID=E.EmployeeID AND A.DomainOfAdvice='investments'		--they advise in investments
				AND A.ClientID = ANY (			--Clients conditions:
							SELECT C.ClientID
							FROM Clients C
							WHERE C.AdressID IN (		--Make sure they live in Cluj
										SELECT Adr.AdressID
										FROM Adresses Adr
										WHERE Adr.City='Cluj-Napoca')
							AND C.ClientID IN (			--Make sure the accounts condition
									SELECT Acc.ClientID
									FROM Accounts Acc
									WHERE Acc.Balance>=3000			--balance is >30000
									OR 3000<=( SELECT SUM(Acc2.Balance)		--or the sum of all his/her accounts is >30000
																	   FROM Accounts Acc2
																	   WHERE Acc2.ClientID=Acc.ClientID
																	   GROUP BY Acc2.ClientID)
																		
																		
											
									GROUP BY ClientID)
									
							AND C.ClientAge>=30		--age >30
							AND C.ClientID= ANY (	--own at least one safebox
									SELECT DISTINCT Sf.ClientID
									FROM SafeBoxes Sf)
							)


				GROUP BY EmployeeID			
				HAVING COUNT(*)>=2)		--they advise at least 2 clients of this kind
		) as Rez
WHERE  (Rez.EmployeeSalary < 10000) AND ( Rez.OfficeID !=ALL (
			SELECT OfficeID
			FROM Offices O
			INNER JOIN Wings on O.WingID=Wings.WingID
			WHERE Wings.WingName='C'))


INSERT INTO Clients
VALUES (10,'Raluca Suciu',34,10),
(11,'Lazlo Peter',54,12),
(12,'Mihai Ciubancar',49,19),
(13,'Cecilia Tezla',37,18),
(14,'Mihaela Tilda',31,17);


INSERT INTO Clients
VALUES (15,'Anas Mabruk',31,22),
(16,'Omar Bakri',44,23),
(17,'Tarek Shalabi',31,21),
(18,'Amir Yassin',43,24),
(19,'Bob McDonald',65,22);

INSERT INTO Accounts
VALUES (13,'Investments',400,3500,'2017-11-11',10),
(14,'',800,3000,'2018-12-11',10),
(15,'',200,2000,'2015-06-07',10),
(16,'Wedding',0,4000,'2015-06-12',13),
(17,'',200,3150,'2017-04-10',13),
(18,'',1000,5000,'2013-05-17',12),
(19,'Retirement',0,3400,'2018-02-05',12),
(20,'',300,6700,'2012-09-13',11),
(21,'',300,4700,'2012-09-13',11),
(22,'Happy',200,3001,'2015-12-23',14),
(23,'Happy2',200,3001,'2015-12-23',14),
(24,'Happy3',200,3001,'2015-12-23',14);

INSERT INTO Accounts
VALUES
(25,'',200,1500,'2014-11-11',15),
(26,'',0,1550,'2016-09-18',15),
(27,'Trips',100,2435.77,'2009-03-02',16),
(28,'Health',3000,1000,'2013-07-30',16),
(29,'',100,3450,'2017-11-11',17),
(30,'Happy life',2300,4300,'2011-05-26',18),
(31,'Business',1000,5430,'2008-12-20',19);

INSERT INTO SafeBoxes
VALUES (12,'6345',450.60,10),
(13,'5768',2400,11),
(14,'4647',3000.75,12),
(15,'4647',400,13),
(16,'4647',850,13),
(17,'4647',1400,12),
(18,'4647',1250,12),
(19,'4647',4700,10);

INSERT INTO SafeBoxes
VALUES (20,'1234',450.60,15),
(21,'5423',2500,16),
(22,'9753',1346,17),
(23,'9864',3400,18),
(24,'5783',2300,19);


INSERT INTO Employees
VALUES (15,'Adela Popescu',7500,32,15,12),
(16,'Marian Rusu',3400,30,10,4),
(17,'Pamela Piros',5400,40,4,8)

INSERT INTO Employees
VALUES
(18,'Ariana Nealcos',9999,49,10,12),
(19,'Sandra Mepae',8750.99,45,14,4);

INSERT INTO Employees_Positions
VALUES (15,9,2,'2016-04-20'),
(17,7,1,'2017-09-30'),
(17,9,1,'2018-01-25'),
(16,4,2,'2016-04-23'),
(15,2,3,'2014-06-14');

INSERT INTO Employees_Departments
VALUES (11,6,5),
(14,7,3),
(4,8,7),
(15,9,2),
(15,2,1),
(16,7,3),
(17,3,6),
(17,9,1),
(10,8,2),
(14,6,2);

INSERT INTO Advice
VALUES 
(10,18,'loans'),
(11,16,'credits'),
(11,18,'loans');

INSERT INTO Advice
VALUES (19,15,'investments'),
(18,17,'investments'),
(2,19,'investments'),
(17,17,'investments'),
(14,19,'investments'),
(15,17,'investments'),
(16,15,'investments'),
(11,19,'investments');


























