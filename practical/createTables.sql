if object_id('Customers','U') is not null 
drop table Customers

if object_id('BankAccounts','U') is not null 
drop table BankAccounts

if object_id('Cards','U') is not null 
drop table Cards

if object_id('ATMs','U') is not null 
drop table ATMs

if object_id('Transactions','U') is not null 
drop table Transactions


create table Customers(
	CuId int primary key identity(1,1) not null,
	CName varchar(100),
	CBirth date)

create table BankAccounts(
	BAId int primary key identity(1,1) not null,
	IBAN varchar(100),
	Balance decimal(12,2),
	CuId int foreign key references Customers(CuId))

create table Cards(
	CId int primary key identity(1,1) not null,
	CNr varchar(100),
	CVV int,
	BAId int foreign key references BankAccounts(BAId)
	)

create table ATMs(
	AId int primary key identity(1,1) not null,
	Address varchar(100)
	)

create Table Transactions(
	TId int primary key identity(1,1) not null,
	Aid int foreign key references ATMs(AId),
	Summ decimal(12,2),
	CId int foreign key references Cards(CId),
	TTime datetime)


insert into Customers values
('Roberta Cristea','2000-12-14'),
('Dan Petroc','1968-07-23'),
('Sanda Gruda','1980-03-12')

select * from Customers

insert into BankAccounts values
('jhseh74hsabd456',2400,2),
('shdfg46bdj9jdsf',6800,3),
('jdh457shdb0dkkk',1300,1),
('kfh9098gasdb68n',230,2),
('hsjfh0097whdb67',1200,3)

insert into Cards values
('123 123 123 123',123,1),
('564 865 789 435',435,1),
('097 754 886 976',976,1),
('847 765 644 876',876,2),
('548 859 754 987',987,3),
('754 643 765 754',754,4),
('446 532 765 865',865,5),
('658 765 754 432',432,5)

insert into ATMs values
('Pta.Cipariu'),
('Iulius Mall'),
('Vivo')

insert into Transactions values
(2,200,3,'2019-01-01'),
(1,100,2,'2018-12-12'),
(1,50,3,'2018-12-31'),
(3,450,8,'2018-07-23'),
(2,345,7,'2018-11-11'),
(2,578,8,'2018-11-23'),
(1,65,8,'2018-11-23'),
(1,10,5,'2018-11-11'),
(2,10,5,'2018-11-11'),
(3,10,5,'2018-11-11')

insert into Transactions values
	(2,200,3,'2019-01-01'),
	(1,50,3,'2018-12-31')


select * from Transactions

--procedure:

go
create procedure spDeleteTransactions @CaNr varchar(100)
as
	declare @cid int

	

	if exists(select cid from Cards C where C.CNr=@CaNr) begin
			select @cid=cid
			from Cards C
			where C.CNr=@CaNr

			delete from Transactions where CId=@cid

			end
	else begin
		raiserror('No card with such number',16,1)
		return
		end

go

exec spDeleteTransactions '097 754 886 976'

select * from Transactions

--view
go
create view vShowCardNumbers as
	select distinct C.CNr
	from Cards C inner join Transactions T on C.CId=T.CId
	where (select count (distinct aid) from Transactions where Cid=C.Cid)=
			(select count(*) from ATMs)

go
select * from vShowCardNumbers

--function

insert into Transactions values 
(2,2300,2,'2018-11-11'),
(1,1000,7,'2018-11-11'),
(3,1200,7,'2018-11-11')

go
create function fCardsWithProperty()
returns table
as 
return
	select C.CNr, C.CVV
	from Cards C
	where 2000<(select sum(Summ) 
				from Transactions T
				where T.CId=C.CId)

go
select * from fCardsWithProperty()


go
alter procedure v2
as begin
	declare @c int
	set @c=1

	while exists(select * from Cards where cid=@c) begin
		declare @cnr varchar(100),@cvv int

		select @cnr=cnr,@cvv=cvv
		from Cards
		where cid=@c

		if (2000< (select sum(Summ) 
				from Transactions T
				where T.CId=@c))
				print(@cnr+'    '+cast(@cvv as varchar))

		set @c=@c+1
		end

end

go
exec v2











