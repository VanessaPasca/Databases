CREATE PROCEDURE reloadOrdersTable @number int
as
begin
	while @number > 0 begin
		declare @c int
		

		insert into Orders values (@number,@number,13,'none')

		set @number=@number-1
	end
end

drop procedure reloadOrdersTable