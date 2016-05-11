GO
CREATE DATABASE priemka
ON 
( NAME = priemka,
FILENAME = 'C:\priemka.mdf',
SIZE = 10,
MAXSIZE = 100,
FILEGROWTH = 5)
LOG ON 
(NAME = priemka_log,
FILENAME = 'C:\priemka_log.ldf',
SIZE = 5,
MAXSIZE = 50,
FILEGROWTH = 5);
GO
USE priemka
GO
CREATE TABLE abiture (
id_statement int IDENTITY(1,1),
surname varchar(50) NOT NULL,
CHECK (LEN(surname)>2),
first_name varchar(20) NOT NULL,
CHECK (LEN(first_name)>2),
middle_name varchar(30),
CHECK (LEN(middle_name)>2),
is_male bit NOT NULL,
birthday date NOT NULL,
CHECK ((birthday)<CONVERT(date,GETDATE())),
phone varchar(11) NOT NULL,
CHECK (LEN(phone)>5),
address varchar(50) NOT NULL,
CHECK (LEN(address)>2),
training_courses bit NOT NULL,
date_of_application date NOT NULL,
CHECK ((date_of_application)<=CONVERT(date,GETDATE())),
PRIMARY KEY (id_statement)
);
GO
CREATE TABLE benefits (
id_statement int NOT NULL,
name varchar(50) NOT NULL,
CHECK (LEN(name)>2),
document_number varchar(20) NOT NULL,
CHECK (LEN(document_number)>2),
PRIMARY KEY (id_statement),
FOREIGN KEY (id_statement) REFERENCES abiture(id_statement) ON DELETE CASCADE ON UPDATE CASCADE
);
GO
CREATE TABLE pasport (
id_statement int NOT NULL,
series int NOT NULL,
CHECK (LEN(series)=4),
numb int NOT NULL,
CHECK (LEN(numb)=6),
place_of_birth varchar(70) NOT NULL,
CHECK (LEN(place_of_birth)>2),
issued_by varchar(100) NOT NULL,
CHECK (LEN(issued_by)>2),
date_of_issue date NOT NULL,
CHECK ((date_of_issue)<CONVERT(date,GETDATE())),
PRIMARY KEY (id_statement),
FOREIGN KEY (id_statement) REFERENCES abiture(id_statement) ON DELETE CASCADE ON UPDATE CASCADE 
);
GO
CREATE TABLE document (
numb_doc int IDENTITY(1,1),
name varchar(50) NOT NULL,
CHECK (LEN(name)>2),
PRIMARY KEY (numb_doc)
);
GO
CREATE TABLE documents (
id_dc int IDENTITY(1,1),
id_statement int NOT NULL,
numb_doc int NOT NULL,
PRIMARY KEY (id_dc),
FOREIGN KEY (id_statement) REFERENCES abiture(id_statement) ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY (numb_doc) REFERENCES document(numb_doc) ON UPDATE CASCADE
);
GO
CREATE TABLE pasp_rod (
id_statement int NOT NULL,
series int NOT NULL,
CHECK (LEN(series)=4),
numb int NOT NULL,
CHECK (LEN(numb)=6),
surname varchar(30) NOT NULL,
CHECK (LEN(surname)>2),
first_name varchar(20) NOT NULL,
CHECK (LEN(first_name)>2),
middle_name varchar(30),
CHECK (LEN(middle_name)>2),
birthday date NOT NULL,
CHECK ((birthday)<CONVERT(date,GETDATE())),
place_of_birth varchar(70) NOT NULL,
CHECK (LEN(place_of_birth)>2),
PRIMARY KEY (id_statement),
FOREIGN KEY (id_statement) REFERENCES abiture(id_statement)  ON DELETE CASCADE ON UPDATE CASCADE 
);
GO
CREATE TABLE specialty (
id_spec int IDENTITY(1,1),
name_spec varchar(150) NOT NULL,
code_spec varchar(20) NOT NULL,
CHECK (LEN(code_spec)>2),
places int,
CHECK (places>=0),
PRIMARY KEY (id_spec)
);
GO
CREATE TABLE priem (
id_pos int IDENTITY(1,1),
id_statement int NOT NULL,
id_spec int NOT NULL,
priority int NOT NULL,
CHECK (priority>0 and priority<4),
PRIMARY KEY (id_pos),
FOREIGN KEY (id_statement) REFERENCES abiture(id_statement) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (id_spec) REFERENCES specialty(id_spec) ON UPDATE CASCADE 
);
GO
CREATE TABLE atestat (
id_statement int NOT NULL,
numb_at int NOT NULL,
CHECK (numb_at>0),
CHECK (LEN(numb_at)=6),
institution varchar(50) NOT NULL,
CHECK (LEN(institution)>2),
s_otl bit NOT NULL,
avgn decimal(3,2) NOT NULL,
CHECK ((avgn>=2) and (avgn<=5)),
date_of_issue date NOT NULL,
CHECK ((date_of_issue)<CONVERT(date,GETDATE())),
PRIMARY KEY (id_statement),
FOREIGN KEY (id_statement) REFERENCES abiture(id_statement) ON DELETE CASCADE ON UPDATE CASCADE 
);
GO
CREATE TABLE oge (
id_statement INT NOT NULL,
numb_sv INT NOT NULL,
CHECK (numb_sv>0),
avg_oge decimal(3,2) NOT NULL,
CHECK ((avg_oge>=2) and (avg_oge<=5)),
date_of_issue date NOT NULL,
CHECK ((date_of_issue)<CONVERT(date,GETDATE())),
PRIMARY KEY (id_statement),
FOREIGN KEY (id_statement) REFERENCES abiture(id_statement) ON DELETE CASCADE ON UPDATE CASCADE 
);
GO
CREATE TABLE abit_prow(
ID INT IDENTITY(1,1),
name_spec varchar(50),
places INT,
prowed INT,
ne_prowed INT,
proh_ball varchar(20)
);

GO
CREATE PROCEDURE add_doc
	@id_statement int,
	@name varchar(50)
AS
INSERT INTO documents(id_statement,numb_doc) VALUES
(@id_statement,(SELECT TOP 1 numb_doc from document WHERE (name=@name)))
GO
CREATE PROCEDURE add_priem
	@id_statement int,
	@name_spec nvarchar(100),
	@priority int
AS
INSERT INTO priem(id_statement,id_spec,priority) VALUES
(@id_statement,(SELECT TOP 1 id_spec FROM specialty WHERE (name_spec = @name_spec)),@priority)
GO
CREATE PROCEDURE sel_title
	@surname varchar(50)
AS
DECLARE @bum varchar(51)
if @surname is not null
Begin
SET @bum = @surname + N'%'
end else
Begin
SET @bum = N'%'
end
SELECT id_statement AS ID, surname AS [Фамилия], first_name AS [Имя],
middle_name AS [Отчество],birthday AS [День рождения], phone AS [Номер],
address AS [Адрес] FROM abiture
WHERE (surname like @bum)
GO
CREATE PROCEDURE priem_doz
@kot INT
AS
Begin
DECLARE @port table
(
num int IDENTITY,
name_spec varchar(100)
)
INSERT INTO @port SELECT name_spec FROM specialty
SELECT num FROM @port 
WHERE name_spec in (SELECT name_spec AS [TJK] FROM specialty INNER JOIN priem ON
    priem.id_spec = specialty.id_spec WHERE id_statement= @kot)
end
GO
CREATE PROCEDURE sel_avg_atest
@name_spec varchar(100),
@prior bit
AS
DECLARE @nsmp varchar(100)
DECLARE @st_count int  
if (@prior = 1) 
begin
SELECT dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
WHERE (dbo.specialty.name_spec = @name_spec and dbo.priem.priority = 1)
ORDER BY dbo.atestat.avgn DESC
end else
begin
if @name_spec is not null 
begin
SELECT dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
WHERE (dbo.specialty.name_spec = @name_spec)
ORDER BY dbo.atestat.avgn DESC
end else
begin
SELECT dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn
FROM dbo.abiture INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
ORDER BY dbo.atestat.avgn DESC
end
end
GO
CREATE PROCEDURE prowedwie
@name_spec varchar(100),
@prior int,
@count int
AS
BEGIN
DELETE FROM abit_prow
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
		--SELECT @id_s, @sr_nm, @fr_nm, @md_nm, @pub
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
	SELECT ID, sr_nm, fr_nm, md_nm, avgn
	FROM @zapas as [zp]
	ORDER BY (SELECT bb.avg_oge FROM oge as[bb] WHERE (bb.id_statement = zp.ID)) DESC
	OPEN zlp
	DECLARE @old_s INT 
	SET @old_s = 0
	FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	
	WHILE @@FETCH_STATUS = 0 and @count > @real_count
	BEGIN
		DECLARE @zip bit
		SET @zip =(SELECT training_courses FROM dbo.abiture
		WHERE (id_statement = @id_s))
		if @old_s <> @avgn 
		BEGIN
			SET @real_count = @real_count + 1
			INSERT INTO @zpr1 (ID,sr_nm,fr_nm,md_nm,avgn)
			VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @avgn)  			
		END else
		BEGIN
		if @zip = 1
			Begin
				SET @real_count = @real_count + 1
				INSERT INTO @zpr1 (ID,sr_nm,fr_nm,md_nm,avgn)
				VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @avgn)  
			end
		END
		SET @old_s = @avgn
		FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	END
	
	FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	
	WHILE @@FETCH_STATUS = 0 and @count > @real_count
	BEGIN
		SET @zip =(SELECT training_courses FROM dbo.abiture
		WHERE (id_statement = @id_s))
		if @old_s = @avgn 
		BEGIN
		if @zip = 0
			Begin
				SET @real_count = @real_count + 1
				INSERT INTO @zpr1 (ID,sr_nm,fr_nm,md_nm,avgn)
				VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @avgn)  
			end
		END
		SET @old_s = @avgn
		FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	END
CLOSE zlp
DEALLOCATE zlp	
END

SELECT ID as [id_statement],sr_nm as surname,fr_nm as first_name,md_nm as middle_name,avgn FROM @zpr1
END

GO
CREATE PROCEDURE [dbo].[proh_ball]
@name_spec varchar(100),
@prior int,
@count int
AS
BEGIN
DECLARE @not_avg decimal(3,2)
DECLARE @id_s INT
DECLARE @sr_nm varchar(50)
DECLARE @fr_nm varchar(50)
DECLARE @md_nm varchar(50)
DECLARE @avgn decimal(3,2)
DECLARE @cntzt INT
DECLARE @skip bit
SET @skip = 0
if @prior <> 0
Begin
SET @cntzt = (SELECT TOP(@count) COUNT(*) AS CNTZ
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
WHERE (dbo.specialty.name_spec = @name_spec and dbo.priem.priority = @prior))
DECLARE zlp SCROLL CURSOR FOR
SELECT TOP(@count) dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
WHERE (dbo.specialty.name_spec = @name_spec and dbo.priem.priority = @prior)
ORDER BY dbo.atestat.avgn DESC
end
else
begin
SET @cntzt = (SELECT TOP(@count) COUNT(*) AS CNTZ
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
WHERE (dbo.specialty.name_spec = @name_spec))
DECLARE zlp SCROLL CURSOR FOR
SELECT TOP(@count) dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
WHERE (dbo.specialty.name_spec = @name_spec)
ORDER BY dbo.atestat.avgn DESC
end
OPEN zlp
if @count = 0 or @name_spec = '' SELECT 'FALSE' AS APoL
if @cntzt >= @count
Begin
FETCH LAST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
if @cntzt>=@count SET @not_avg = @avgn else SET @not_avg = 0
FETCH LAST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
WHILE @@FETCH_STATUS = 0
BEGIN
	if not(@avgn = @not_avg)
	Begin
		SELECT @avgn AS APoL
		SET @skip = 1 
		BREAK
	end
	FETCH PRIOR FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
END 
END ELSE SELECT 3.00 AS APoL
SELECT 'FALSE' AS APoL
CLOSE zlp
DEALLOCATE zlp
END
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
DECLARE @zpr table
(
ID int,
sr_nm varchar(50),
fr_nm varchar(50),
md_nm varchar(50),
avgn decimal(4,2)
)
DECLARE @ideallocate table
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

if ((SELECT COUNT(*) FROM @zpr)>@count) and (@count <> 0)
BEGIN
	DECLARE zlp SCROLL CURSOR FOR
	SELECT * FROM @zpr
	ORDER BY avgn DESC
	OPEN zlp
	DECLARE @cnt INT = 1;
	FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn

	WHILE (@cnt < @count) and (@@FETCH_STATUS = 0)
	BEGIN
	   FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	   SET @cnt = @cnt + 1;
	END;
	DECLARE @GOD decimal(4,2)
	SET @GOD = @avgn
	FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	if @GOD = @avgn 
	BEGIN
		FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn

		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			if (@avgn = @GOD)
			INSERT INTO @ideallocate (ID,sr_nm,fr_nm,md_nm,avgn)
			VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @avgn)
			FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
		END;
	END;
	CLOSE zlp
	DEALLOCATE zlp
END ELSE 
INSERT INTO @ideallocate (ID,sr_nm,fr_nm,md_nm,avgn)
VALUES (NULL,NULL,NULL,NULL,NULL)
SELECT ID as [id_statement],sr_nm as surname,fr_nm as first_name,md_nm as middle_name,avgn FROM @ideallocate 
END

GO
CREATE PROCEDURE sel_count_kurs
AS
SELECT COUNT(*) FROM abiture
WHERE (training_courses = 1)

GO
CREATE PROCEDURE ne_prowedwie
@name_spec varchar(100),
@prior int,
@count int
AS
BEGIN
if object_id(N'tempdb..#t1',N'U') is not null drop table #t1
CREATE TABLE #t1(
ID int,
sr_nm varchar(50),
fr_nm varchar(50),
md_nm varchar(50),
avgn decimal(4,2)
)
insert #t1
exec prowedwie @name_spec, @prior, @count
if @prior = 0
BEGIN
SELECT dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
FULL JOIN dbo.benefits ON dbo.benefits.id_statement = dbo.abiture.id_statement
WHERE ((dbo.specialty.name_spec = @name_spec) and (abiture.id_statement not in (select twe.ID FROM #t1 as [twe])))
ORDER BY dbo.atestat.avgn DESC	
END ELSE
BEGIN
SELECT dbo.abiture.id_statement, dbo.abiture.surname, dbo.abiture.first_name, dbo.abiture.middle_name, dbo.atestat.avgn
FROM dbo.abiture INNER JOIN dbo.priem ON dbo.abiture.id_statement = dbo.priem.id_statement 
INNER JOIN dbo.specialty ON dbo.priem.id_spec = dbo.specialty.id_spec 
INNER JOIN dbo.atestat ON dbo.abiture.id_statement = dbo.atestat.id_statement
FULL JOIN dbo.benefits ON dbo.benefits.id_statement = dbo.abiture.id_statement
WHERE ((dbo.specialty.name_spec = @name_spec) and dbo.priem.priority = @prior and (abiture.id_statement not in (select twe.ID FROM #t1 as [twe])))
ORDER BY dbo.atestat.avgn DESC	
END
END
GO
CREATE PROCEDURE [dbo].[gen_count_prow]
@name_spec varchar(50),
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
		--SELECT @id_s, @sr_nm, @fr_nm, @md_nm, @pub
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
	SELECT ID, sr_nm, fr_nm, md_nm, avgn
	FROM @zapas as [zp]
	ORDER BY (SELECT bb.avg_oge FROM oge as[bb] WHERE (bb.id_statement = zp.ID)) DESC
	OPEN zlp
	DECLARE @old_s INT 
	SET @old_s = 0
	FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	
	WHILE @@FETCH_STATUS = 0 and @count > @real_count
	BEGIN
		DECLARE @zip bit
		SET @zip =(SELECT training_courses FROM dbo.abiture
		WHERE (id_statement = @id_s))
		if @old_s <> @avgn 
		BEGIN
			SET @real_count = @real_count + 1
			INSERT INTO @zpr1 (ID,sr_nm,fr_nm,md_nm,avgn)
			VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @avgn)  			
		END else
		BEGIN
		if @zip = 1
			Begin
				SET @real_count = @real_count + 1
				INSERT INTO @zpr1 (ID,sr_nm,fr_nm,md_nm,avgn)
				VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @avgn)  
			end
		END
		SET @old_s = @avgn
		FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	END
	
	FETCH FIRST FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	
	WHILE @@FETCH_STATUS = 0 and @count > @real_count
	BEGIN
		SET @zip =(SELECT training_courses FROM dbo.abiture
		WHERE (id_statement = @id_s))
		if @old_s = @avgn 
		BEGIN
		if @zip = 0
			Begin
				SET @real_count = @real_count + 1
				INSERT INTO @zpr1 (ID,sr_nm,fr_nm,md_nm,avgn)
				VALUES (@id_s, @sr_nm, @fr_nm, @md_nm, @avgn)  
			end
		END
		SET @old_s = @avgn
		FETCH NEXT FROM zlp INTO @id_s, @sr_nm, @fr_nm, @md_nm, @avgn
	END
CLOSE zlp
DEALLOCATE zlp	
END

DECLARE @pzkwd bit
if @prior = 1 SET @pzkwd = 1 else SET @pzkwd = 0

DECLARE @bgl INT
if @count<=(SELECT COUNT(*)
FROM dbo.specialty 
INNER JOIN dbo.priem ON dbo.specialty.id_spec = dbo.priem.id_spec 
INNER JOIN dbo.abiture ON dbo.priem.id_statement = dbo.abiture.id_statement
WHERE (dbo.specialty.name_spec = @name_spec and ((@pzkwd = 0)
or (@pzkwd = 1 and not(dbo.priem.priority in (2,3))))))
SET @bgl = (SELECT COUNT(*)
FROM dbo.specialty 
INNER JOIN dbo.priem ON dbo.specialty.id_spec = dbo.priem.id_spec 
INNER JOIN dbo.abiture ON dbo.priem.id_statement = dbo.abiture.id_statement
WHERE (dbo.specialty.name_spec = @name_spec and ((@pzkwd = 0)
or (@pzkwd = 1 and not(dbo.priem.priority in (2,3)))))) - @count else SET @bgl = 0

DECLARE @PHP Table
(zz varchar(20))
INSERT @PHP
EXEC proh_ball @name_spec,@prior,@count
INSERT INTO abit_prow (name_spec, places, prowed, ne_prowed, proh_ball) 
VALUES (@name_spec, @count, (SELECT COUNT(*) FROM @zpr1),@bgl, (SELECT TOP 1 * FROM @PHP)) 
END

GO
CREATE PROCEDURE [dbo].[gen_all_prow]
@prior int
AS
BEGIN
DELETE FROM abit_prow
DECLARE @name_spec varchar(50)
DECLARE @places INT
DECLARE zlpz SCROLL CURSOR FOR
SELECT name_spec,places FROM specialty
OPEN zlpz
FETCH FIRST FROM zlpz INTO @name_spec, @places

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC gen_count_prow @name_spec, @prior, @places 
	FETCH NEXT FROM zlpz INTO @name_spec, @places
END
CLOSE zlpz
DEALLOCATE zlpz
END
GO
CREATE PROCEDURE [dbo].[see_all_table]
AS
BEGIN
SELECT abiture.*,benefits.name,benefits.document_number, pasport.series, pasport.numb,pasport.place_of_birth,pasport.date_of_issue
FROM abiture
FULL JOIN benefits ON benefits.id_statement = abiture.id_statement
INNER JOIN pasport ON pasport.id_statement = abiture.id_statement
END
GO
CREATE PROCEDURE  [dbo].[add_users]
	(
		@username varchar(50),
		@userrole varchar(50),
		@pbable varchar(50)
	)
AS
BEGIN
EXEC('CREATE LOGIN '+@username+' WITH PASSWORD = N'''+@pbable+''', DEFAULT_DATABASE=[priemka], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON '+
'CREATE USER '+@username+' FOR LOGIN '+@username)
EXEC sp_addrolemember @userrole, @username
END
GO
CREATE PROCEDURE  [dbo].[update_users]
	(
		@oldname varchar(50),
		@username varchar(50),
		@userrole varchar(50),
		@pbable varchar(50)
	)
AS
BEGIN
exec dbo.drop_users @oldname
exec dbo.add_users @username, @userrole, @pbable 
END
GO
CREATE PROCEDURE  [dbo].[drop_users]
	(
		@username varchar(50)
	)
AS
BEGIN
exec sp_dropuser @username
exec sp_droplogin @username
END

GO
CREATE VIEW sel_user_deathwing AS
select DISTINCT(convert(char(25),noda1.name))as [Пользователи],
convert(char(25),noda3.name) as [Роль] from sys.database_principals AS noda1 
INNER JOIN sys.database_role_members AS noda2 ON
noda1.principal_id =noda2.member_principal_id
INNER JOIN sys.database_principals AS noda3 ON
noda2.role_principal_id = noda3.principal_id
WHERE (noda1.type_desc = 'SQL_USER')and
(noda1.principal_id between 6 and 16000)

GO
USE [priemka]
GO
CREATE ROLE [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[benefits] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[benefits] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[benefits] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[benefits] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[prowedwie] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[proh_ball] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[add_priem] TO [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[pasport] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[pasport] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[pasport] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[pasport] TO [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[oge] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[oge] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[oge] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[oge] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[sel_title] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[priem_doz] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[sel_count_kurs] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[sel_avg_atest] TO [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[pasp_rod] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[pasp_rod] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[pasp_rod] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[pasp_rod] TO [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[document] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[document] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[document] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[document] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[add_doc] TO [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[documents] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[documents] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[documents] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[documents] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[doomsayer] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[see_all_table] TO [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[abiture] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[abiture] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[abiture] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[abiture] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[ne_prowedwie] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[gen_count_prow] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[gen_all_prow] TO [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[abit_prow] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[abit_prow] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[abit_prow] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[abit_prow] TO [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[atestat] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[atestat] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[atestat] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[atestat] TO [Secretar]
GO
use [priemka]
GO
GRANT EXECUTE ON [dbo].[polu_proh] TO [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[specialty] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[specialty] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[specialty] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[specialty] TO [Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[priem] TO [Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[priem] TO [Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[priem] TO [Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[priem] TO [Secretar]
GO
USE [priemka]
GO
CREATE ROLE [Star_Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[abit_prow] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[abit_prow] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[abit_prow] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[abit_prow] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[document] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[document] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[document] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT UPDATE ON [dbo].[specialty] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT VIEW DEFINITION ON [dbo].[specialty] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT DELETE ON [dbo].[specialty] TO [Star_Secretar]
GO
USE [priemka]
GO
use [priemka]
GO
GRANT INSERT ON [dbo].[specialty] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT SELECT ON [dbo].[specialty] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[specialty] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT UPDATE ON [dbo].[abit_prow] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT ALTER ON [dbo].[document] TO [Star_Secretar]
GO
use [priemka]
GO
GRANT UPDATE ON [dbo].[document] TO [Star_Secretar]
GO
use [priemka]
GO
CREATE ROLE [Admun]
GO
use [priemka]
GO
GRANT INSERT TO [Admun]
GO
use [priemka]
GO
GRANT SELECT TO [Admun]
GO
use [priemka]
GO
GRANT EXECUTE TO [Admun]
GO
use [priemka]
GO
GRANT ALTER TO [Admun]
GO
use [priemka]
GO
GRANT UPDATE TO [Admun]
GO
use [priemka]
GO
GRANT DELETE TO [Admun]
GO
use [priemka]
GO
GRANT CONTROL TO [Admun]
GO
use [priemka]
GO
GRANT ALTER ANY DATABASE AUDIT TO [Admun]
GO
use [priemka]
GO
GRANT ALTER ANY USER TO [Admun]
GO
CREATE LOGIN [secr_user] WITH PASSWORD=N'bubl11', DEFAULT_DATABASE=[priemka], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
USE [priemka]
GO
CREATE USER [secr_user] FOR LOGIN [secr_user]
GO
USE [priemka]
GO
EXEC sp_addrolemember N'Secretar', N'secr_user'
GO
USE [master]
GO
CREATE LOGIN [star_user] WITH PASSWORD=N'doom22', DEFAULT_DATABASE=[priemka], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
USE [priemka]
GO
CREATE USER [star_user] FOR LOGIN [star_user]
GO
USE [priemka]
GO
EXEC sp_addrolemember N'Star_Secretar', N'star_user'
GO
USE [master]
GO
CREATE LOGIN [admn_user] WITH PASSWORD=N'slay33', DEFAULT_DATABASE=[priemka], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
USE [priemka]
GO
CREATE USER [admn_user] FOR LOGIN [admn_user]
GO
USE [priemka]
GO
EXEC sp_addrolemember N'Admun', N'admn_user'
EXEC master..sp_addsrvrolemember @loginame = N'admn_user', @rolename = N'securityadmin'

GO
INSERT INTO abiture(surname,first_name,middle_name,is_male,birthday,phone,address,training_courses,date_of_application) VALUES
('Субботин','Юрий','Степанович','true','09.02.1996',79292406219,'г.Москва, пер.Никитников, д.3 кв.14','true','22.03.2016'),
('Смирнов','Святослав','Романович','true','07.04.1992',79259446959,'г.Москва, Покровский б-р,7 кв.88','false','22.03.2016'),
('Тарасов','Виталий','Сергеевич','true','26.06.1994',79263388721,'г.Москва, ул.Трудовая д.16 кв.69','false','22.03.2016'),
('Белозёрова','Галина','Анатольевна','false','19.07.1995',79263388721,'г.Москва, ул.Маршала Тухачевского 58 кв.9','false','23.03.2016'),
('Чудова','Дарья','Николаевна','false','12.03.1997',79264472111,'г.Химки, ул.Пожарского д.9 кв.195','true','23.03.2016'),
('Ядрихинский','Александр','Титович','true','17.11.1996',79252406219,'г.Москва, ул.Чертановская д.23 кв.9','false','23.03.2016'),
('Лапухова','Юлия','Геннадиевна','false','29.01.1996',79251234567,'г.Москва, ул.Октябрьская д.40 кв.7','false','23.03.2016'),
('Митин','Богдан','Савелиевич','true','13.02.1996',79269863452,'г.Москва, ул.Полковая д.34 кв.127','true','24.03.2016'),
('Неретин','Илья','Андроникович','true','18.12.1994',79295633462,'г.Москва, ул.Сумогатная д.3\8 кв.11','false','24.03.2016'),
('Пережогин','Никита','Олегович','true','11.03.1997',79269851653,'г.Люберцы, ул.Космонавтов 26 кв.71','false','24.03.2016')
GO
INSERT INTO benefits(id_statement,name,document_number) VALUES
(3,'Сирота',141322),
(9,'Инвалид',6565656)
GO
INSERT INTO pasport(id_statement,series,numb,place_of_birth,issued_by,date_of_issue) VALUES
(1,4617,322666,'пер.Никитников, д.3 кв.14','ТП №3 В Гор.Москва ОУФМС России по Москве','11.11.2011'),
(2,4655,777333,'Покровский б-р,7 кв.88','ТП №2 В Гор.Москва ОУФМС России по Москве','12.12.2012'),
(3,4692,230198,'ул.Трудовая д.16 кв.69','ТП №4 В Гор.Москва ОУФМС России по Москве','23.01.2009'),
(4,4677,980022,'ул.Маршала Тухачевского 58 кв.9','ТП №3 В Гор.Москва ОУФМС России по Москве','22.09.2011'),
(5,4614,143728,'ул.Пожарского д.9 кв.195','ТП №1 В Гор.Химки ОУФМС России по МО','29.11.2011'),
(6,1438,123456,'ул.Чертановская д.23 кв.9','ТП №1 В Гор.Москва ОУФМС России по Москве','19.12.2010'),
(7,4621,654321,'ул.Октябрьская д.40 кв.7','ТП №1 В Гор.Люберцы ОУФМС России по МО','23.01.2010'),
(8,4667,928374,'ул.Полковая д.34 кв.127','ТП №1 В Гор.Химки ОУФМС России по МО','17.08.2009'),
(9,4677,109822,'ул.Сумогатная д.3\8 кв.11','ТП №1 В Гор.Москва ОУФМС России по Москве','12.11.2015'),
(10,4611,148800,'Москва ул.Космонавтов 26 кв.71','ТП №1 В Гор.Люберцы ОУФМС России по МО','29.03.2011')
GO
INSERT INTO document(name) VALUES
('Заявление'), 
('Аттестат'),
('Паспорт абитуриента'),
('Паспорт одного из родителей'),
('Медицинская справка 086/у'),
('Ксерокопия полиса медицинского страхования'),
('Выписка результатов ГИА\ЕГЭ')
GO
INSERT INTO documents(id_statement,numb_doc) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),
(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),
(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),
(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),
(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),
(6,1),(6,2),(6,3),(6,4),(6,5),(6,6),
(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),
(8,1),(8,2),(8,3),(8,4),(8,5),(8,6),
(9,1),(9,2),(9,3),(9,4),(9,5),(9,6),(9,7),
(10,1),(10,2),(10,3),(10,4),(10,5),(10,6)
GO
INSERT INTO pasp_rod(id_statement,series,numb,surname,first_name,middle_name,birthday,place_of_birth) VALUES
(1,4611,194307,'Алексеев','Ахмет','Кириллович','21.05.1965','г.Северодвинск, ул.Загородная д.25, кв.134'),
(2,4612,246827,'Осипов','Георгий','Богданович','14.03.1968','г.Москва, Покровский б-р д.7 кв.88'),
(3,4613,315075,'Дмитриев','Роман','Павлович','17.02.1969','г.Москва, ул.Айвазовского д.93 кв.119'),
(4,4614,614749,'Пономарёва','Ангелина','Егоровна','10.06.1972','г.Озера, ул.Бакунинская д.53, кв.9'),
(5,4615,195889,'Антонов','Демид','Максимович','05.10.1976','г.Москва, ул.Барклая д.40, кв.24'),
(6,4616,137431,'Тарский','Силантий','Вениаминович','23.06.1969','г.Москва, ул.Журавлёва д.5 кв.4'),
(7,4617,337121,'Быков','Валентин','Николаевич','15.01.1974','г.Москва, ул.Глинки д.8 кв.2'),
(8,4618,384997,'Жуков','Андоим','Павлович','12.02.1977','г.Москва, ул.Бабаевская д.38 кв.87'),
(9,4618,511364,'Мартынова','Клара','Ильинична','27.07.1980','г.Москва, ул.Базанова д.76 кв.94'),
(10,4619,204455,'Тюрина','Кларисса','Федоровна','11.09.1971','г.Химки, ул. Басовская д.1 кв.16')
GO
INSERT INTO specialty(name_spec,code_spec,places) VALUES 
('Компьютерные сети','09.02.02',30),
('Программирование в компьютерных системах','09.02.03',40),
('Прикладная информатика','09.02.05',4),
('Информационная безопасность автоматизированных систем','10.02.03',25),
('Земельно-имущественные отношения','21.02.01',30),
('Реклама','42.02.01',20)
GO
INSERT INTO priem(id_statement,id_spec,priority) VALUES
(1,2,1),(1,4,2),(1,3,3),
(2,6,1),(2,5,2),(2,4,3),
(3,2,1),(3,3,2),(3,4,3),
(4,1,1),(4,2,2),(4,3,3),
(5,6,1),(5,5,2),(5,4,3),
(6,2,1),(6,4,2),(6,6,3),
(7,1,1),(7,3,2),(7,5,3),
(8,4,1),(8,3,2),(8,5,3),
(9,3,1),(9,6,2),(9,1,3),
(10,4,1),(10,3,2),(10,2,3)
GO
INSERT INTO atestat(id_statement,numb_at,institution,s_otl,avgn,date_of_issue) VALUES
(1,124257,'Гимназия «Классика»','false',4,'23.11.2015'),
(2,235251,'Гимназия «Утро»','false',3,'25.05.2015'),
(3,235252,'Гимназия «Ясенево»','true',5,'21.05.2015'),
(4,876457,'Гимназия «Доверие»','true',5,'03.06.2015'),
(5,952421,'Гимназия «Утро»','false',4.5,'25.05.2015'),
(6,754782,'Гимназия №1409','false',3.5,'28.05.2015'),
(7,182653,'Гимназия №1505','false',4,'26.05.2015'),
(8,322666,'Гимназия №1515','false',3.5,'29.05.2015'),
(9,777666,'Гимназия «Алфавит»','false',3,'28.05.2015'),
(10,848521,'Гимназия №1781','false',3,'06.06.2015')
GO
INSERT INTO oge(id_statement,numb_sv,avg_oge,date_of_issue) VALUES
(1,246262,4,'15.06.2015'),
(2,246262,3,'15.06.2015'),
(3,346543,3,'11.06.2015'),
(4,246262,5,'15.06.2015'),
(5,246262,5,'11.06.2015'),
(6,246262,5,'15.06.2015'),
(7,246262,5,'15.06.2015'),
(8,246262,5,'15.06.2015'),
(9,246262,5,'15.06.2015'),
(10,674712,5,'17.06.2015')
GO