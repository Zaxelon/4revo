USE priemka
GO
CREATE PROCEDURE doomsayer
@name_spec varchar(100),
@prior int,
@count int
AS
BEGIN
DECLARE @not_avg decimal(3,2)
DECLARE @id_s INT
DECLARE @sr_nm varchar(50)
DECLARE @fr_nm varchar(50)
DECLARE @zpr table
(
ID int,
sr_nm varchar(50),
fr_nm varchar(50),
md_nm varchar(50),
avgn decimal(3,2)
)
DECLARE @md_nm varchar(50)
DECLARE @avgn decimal(3,2)
DECLARE @cntzt INT
if @prior <> 0
Begin
SET @cntzt = (SELECT TOP(@count+1) COUNT(*) AS CNTZ
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
WHERE (dbo.specialty.name_spec = @name_spec and dbo.priem.priority = @prior))
DECLARE zlp SCROLL CURSOR FOR
SELECT TOP(@count+1) dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
WHERE (dbo.specialty.name_spec = @name_spec and dbo.priem.priority = @prior)
ORDER BY dbo.atestat.avgn DESC
end
else
begin
SET @cntzt = (SELECT TOP(@count+1) COUNT(*) AS CNTZ
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
WHERE (dbo.specialty.name_spec = @name_spec))
DECLARE zlp SCROLL CURSOR FOR
SELECT TOP(@count+1) dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
WHERE (dbo.specialty.name_spec = @name_spec)
ORDER BY dbo.atestat.avgn DESC
end
OPEN zlp
FETCH LAST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
if @cntzt>@count SET @not_avg = @avgn else SET @not_avg = 0
FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn

WHILE @@FETCH_STATUS = 0
BEGIN
	if not(@avgn = @not_avg)
	INSERT INTO @zpr (ID,sr_nm,fr_nm,md_nm,avgn)
	VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @avgn)
	FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
END
CLOSE zlp
DEALLOCATE zlp
SELECT * FROM @zpr
END
GO