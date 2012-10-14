--- cursus_tbl
ALTER TABLE cursus_tbl ADD CONSTRAINT cursus_pk PRIMARY KEY(nom_cursus);

--- etudiant_tbl
ALTER TABLE etudiant_tbl ADD CONSTRAINT etudiant_pk PRIMARY KEY(ine);

ALTER TABLE etudiant_tbl ADD CONSTRAINT etudiant_cursus_fk
	FOREIGN KEY(nom_cursus) REFERENCES cursus_tbl(nom_cursus);

--- matiere_tbl
ALTER TABLE matiere_tbl ADD CONSTRAINT matiere_pk 
	PRIMARY KEY(nom_matiere, nom_cursus);

ALTER TABLE matiere_tbl ADD CONSTRAINT matiere_cursus_fk
	FOREIGN KEY(nom_cursus) REFERENCES cursus_tbl(nom_cursus);

--- note_tbl
ALTER TABLE note_tbl ADD CONSTRAINT note_pk PRIMARY KEY(nom_matiere, ine);

ALTER TABLE note_tbl ADD CONSTRAINT note_etudiant_fk
	FOREIGN KEY(ine) REFERENCES etudiant_tbl(ine)
	ON DELETE CASCADE;

--ALTER TABLE note_tbl ADD CONSTRAINT note_matiere_fk 
--	FOREIGN KEY(nom_matiere) REFERENCES matiere_tbl(nom_matiere);

ALTER TABLE note_tbl ADD CONSTRAINT note_chk CHECK(note >= 0 AND note <= 20);