create procedure deleteOrdersTable @number int
as begin
	while @number>0 begin
		delete from Orders 
		where Orders.PId=@number

		set @number=@number-1
	end
end