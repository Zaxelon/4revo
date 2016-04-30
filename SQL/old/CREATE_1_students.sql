CREATE TABLE students (
id_stud int IDENTITY(1,1),
surname varchar(30) NOT NULL,
CHECK (LEN(surname)>2),
first_name varchar(20) NOT NULL,
CHECK (LEN(first_name)>2),
middle_name varchar(30),
CHECK (LEN(middle_name)>2),
is_male bit NOT NULL,
birthday date NOT NULL,
CHECK ((birthday)<CONVERT(date,GETDATE())),
phone varchar(11) NOT NULL,
benefit varchar(20),
training_courses bit NOT NULL,
date_of_application date NOT NULL,
CHECK ((date_of_application)<=CONVERT(date,GETDATE())),
PRIMARY KEY (id_stud)
);