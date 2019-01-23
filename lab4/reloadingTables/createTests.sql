SET IDENTITY_INSERT dbo.Tables ON
insert into dbo.Tables(TableID,Name) values
(1,'Cakes'),
(2,'People'),
(3,'Orders')


select * from Tables
SET IDENTITY_INSERT dbo.Tables OFF

go
set identity_insert dbo.Views on

insert into dbo.Views(ViewID,Name) values
(1,'vExpensiveCakes'),
(2,'vFavoriteCakes'),
(3,'vOrdersByCakes')
 
set identity_insert dbo.Views off

insert into dbo.Tests values
('test1'),
('test2')

insert into dbo.Tests values
('test3')


select * from Tests

delete from Tests

--Test 1 : insert into all tables 100 values


insert into TestTables values
(10,1,1000,1),
(10,2,1000,2),
(10,3,1000,3)

insert into TestTables values 
(11,3,1000,1),
(11,2,1000,2),
(11,1,1000,3)

insert into TestViews values
(12,1),
(12,2),
(12,3)





