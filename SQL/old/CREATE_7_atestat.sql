CREATE TABLE atestat (
id_at int IDENTITY(1,1),
id_stud int NOT NULL,
CHECK (id_stud>0),
numb_at int NOT NULL,
CHECK (numb_at>0),
institution varchar(20) NOT NULL,
CHECK (LEN(institution)>2),
date_of_issue date NOT NULL,
CHECK ((date_of_issue)<CONVERT(date,GETDATE())),
PRIMARY KEY (id_at),
FOREIGN KEY (id_stud) REFERENCES students(id_stud) 
);