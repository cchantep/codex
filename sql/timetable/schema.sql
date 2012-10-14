CREATE TABLE salle_tbl (
	no_salle INT4 NOT NULL,
	nb_place INT4 NOT NULL,
	machine BOOLEAN NOT NULL
);

ALTER TABLE salle_tbl ADD CONSTRAINT salle_pk
	PRIMARY KEY(no_salle);

CREATE TABLE logiciel_tbl (
	nom_logiciel VARCHAR(35) NOT NULL,
	description TEXT
);

ALTER TABLE logiciel_tbl 
	ADD CONSTRAINT logiciel_pk PRIMARY KEY(nom_logiciel);

CREATE TABLE logiciel_salle_tbl (
	no_salle INT4 NOT NULL,
	nom_logiciel VARCHAR(35) NOT NULL
);

ALTER TABLE logiciel_salle_tbl ADD CONSTRAINT logiciel_salle_pk
	PRIMARY KEY(no_salle, nom_logiciel);

ALTER TABLE logiciel_salle_tbl ADD CONSTRAINT logiciel_salle_fk
	FOREIGN KEY(no_salle) REFERENCES salle_tbl(no_salle);

ALTER TABLE logiciel_salle_tbl ADD CONSTRAINT salle_logiciel_fk
	FOREIGN KEY(nom_logiciel) REFERENCES logiciel_tbl(nom_logiciel);

CREATE TABLE edt_tbl (
	heure_debut INT4 NOT NULL,
	jour VARCHAR(25) NOT NULL,
	no_salle INT4 NOT NULL,
	tp BOOLEAN NOT NULL,
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
	
