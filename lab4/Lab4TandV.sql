CREATE TABLE Cakes(
	CId int primary key not null,
	CakeName varchar(max),
	CakePrice int)

Insert into Cakes values
(1,'Oreo cheesecake',130),
(2,'Apple cake',80),
(3,'Napoleon',120),
(4,'Chesnut',140),
(5,'Snickers cheesecake',130),
(6,'Pavlova',100),
(7,'Pumpkin cake',80),
(8,'Kinder penguin',140),
(9,'Fanta',120),
(10,'Lava cake',60)

CREATE TABLE People(
	PId int primary key not null,
	PersonName varchar(max),
	PersonAge int,
	FavCake int,
	Foreign key(FavCake) references Cakes(Cid)
	)

insert into People values
(1,'Raul',18,10),
(2,'George',25,8),
(3,'Christine',32,1),
(4,'Shawn',27,5),
(5,'Ellen',45,2),
(6,'Carol',40,3),
(7,'Taylor',34,6),
(8,'Roberto',37,5),
(9,'Kelly',29,7),
(10,'Sarah',28,9)

CREATE TABLE Orders(
    PId int not null,
	CId int not null,
	Quantity int,
	Purpose varchar(max)
	primary key(Pid,Cid)
	foreign key(PId) references People(PId),
	foreign key(CId) references Cakes(CId) 
	)

drop table Orders

insert into Orders values
(7,1,1,'none'),
(1,10,15,'party'),
(5,4,2,'birthday'),
(2,7,1,'family dinner'),
(3,9,2,'Christmas'),
(4,6,1,'none'),
(10,5,3,'party'),
(9,8,5,'work'),
(7,4,1,'family dinner'),
(8,2,3,'birthday'),
(8,1,3,'work'),
(3,10,7,'party'),
(10,9,1,'Christmas'),
(2,2,1,'none')


--show the most expensive cakes
go
create view vExpensiveCakes
as
	select C.CakeName,C.CakePrice
	from Cakes C
	where (c.CakePrice > 120)

go
select * from vExpensiveCakes

--display people with favourite cakes
go
create view vFavoriteCakes
as
  select P.PId,P.PersonName, C.CakeName as FavoriteCake
  from People P inner join Cakes C on P.FavCake=C.CId

go

drop view vFavoriteCakes

select * from vFavoriteCakes
--selecting the orders with cakes, and the number of such orders
go
create view vOrdersByCakes
as
  select C.CakeName,O.Quantity,O.Purpose,count(*) as total
  from Orders O inner join Cakes C on O.CId=C.CId
  group by C.CakeName,O.Quantity,O.Purpose

go

drop view vOrdersByCakes

select * from vOrdersByCakes
