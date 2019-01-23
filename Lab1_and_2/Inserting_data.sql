--insert data – for at least 4 tables; at least one statement should violate referential integrity constraints;
INSERT INTO Adresses
VALUES (1,'Cluj-Napoca','Universitatii',4);

INSERT INTO Adresses
VALUES (2,'Cluj-Napoca','Jupiter',6);

INSERT INTO Adresses
VALUES (3,'Turda','Potaissa',28);

INSERT INTO Adresses
VALUES (4,'Huedin','Avram Iancu',123);

INSERT INTO Adresses
VALUES (5,'Cluj-Napoca','Observatorului',136);

INSERT INTO Adresses
VALUES (6,'Cluj-Napoca','Kogalniceanu',43),
(7,'Huedin','Manastur',16),
(8,'Dej','Pasteur',64),
(9,'Cluj-Napoca','Turturicii',7);

INSERT INTO Adresses
VALUES (10,'Cluj-Napoca','Universitatii',28),
(11,'Baia-Mare','Bucuresti',8),
(12,'Cluj-Napoca','Marinescu',19),
(13,'Cluj-Napoca','Memorandumului',20),
(14,'Cluj-Napoca','Planetelor',4),
(15,'Baciu','Rozelor',17),
(16,'Baciu','Transilvania',166),
(17,'Cluj-Napoca','Fabricii de zahar',18),
(18,'Cluj-Napoca','Bucuresti',23),
(19,'Cluj-Napoca','Horea',200),
(20,'Dej','Fortuna',40);

INSERT INTO Adresses
VALUES (21,'Cluj-Napoca','Pajistei',28),
(22,'Cluj-Napoca','Pastorului',25),
(23,'Cluj-Napoca','Decebal',4),
(24,'Cluj-Napoca','Traian Mosoiu',15);

SELECT * from Adresses;

INSERT INTO Clients 
VALUES (1,'Robert Manole',28,2),
(2,'Carla Rotariu',33,1),
(3,'Mara Cornutiu',20,1);

INSERT INTO Clients
VALUES (4,'Mihai Ciubacar',53,7),
(5,'Andreea Laze',43,4),
(6,'Iulia Tunde',63,5);

INSERT INTO Clients
VALUES (7,'Marian Manea',34,14),
(8,'Carina Rusu',28,19),
(9,'Florina Panea',57,15);


SELECT * from Clients;

INSERT INTO Accounts
VALUES (1,'Investments',2000,250,'2017-11-11',1);

INSERT INTO Accounts
VALUES (2,'',100,-50,'2015-05-07',1),
(3,'For kids',50,3000,'2018-02-15',2),
(4,'Scholarship',200,1000,'2017-09-12',3),
(5,'From parents',1000,2000,'2018-02-15',3),
(6,'Retirement plans',0,4000,'2014-06-30',4),
(7,'',150,700,'2016-11-11',4),
(8,'Holidays',100,1300,'2013-07-18',5),
(9,'Health',100,900,'2016-09-20',5),
(10,'Salary',1500,5000,'2010-09-13',5),
(11,'Shopping',1000,-500,'2011-12-24',5),
(12,'',300,700,'2018-10-16',6);

SELECT * FROM Accounts;

INSERT INTO Cards
VALUES (1,'blue','2019-11-11','1998',4),
(2,'blue','2018-10-24','2013',5),
(3,'orange','2020-10-14','7632',3),
(4,'red','2019-09-14','2022',1),
(5,'blue','2022-05-23','3433',2),
(6,'yellow','2018-12-20','4444',6),
(7,'red','2021-02-14','3567',12),
(8,'blue','2019-04-01','3456',9),
(9,'yellow','2019-03-21','9865',7),
(10,'orange','2018-11-11','8873',11),
(11,'orange','2019-06-07','6655',8),
(12,'blue','2022-04-25','8743',10);

/* VIOLATION*/
INSERT INTO Cards
VALUES (13,'blue','2022-04-25','8743',10);


SELECT * FROM Cards;

INSERT INTO SafeBoxes
VALUES (1,'6345',450.60,4),
(2,'5768',2400,5),
(3,'4647',3000.75,4),
(4,'2348',1800.50,5),
(5,'7348',1555,5),
(6,'8749',4300.45,5),
(7,'7457',670,2),
(8,'3489',1000,1),
(9,'8340',1500,2),
(10,'8349',543,3),
(11,'3723',4500,6);

SELECT * FROM SafeBoxes;

INSERT INTO Wings
VALUES (1,'B',3),
(2,'F',3),
(3,'J',2),
(4,'A',3),
(5,'C',4);

INSERT INTO Offices
VALUES (1,1,'Blueberry',6,'blue',2),
(2,14,'Candy',20,'red',1),
(3,12,'Bowl',50,'white',5),
(4,5,'Melon',4,'orange',1),
(5,3,'Danube',6,'blue',3),
(6,7,'Cupcake',5,'light-pink',4),
(7,8,'Cherry',6,'burgundi',4),
(8,11,'Dusk',13,'grey',3),
(9,15,'Mushroom',25,'light-brown',5),
(10,18,'Cranberry',7,'red',5),
(11,19,'BigB',1,'light-purple',5),
(12,16,'RoboC',4,'bleumarin',2),
(13,17,'Crucial',8,'light-brown',2);

/*VIOLATION*/
INSERT INTO Offices
VALUES (11,11,'Again',4,'red',3);

SELECT * FROM Offices;

INSERT INTO Positions
VALUES (1,'accountant',1200,4500),
(2,'financial analyst',1800,5000),
(3,'auditor',1000,3700),
(4,'collector',2000,6000),
(5,'treasurer',2000,9000),
(6,'loan officer',1500,9500),
(7,'manager',1700,100000),
(8,'supervisor',1000,4000),
(9,'initiator',1500,4500);

SELECT * FROM Positions;

INSERT INTO Employees
VALUES (1,'Mihai Buzatu',19999.99,45,3,11),
(2,'Katerina Alai',7000,34,6,1),
(3,'Paul Maier',9000,37,11,10),
(4,'Mihaela Rusu',11000,30,3,6),
(5,'Adriana Coroiu',6000,43,8,6),
(6,'Paula Manole',4000,24,9,11),
(7,'Cristian Maier',4500,23,15,10),
(8,'Roxana Pelea',5500,31,10,2),
(9,'Luca Manea',3000,25,10,3),
(10,'Bogdan Pop',6700,24,17,4),
(11,'Gabriela Vella',7000,36,11,10),
(12,'Ciprian Gaia',4500,38,17,2),
(13,'Liana Oprea',8600,47,13,2),
(14,'Mihaela Cilean',12400,46,12,1);

SELECT * FROM Employees;

INSERT INTO Departments
VALUES (1,'Safe boxes management',5),
(2,'Clients advisors',2),
(3,'Cards management',10),
(4,'Accounts managements',8),
(5,'Loans',1);

INSERT INTO Departments
VALUES (6,'Information Technology',11),
(7,'HR',14),
(8,'Inspection',4),
(9,'Credits',15);

SELECT * FROM Departments;

INSERT INTO Employees_Departments
VALUES (1,5,15),
(5,1,4),
(2,2,8),
(8,4,5),
(1,4,11),
(1,1,13),
(3,4,7),
(4,4,5),
(5,3,10),
(7,5,6),
(6,2,3),
(6,5,2),
(10,1,9),
(9,4,7),
(10,5,5),
(8,3,11),
(5,2,4),
(7,2,3),
(3,2,6),
(4,2,1);

SELECT * FROM Employees_Departments;

INSERT INTO Employees_Positions
VALUES (1,1,5,'2013-04-11'),
(5,8,0,'2017-11-11'),
(12,6,0,'2017-12-20'),
(2,3,3,'2015-07-24'),
(10,7,2,'2016-05-31'),
(8,3,1,'2017-01-23'),
(3,6,2,'2016-10-11'),
(4,5,1,'2017-05-16'),
(13,1,2,'2016-10-16'),
(5,5,4,'2014-09-24'),
(6,1,0,'2018-08-12'),
(11,9,6,'2012-09-15'),
(7,4,1,'2017-07-18'),
(8,7,2,'2015-11-11'),
(1,3,2,'2016-07-24'),
(9,7,8,'2010-06-25'),
(6,8,5,'2013-09-20'),
(10,5,2,'2016-08-30'),
(11,6,4,'2014-06-13'),
(12,4,7,'2011-08-24'),
(1,7,3,'2015-07-18'),
(13,5,4,'2018-05-20'),
(14,7,5,'2013-04-25'),
(11,4,1,'2017-02-22'),
(13,9,0,'2017-10-27'),
(2,5,7,'2011-06-14');

SELECT * FROM Employees_Positions;
