CREATE TABLE priem (
id_pos int IDENTITY(1,1),
id_stud int NOT NULL,
CHECK (id_stud>0),
id_spec int NOT NULL,
priority int NOT NULL,
CHECK (priority>0 and priority<100),
PRIMARY KEY (id_pos),
FOREIGN KEY (id_stud) REFERENCES students(id_stud),
FOREIGN KEY (id_spec) REFERENCES specialty(id_spec)  
);