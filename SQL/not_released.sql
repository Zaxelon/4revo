GO
CREATE TABLE subjct (
id_sabj int IDENTITY(1,1),
name_sabj varchar(50),
CHECK (LEN(name_sabj)>2),
PRIMARY KEY (id_sabj)
);
GO
CREATE TABLE atestat_subj (
id_subji int IDENTITY(1,1),
id_statement int NOT NULL,
id_sabj int NOT NULL,
mark int NOT NULL,
CHECK (mark >= 2 and mark <= 5),
PRIMARY KEY (id_subji),
FOREIGN KEY (id_statement) REFERENCES atestat(id_statement) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (id_sabj) REFERENCES subjct(id_sabj),
);
GO
INSERT INTO subjct(name_sabj) VALUES
('Математика')
GO
INSERT INTO atestat_subj(id_statement,id_sabj,mark) VALUES
(1,1,3),(2,1,3),(3,1,5),(4,1,5),(5,1,5),(6,1,4),(7,1,4),(8,1,3),(9,1,3),(10,1,3)
GO