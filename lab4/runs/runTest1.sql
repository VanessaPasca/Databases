
create procedure runTest1 as
begin
	--clean tables
	delete from Orders
	delete from People
	delete from Cakes

	
	
	--delete from TestRuns where Description='running test 1'
	--delete from TestRunTables
	

	declare @myDateTime DATETIME
	declare @runId int
	set @myDateTime = GETDATE()
	declare @testRunStart varchar(max), @testRunEnd varchar(max)
	set @testRunStart=CONVERT(VARCHAR, @myDateTime, 120)

	insert into TestRuns(Description,StartAt) values
	('running test 1',@testRunStart)

	select @runId=TR.TestRunID
	from TestRuns TR
	where TR.Description='running test 1'




	declare @idTest int,@idTable int,@position int,@noOfRows int
	declare @tableName varchar(max),@startTime varchar(max),@endTime varchar(max)
	
	

	select @idTest=t.TestID
	from Tests t
	where t.Name='test1'


	set @position=1

	while exists(select TableId from TestTables T where T.TestID=@idTest and T.Position=@position)
	begin
		
		

		select @idTable=TT.TableID,@noOfRows=TT.NoOfRows
		from TestTables TT
		where TT.TestID=@idTest and TT.Position=@position

	

		select @tableName=Tables.Name from Tables where TableID=@idTable

		print @tableName

		set @myDateTime = GETDATE()
		SET @startTime = CONVERT(VARCHAR, @myDateTime, 120)

		declare @insertCommand varchar(max)
		set @insertCommand='reload'+@tableName+'Table'

		exec @insertCommand @noOfRows

		set @myDateTime = GETDATE()
		SET @endTime = CONVERT(VARCHAR, @myDateTime, 120)
		--insert into TestRunTables the info obtained

		insert into TestRunTables
		values(@runId,@idTable,@startTime,@endTime)

		set @position=@position+1
		

	end

	set @myDateTime = GETDATE()
	set @testRunEnd=CONVERT(VARCHAR, @myDateTime, 120)

	update TestRuns
	set EndAt=@testRunEnd
	where Description='running test 1'
	
end

exec runTest1
drop procedure runTest1

select * from TestRuns
delete from TestRuns
select * from TestRunTables

delete from TestRunTables






