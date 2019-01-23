CREATE PROCEDURE deletePeopleTable @number int
as
begin
	while @number>0 begin
		delete from People
		where People.PId=@number

		set @number=@number-1
		end
end
