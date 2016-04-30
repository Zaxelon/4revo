USE priemka
GO
ALTER PROCEDURE prowedwie
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
SELECT dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn, benefits.document_number
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
SELECT dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn, benefits.document_number
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
FULL JOIN dbo.benefits ON dbo.benefits.id_statement = dbo.abiture.id_statement
WHERE (dbo.specialty.name_spec = @name_spec)
ORDER BY dbo.atestat.avgn DESC
end
OPEN zlp
FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn, @docnb

WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE @iluwka decimal(4,2)
	if @docnb is not null
	SET @iluwka = @avgn + 10.00 else
	SET @iluwka = @avgn
	INSERT INTO @zpr (ID,sr_nm,fr_nm,md_nm,avgn)
	VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @iluwka)
	FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn, @docnb
END
CLOSE zlp
DEALLOCATE zlp
DECLARE @zpr1 table
(
ID int,
sr_nm varchar(50),
fr_nm varchar(50),
md_nm varchar(50),
avgn decimal(4,2)
)
DECLARE @zapas table
(
ID int,
sr_nm varchar(50),
fr_nm varchar(50),
md_nm varchar(50),
avgn decimal(4,2)
)
DECLARE @cntzt INT
if @prior <> 0
Begin
SET @cntzt = (SELECT TOP(@count+1) COUNT(*) AS CNTZ FROM @zpr)
DECLARE zlp SCROLL CURSOR FOR
SELECT TOP(@count+1) ID, sr_nm, fr_nm, md_nm, avgn 
FROM @zpr
ORDER BY avgn DESC
end
else
begin
SET @cntzt = (SELECT TOP(@count+1) COUNT(*) AS CNTZ FROM @zpr)
DECLARE zlp SCROLL CURSOR FOR
SELECT TOP(@count+1) ID, sr_nm, fr_nm, md_nm, avgn 
FROM @zpr
ORDER BY avgn DESC
end
OPEN zlp
FETCH LAST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
if @cntzt>@count SET @not_avg = @avgn else SET @not_avg = 0
FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn

WHILE @@FETCH_STATUS = 0
BEGIN
	if not(@avgn = @not_avg)
	Begin
		DECLARE @bubl decimal(4,2)
		if @avgn>10 SET @bubl = @avgn - 10.00
		else SET @bubl = @avgn
		INSERT INTO @zpr1 (ID,sr_nm,fr_nm,md_nm,avgn)
		VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @bubl)
	end else
	Begin
		DECLARE @pub decimal(4,2)
		if @avgn>10 SET @pub = @avgn - 10.00
		else SET @pub = @avgn
		INSERT INTO @zapas(ID,sr_nm,fr_nm,md_nm,avgn)
		VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @pub)	
	end
	FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
END
CLOSE zlp
DEALLOCATE zlp
--SELECT @count AS VHCOLV,COUNT(*) FROM @zpr1 AS BANDJ
DECLARE @real_count INT
SET @real_count = (SELECT COUNT(*) FROM @zpr1)  
IF @count > @real_count
Begin
	DECLARE zlp SCROLL CURSOR FOR
	SELECT TOP (@count - @real_count) ID, sr_nm, fr_nm, md_nm, avgn
	FROM @zapas
	ORDER BY avgn DESC
	OPEN zlp
	FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	
	WHILE @@FETCH_STATUS = 0 and @count > @real_count
	BEGIN
		DECLARE @zip bit
		SET @zip =(SELECT training_courses FROM dbo.abiture
		WHERE (id_statement = @id_s))
		if @zip = 1
		Begin
			SET @real_count = @real_count + 1
			INSERT INTO @zpr1 (ID,sr_nm,fr_nm,md_nm,avgn)
			VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @bubl) 
		end
		FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	end
	CLOSE zlp
	DEALLOCATE zlp
end

SELECT * FROM @zpr1
END
GO