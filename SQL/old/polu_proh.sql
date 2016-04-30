USE priemka
GO
CREATE PROCEDURE polu_proh
@name_spec varchar(100),
@prior int,
@count int
AS
BEGIN
DECLARE @not_avg decimal(4,2)
DECLARE @id_s INT
DECLARE @sr_nm varchar(50)
DECLARE @fr_nm varchar(50)
DECLARE @md_nm varchar(50)
DECLARE @avgn decimal(4,2)
DECLARE @docnb varchar(20)
DECLARE @zz1 INT
DECLARE @zz2 INT
DECLARE @zpr table
(
ID int,
sr_nm varchar(50),
fr_nm varchar(50),
md_nm varchar(50),
avgn decimal(4,2)
)
if @prior <> 0
Begin
DECLARE zlp SCROLL CURSOR FOR
SELECT dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn, dbo.benefits.document_number
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
FULL JOIN dbo.benefits ON dbo.benefits.id_statement = dbo.abiture.id_statement
WHERE (dbo.specialty.name_spec = @name_spec and dbo.priem.priority = @prior)
ORDER BY dbo.atestat.avgn DESC
end
else
begin
DECLARE zlp SCROLL CURSOR FOR
SELECT dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn, dbo.benefits.document_number
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
FULL JOIN dbo.benefits ON dbo.benefits.id_statement = dbo.abiture.id_statement
WHERE (dbo.specialty.name_spec = @name_spec)
ORDER BY dbo.atestat.avgn DESC
end
OPEN zlp
DECLARE @DOPNB varchar(20)
DECLARE @ice INT
SET @ice = @count + 1 
FETCH ABSOLUTE @ice FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @zz1, @DOPNB
FETCH PRIOR FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @zz2, @docnb

if ((@zz2 = @zz1) and (@docnb is null) and (@DOPNB is null)) 
Begin
FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn, @docnb

WHILE @@FETCH_STATUS = 0
BEGIN
	if @avgn = @zz1
	Begin
		INSERT INTO @zpr (ID,sr_nm,fr_nm,md_nm,avgn)
		VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @avgn)
	end
	FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn, @docnb
END
END
CLOSE zlp
DEALLOCATE zlp
SELECT * FROM @zpr
END
GO