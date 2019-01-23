alter procedure runTest2 as
begin
	declare @myDateTime DATETIME
	declare @runId int
	set @myDateTime = GETDATE()
	declare @testRunStart varchar(max), @testRunEnd varchar(max)
	set @testRunStart=CONVERT(VARCHAR, @myDateTime, 120)

	insert into TestRuns(Description,StartAt) values
	('running test 2',@testRunStart)

	select @runId=TR.TestRunID
	from TestRuns TR
	where TR.Description='running test 2'




	declare @idTest int,@idTable int,@position int,@noOfRows int
	declare @tableName varchar(max),@startTime varchar(max),@endTime varchar(max)
	
	

	select @idTest=t.TestID
	from Tests t
	where t.Name='test2'


	set @position=1

	while exists(select TableId from TestTables T where T.TestId=@idTest and T.Position=@position) begin
		select @idTable=T.TableID, @noOfRows=T.NoOfRows
		from TestTables T
		where T.TestID=@idTest and T.Position=@position

		select @tableName=T.Name
		from Tables T
		where T.TableID=@idTable

		set @myDateTime = GETDATE()
		SET @startTime = CONVERT(VARCHAR, @myDateTime, 120)

		declare @deleteCommand varchar(max)
		set @deleteCommand='delete'+@tableName+'Table'

		exec @deleteCommand @noOfRows

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
	where Description='running test 2'


end


exec runTest2