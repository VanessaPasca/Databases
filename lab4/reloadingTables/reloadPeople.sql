CREATE PROCEDURE reloadPeopleTable @number int
as
begin
	while @number > 0 begin
		declare @c int
		set @c=@number%10
		if @c=1 insert into People values (@number,'Raul',18,10)
		if @c=2 insert into People values (@number,'George',25,8)
		if @c=3 insert into People values (@number,'Christine',32,1)
		if @c=4 insert into People values(@number,'Shawn',27,5)
		if @c=5 insert into People values (@number,'Ellen',45,2)
		if @c=6 insert into People values (@number,'Carol',40,3)
		if @c=7 insert into People values (@number,'Taylor',34,6)
		if @c=8 insert into People values (@number,'Roberto',37,5)
		if @c=9 insert into People values (@number,'Kelly',29,7)
		if @c=0 insert into People values (@number,'Sarah',28,9)
		set @number=@number-1
	end
end

drop procedure reloadPeopleTable

delete from People
go 

exec reloadPeopleTable 20

select * from People