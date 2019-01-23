alter procedure runTest3 as
begin
	declare @myDateTime DATETIME
	declare @runId int
	set @myDateTime= GETDATE()
	declare @testRunStart varchar(max),@testRunEnd varchar(max)

	set @testRunStart=convert(varchar,@myDateTime,120)

	insert into TestRuns(Description,StartAt) values
	('running test 3',@testRunStart)

	select @runId=TR.TestRunId
	from TestRuns TR
	where TR.Description='running test 3'

	declare @idTest int,@idView int,@position int,@noOfRows int
	declare @viewName varchar(max),@startTime varchar(max),@endTime varchar(max)

	select @idTest=t.TestID
	from Tests t
	where t.Name='test3'

	set @position=1

	declare @maxId int

	select @maxId=max(ViewID)
	from TestViews 
	where TestViews.TestID=@idTest

	while @position<=@maxId begin
		if exists(select ViewId from TestViews TV where TV.TestID=@idTest and TV.ViewID=@position) begin
			select @idView=TV.ViewId from TestViews TV where TV.TestID=@idTest and TV.ViewID=@position

			select @viewName=V.Name from Views V where V.ViewID=@idView
			
			set @myDateTime = GETDATE()
			SET @startTime = CONVERT(VARCHAR, @myDateTime, 120)

			declare @command varchar(max)

			set @command='SELECT * from '+@viewName

			exec (@command)

			set @myDateTime = GETDATE()
			SET @endTime = CONVERT(VARCHAR, @myDateTime, 120)
			--insert into TestRunTables the info obtained

			insert into TestRunViews
			values(@runId,@idView,@startTime,@endTime)
		end

		set @position=@position+1
	end

	set @myDateTime = GETDATE()
	set @testRunEnd=CONVERT(VARCHAR, @myDateTime, 120)

	update TestRuns
	set EndAt=@testRunEnd
	where Description='running test 3'



	

end



exec runTest3