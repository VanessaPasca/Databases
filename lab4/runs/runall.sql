alter procedure runAll as
begin
	delete from Orders
	delete from People
	delete from Cakes


	delete from TestRunTables
	delete from TestRunViews
	delete from TestRuns

	exec runTest1

	exec runTest3

	exec runTest2
	
	select * from TestRuns
	select * from TestRunTables
	select * from TestRunViews
end

exec runAll
	