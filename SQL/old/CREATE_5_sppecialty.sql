CREATE TABLE specialty (
id_spec int IDENTITY(1,1),
name_spec varchar(30) NOT NULL,
kod_spec int NOT NULL,
CHECK (kod_spec>0),
PRIMARY KEY (id_spec)
);