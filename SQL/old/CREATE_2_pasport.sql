CREATE TABLE pasport (
id_stud int,
series varchar(4) NOT NULL,
CHECK (LEN(series)=4),
numb int NOT NULL,
CHECK (LEN(numb)=6),
place_of_birth varchar(25) NOT NULL,
CHECK (LEN(place_of_birth)>2),
citizenship varchar(25) NOT NULL,
CHECK (LEN(citizenship)>2),
issued_by varchar(25) NOT NULL,
CHECK (LEN(issued_by)>2),
date_of_issue date NOT NULL,
CHECK ((date_of_issue)<CONVERT(date,GETDATE())),
PRIMARY KEY (id_stud),
FOREIGN KEY (id_stud) REFERENCES students(id_stud)  
);