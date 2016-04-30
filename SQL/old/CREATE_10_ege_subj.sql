CREATE TABLE ege_subj (
id_subj int IDENTITY(1,1),
id_ege int NOT NULL,
CHECK (id_ege>0),
subj varchar(20) NOT NULL,
CHECK (LEN(subj)>2), 
mark int NOT NULL,
CHECK (mark > 1 and mark < 6),
PRIMARY KEY (id_subj),
FOREIGN KEY (id_ege) REFERENCES ege(id_ege) 
);