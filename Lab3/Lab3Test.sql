USE [bankingSystem];
go
-- TESTING:

exec getVersion 1
exec getVersion 3

select * from Versions
delete from Versions

drop procedure getVersion

select * from CurrentVersion
delete from CurrentVersion

insert into CurrentVersion values (1,0)


exec removeCandidateKey

exec modifyColumn

exec removeForeignKey

exec createTable

exec addColumn




exec modifyColumn_reverse

exec createTable_reverse

exec removeCandidateKey_reverse

exec removeForeignKey_reverse
exec addColumn_reverse