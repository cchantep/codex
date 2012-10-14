CREATE TABLE cursus_tbl (
	nom_cursus VARCHAR(35) NOT NULL,
	nom_responsable VARCHAR(152) NOT NULL
);

CREATE TABLE etudiant_tbl (
	ine VARCHAR(35) NOT NULL,
	nom VARCHAR(35) NOT NULL,
	prenom VARCHAR(35) NOT NULL,
	nom_cursus VARCHAR(35) NOT NULL
);

CREATE SEQUENCE etudiant_ine_sq INCREMENT BY 1 START WITH 2005;

CREATE TABLE matiere_tbl (
	nom_matiere VARCHAR(35) NOT NULL,
	nom_cursus VARCHAR(35) NOT NULL
);

CREATE TABLE note_tbl (
	nom_matiere VARCHAR(35) NOT NULL,
	ine VARCHAR(35) NOT NULL,
	note INTEGER NOT NULL
);

CREATE VIEW note_view 
AS (SELECT note_tbl.nom_matiere, 
  note_tbl.ine, 
  note_tbl.note,
  etudiant_tbl.nom_cursus
FROM note_tbl, etudiant_tbl
WHERE note_tbl.ine=etudiant_tbl.ine);

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

---------

CREATE TABLE salle_tbl (
	no_salle INTEGER NOT NULL,
	nb_place INTEGER NOT NULL,
	machine CHAR(1) NOT NULL
);

ALTER TABLE salle_tbl ADD CONSTRAINT salle_pk
	PRIMARY KEY(no_salle);

CREATE TABLE logiciel_tbl (
	nom_logiciel VARCHAR(35) NOT NULL,
	description LONG VARCHAR
);

ALTER TABLE logiciel_tbl 
	ADD CONSTRAINT logiciel_pk PRIMARY KEY(nom_logiciel);

CREATE TABLE logiciel_salle_tbl (
	no_salle INTEGER NOT NULL,
	nom_logiciel VARCHAR(35) NOT NULL
);

ALTER TABLE logiciel_salle_tbl ADD CONSTRAINT logiciel_salle_pk
	PRIMARY KEY(no_salle, nom_logiciel);

ALTER TABLE logiciel_salle_tbl ADD CONSTRAINT logiciel_salle_fk
	FOREIGN KEY(no_salle) REFERENCES salle_tbl(no_salle);

ALTER TABLE logiciel_salle_tbl ADD CONSTRAINT salle_logiciel_fk
	FOREIGN KEY(nom_logiciel) REFERENCES logiciel_tbl(nom_logiciel);

CREATE TABLE edt_tbl (
	heure_debut INTEGER NOT NULL,
	jour INTEGER NOT NULL,
	no_salle INTEGER NOT NULL,
	tp CHAR(1) NOT NULL,
	nom_matiere VARCHAR(35) NOT NULL,
	nom_cursus VARCHAR(35)
);

ALTER TABLE edt_tbl ADD CONSTRAINT edt_pk 
	PRIMARY KEY (jour, heure_debut, no_salle);

ALTER TABLE edt_tbl ADD CONSTRAINT edt_heure_debut_chk
	CHECK(heure_debut >= 8 AND heure_debut < 19);

ALTER TABLE edt_tbl ADD CONSTRAINT edt_salle_fk
	FOREIGN KEY (no_salle) REFERENCES salle_tbl(no_salle);

ALTER TABLE edt_tbl ADD CONSTRAINT edt_matiere_fk
	FOREIGN KEY (nom_matiere, nom_cursus)
	REFERENCES matiere_tbl(nom_matiere, nom_cursus);

--CREATE FUNCTION chk_salle_machine_proc()
--RETURNS TRIGGER AS '
--BEGIN
--	IF (NEW.tp AND (SELECT NOT machine FROM salle_tbl WHERE no_salle = NEW.no_salle)) THEN
--		RAISE EXCEPTION ''Salle pas machine'';
--	END IF;
--END;
--' LANGUAGE plpgsql;

--CREATE TRIGGER pre_insert_edt_tg
--BEFORE INSERT INTO edt_tbl
--FOR EACH ROW EXECUTE PROCEDURE chk_salle_machine_proc();

--CREATE TRIGGER pre_insert_edt_tg
--BEFORE UPDATE ON edt_tbl
--FOR EACH ROW EXECUTE PROCEDURE chk_salle_machine_proc();

CREATE TABLE logiciel_matiere_tp_tbl (
	nom_cursus VARCHAR(35) NOT NULL,
	nom_matiere VARCHAR(35) NOT NULL,
	nom_logiciel VARCHAR(35) NOT NULL
);

ALTER TABLE logiciel_matiere_tp_tbl 
	ADD CONSTRAINT logiciel_matiere_tp_pk 
	PRIMARY KEY(nom_cursus, nom_matiere, nom_logiciel);

ALTER TABLE logiciel_matiere_tp_tbl
	ADD CONSTRAINT logiciel_matiere_fk
	FOREIGN KEY(nom_cursus, nom_matiere)
	REFERENCES matiere_tbl(nom_cursus, nom_matiere);

ALTER TABLE logiciel_matiere_tp_tbl
	ADD CONSTRAINT matiere_logiciel_fk FOREIGN KEY(nom_logiciel)
	REFERENCES logiciel_tbl(nom_logiciel);
	
--- views ---

CREATE VIEW EtudiantLicence 
AS (SELECT ine, nom, prenom
FROM etudiant_tbl WHERE nom_cursus='Licence');

CREATE VIEW NoteLicence
AS (SELECT note_tbl.ine, 
  note_tbl.nom_matiere, 
  note_tbl.note
FROM note_tbl, etudiant_tbl
WHERE note_tbl.ine=etudiant_tbl.ine
  AND etudiant_tbl.nom_cursus='Licence');
