CREATE PROCEDURE deleteCakesTable @number int
as begin
	while @number>0 begin
		delete from Cakes 
		where CId=@number

		set @number=@number-1
	end
end