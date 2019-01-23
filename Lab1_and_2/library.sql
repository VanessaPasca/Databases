
if object_id('Authors','U') is not null
	drop table Authors

if object_id('Libraries','U') is not null
	drop table Libraries

if object_id('Domains','U') is not null
	drop table [Domains]

if object_id('Books','U') is not null
	drop table Books

create table Authors(
	aid int primary key not null,
	aname varchar(100)
	)
create table Libraries(
	lid int primary key not null,
	lname varchar(100),
	laddress varchar(100))
create table [domains](
	did int primary key not null,
	descr varchar(100)
	)

create table books(
	bid int primary key not null,
	title varchar(100),
	did int foreign key references [Domains](did),
	lid int foreign key references Libraries(lid),
	adate date,
	aid int foreign key references Authors(aid))

insert into authors values
(1,'Anton Pan'),
(2,'Sarah Mitchelle'),
(3,'Anderson')

insert into libraries values
(1,'Universitatii','Universitatii'),
(2,'BJC','Marasti'),
(3,'Coralis','Horea')

insert into [domains] values
(1,'horror'),
(2,'comedie'),
(3,'psihologica')

insert into books values
(1,'Mapa',3,3,'2017-11-12',3),
(2,'Enigma Maritei',2,1,'2018-09-14',1),
(3,'Cristalinul',1,2,'2019-01-01',2),
(4,'Plinul',2,2,'2018-12-12',3)
insert into books values
(5,'nvchbdf',2,2,'2018-12-04',3),
(6,'dfnjds',1,2,'2019-01-14',3)

go
alter procedure spAddBook @aname varchar(100),@bookId int
as
	if exists(select * from Authors where aname=@aname)
	begin
		if exists(select * from Authors, books where bid=@bookId and books.aid=authors.aid and aname=@aname)
			raiserror('Book associated with this author',16,1)

		declare @ida int

		select @ida=aid from Authors where aname=@aname

		if exists(select * from Books where bid=@bookId) begin
			update Books
			set aid=@ida
			where bid=@bookId
		end
		else raiserror('No book with this id',16,1)
		
	end
	else begin
		declare @maxid int
		select @maxid=max(aid) from Authors
		set @maxid=@maxid+1
		insert into authors values (@maxid,@aname)

		if exists(select * from Books where bid=@bookId) begin
			update Books
			set aid=@maxid
			where bid=@bookId
		end
		else raiserror('No book with this id',16,1)
		

	end
go

select * from authors
select * from books

exec spAddBook 'Anton Pan',3


create view vvv as
	select top 100 L.lname,count(bid) as bought
	from Libraries L,Books B

	where B.adate>'2017-12-31' and B.lid=L.lid 
	group by lname
	having count(bid)>2
	order by lname desc




