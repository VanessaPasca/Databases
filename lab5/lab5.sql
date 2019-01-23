IF OBJECT_ID('Orders','U') is not null
	drop table Orders
IF OBJECT_ID('People','U') is not null
	drop table People
IF OBJECT_ID('Cakes','U') is not null
	drop table Cakes

create table Cakes (
	CId smallint Primary key identity(1,1),
	CName varchar(100) unique ,
	Price int)

create table People(
	PId smallint Primary key identity(1,1),
	PName varchar(100))

	

create table Orders(
	OId smallint primary key identity(1,1),
	Cid smallint references Cakes(Cid),
	PId smallint references People(Pid))

Insert into Cakes values
('Oreo cheesecake',130),
('Apple cake',80),
('Napoleon',120),
('Chesnut',140),
('Snickers cheesecake',130),
('Pavlova',100),
('Pumpkin cake',80),
('Kinder penguin',140),
('Fanta',120),
('Lava cake',60)
-- on table Cakes

-- clustered index scan

select * from Cakes

--clustered index seek
select * from Cakes where CID<3

--nonclustered index scan

create nonclustered index nci1 on Cakes(Price)


select CId,CName from Cakes

--nonclustered index seek

select Price from Cakes where Price>100

--key lookup

create nonclustered index nci2 on Cakes(CName)

select CId,CName,Price
from Cakes
where CName='Cheesecake'



--b)

insert into People values
('Raul'),('George'),('Marius'),('Paula'),('Mason')

insert into People values
('Paula'),('George'),('Paula')
insert into People values
('Paula'),('George'),('Paula')



select * from People where PName='Paula'   --0.0032908 subtree cost

create nonclustered index nci3 on People(PName)


select * from People where PName='Paula'   --0.00328853

alter index nci3 on People disable
alter index nci3 on People rebuild

--c)

insert into Orders values
(1,1),(1,10),(5,4),(2,7),(3,9),(4,6),(10,5),(9,8),(7,4),
(8,2),(8,1),(3,10),(10,9),(2,2)


go
create view vCakesOrders as
select CName,PId
from Cakes Inner join Orders on Cakes.CId=Orders.CId
go



select * from vCakesOrders

--this optimizez the search on Orders
create nonclustered  index nci4 on Orders(Cid) include (PId)

select * from vCakesOrders

alter index nci4 on Orders disable
alter index nci4 on Orders rebuild
