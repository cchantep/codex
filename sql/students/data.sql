--- cursus_tbl
INSERT INTO cursus_tbl (nom_cursus, nom_responsable)
VALUES ('Licence', 'S. Loiseau');

INSERT INTO cursus_tbl (nom_cursus, nom_responsable)
VALUES ('Maitrise', 'F. Saubion');

--- matiere_tbl
INSERT INTO matiere_tbl(nom_matiere, nom_cursus)
VALUES ('BD', 'Licence');

INSERT INTO matiere_tbl(nom_matiere, nom_cursus)
VALUES ('Systeme', 'Licence');

INSERT INTO matiere_tbl(nom_matiere, nom_cursus)
VALUES ('Objets', 'Licence');

INSERT INTO matiere_tbl(nom_matiere, nom_cursus)
VALUES ('BD', 'Maitrise');

INSERT INTO matiere_tbl(nom_matiere, nom_cursus)
VALUES ('Logique', 'Maitrise');

--- etudiant_tbl
INSERT INTO etudiant_tbl (ine, nom, prenom, nom_cursus)
VALUES ('23', 'Accroc', 'Arthur', 'Licence');

INSERT INTO etudiant_tbl (ine, nom, prenom, nom_cursus)
VALUES ('32', 'Rambo', 'John', 'Maitrise');

INSERT INTO etudiant_tbl (ine, nom, prenom, nom_cursus)
VALUES ('28', 'Ingalls', 'Laura', 'Licence');

--- exam_tbl

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('BD', '23', 14);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('Systeme', '23', 10);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('Objets', '23', 12);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('BD', '32', 10);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('Logique', '32', 3);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('BD', '28', 3);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('Systeme', '28', 14);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('Objets', '28', 12);
