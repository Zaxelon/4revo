CREATE TABLE documents (
id_stud int,
s_statement bit NOT NULL,
s_attestat bit NOT NULL,
s_pasport bit NOT NULL,
s_pas_rod bit NOT NULL,
s_photo bit NOT NULL,
s_sprav_086u bit NOT NULL,
s_med_strah bit NOT NULL,
s_ege bit NOT NULL,
s_lgota bit NOT NULL,
PRIMARY KEY (id_stud),
FOREIGN KEY (id_stud) REFERENCES students(id_stud)  
);