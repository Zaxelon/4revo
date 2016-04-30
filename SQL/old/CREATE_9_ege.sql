CREATE TABLE ege (
id_ege int IDENTITY(1,1),
id_stud int NOT NULL,
CHECK (id_stud>0),
numb_sv int NOT NULL,
CHECK (numb_sv>0),
date_of_issue date NOT NULL,
CHECK ((date_of_issue)<CONVERT(date,GETDATE())),
PRIMARY KEY (id_ege),
FOREIGN KEY (id_stud) REFERENCES students(id_stud) 
);