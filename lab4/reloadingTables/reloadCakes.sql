CREATE PROCEDURE reloadCakesTable @number int
as 
begin
	while @number > 0 begin
		declare @c int
		set @c=@number%10
		if  @c=1  insert into dbo.Cakes values (@number,'Oreo cheesecake',130)
		if @c=2 insert into Cakes values (@number,'Apple cake',80)
		if @c=3 insert into Cakes values (@number,'Napoleon',120)
		if @c=4 insert into Cakes values (@number,'Chesnut',140)
		if @c=5 insert into Cakes values (@number,'Snickers cheesecake',130)
		if @c=6 insert into Cakes values (@number,'Pavlova',100)
		if @c=7 insert into Cakes values (@number,'Pumpkin cake',80)
		if @c=8 insert into Cakes values (@number,'Kinder penguin',140)
		if @c=9 insert into Cakes values (@number,'Fanta',120)
		if @c=0 insert into Cakes values (@number,'Lava cake',60)

		set @number=@number - 1
		end

		
end

delete from Cakes
exec reloadCakesTable 15
drop procedure reloadCakesTable