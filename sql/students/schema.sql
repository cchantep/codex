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

CREATE TABLE matiere_tbl (
	nom_matiere VARCHAR(35) NOT NULL,
	nom_cursus VARCHAR(35) NOT NULL
);

CREATE TABLE note_tbl (
	nom_matiere VARCHAR(35) NOT NULL,
	ine VARCHAR(35) NOT NULL,
	note INT4 NOT NULL
);

CREATE VIEW note_view 
AS (SELECT note_tbl.nom_matiere, 
  note_tbl.ine, 
  note_tbl.note,
  etudiant_tbl.nom_cursus
FROM note_tbl
NATURAL JOIN etudiant_tbl);
