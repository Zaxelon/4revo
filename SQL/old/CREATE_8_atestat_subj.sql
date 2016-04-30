CREATE TABLE atestat_subj (
id_subj int IDENTITY(1,1),
id_at int NOT NULL,
CHECK (id_at>0),
subj varchar(20) NOT NULL,
CHECK (LEN(subj)>2), 
mark int NOT NULL,
CHECK (mark > 1 and mark < 6),
PRIMARY KEY (id_subj),
FOREIGN KEY (id_at) REFERENCES atestat(id_at) 
);