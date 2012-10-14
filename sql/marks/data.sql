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
VALUES (etudiant_ine_sq.nextval, 'Accroc', 'Arthur', 'Licence');

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('BD', etudiant_ine_sq.currval, 14);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('Systeme', etudiant_ine_sq.currval, 10);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('Objets', etudiant_ine_sq.currval, 12);

--

INSERT INTO etudiant_tbl (ine, nom, prenom, nom_cursus)
VALUES (etudiant_ine_sq.nextval, 'Rambo', 'John', 'Maitrise');

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('BD', etudiant_ine_sq.currval, 10);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('Logique', etudiant_ine_sq.currval, 3);

--

INSERT INTO etudiant_tbl (ine, nom, prenom, nom_cursus)
VALUES (etudiant_ine_sq.nextval, 'Ingalls', 'Laura', 'Licence');

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('BD', etudiant_ine_sq.currval, 3);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('Systeme', etudiant_ine_sq.currval, 14);

INSERT INTO note_tbl (nom_matiere, ine, note) 
VALUES ('Objets', etudiant_ine_sq.currval, 12);

--- here ---

INSERT INTO logiciel_tbl(nom_logiciel) VALUES ('Postgres');
INSERT INTO logiciel_tbl(nom_logiciel) VALUES ('Emacs');
INSERT INTO logiciel_tbl(nom_logiciel) VALUES ('JDK');

INSERT INTO salle_tbl(no_salle, nb_place, machine) VALUES (205, 3, 'f');
INSERT INTO salle_tbl(no_salle, nb_place, machine) VALUES (217, 2, 't');
INSERT INTO salle_tbl(no_salle, nb_place, machine) VALUES (101, 1, 't');

INSERT INTO logiciel_salle_tbl(no_salle, nom_logiciel) VALUES (217, 'Postgres');
INSERT INTO logiciel_salle_tbl(no_salle, nom_logiciel) VALUES (217, 'Emacs');
INSERT INTO logiciel_salle_tbl(no_salle, nom_logiciel) VALUES (217, 'JDK');
--
INSERT INTO logiciel_salle_tbl(no_salle, nom_logiciel) VALUES (101, 'Postgres');

INSERT INTO logiciel_matiere_tp_tbl(nom_cursus, nom_matiere, nom_logiciel)
	VALUES('Licence', 'BD', 'Postgres');
INSERT INTO logiciel_matiere_tp_tbl(nom_cursus, nom_matiere, nom_logiciel)
	VALUES('Licence', 'BD', 'Emacs');
INSERT INTO logiciel_matiere_tp_tbl(nom_cursus, nom_matiere, nom_logiciel)
	VALUES('Maitrise', 'BD', 'Postgres');
INSERT INTO logiciel_matiere_tp_tbl(nom_cursus, nom_matiere, nom_logiciel)
	VALUES('Maitrise', 'BD', 'Emacs');
INSERT INTO logiciel_matiere_tp_tbl(nom_cursus, nom_matiere, nom_logiciel)
	VALUES('Licence', 'Objets', 'JDK');

INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES (2, 11, 205, 't', 'BD', 'Licence');
INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES (3, 10, 217, 't', 'BD', 'Licence');
INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES (3, 11, 217, 't', 'BD', 'Licence');
INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES (1, 14, 205, 'f', 'Objets', 'Licence');
INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES (1, 15, 205, 'f', 'Objets', 'Licence');
INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES (2, 10, 205, 'f', 'Logique', 'Maitrise');
--deja reservee(l26):INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES (2, 11, 205, 'f', 'Logique', 'Maitrise');

-- cursus et matiere no existante rompt fk
--INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES (4, 14, 205, 'f', 'Algorithmique', 'DEUG Psycho');
--INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES (4, 15, 205, 'f', 'Algorithmique', 'DEUG Psycho');
--INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES (4, 16, 205, 'f', 'Algorithmique', 'DEUG Psycho');
--INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES (4, 17, 205, 'f', 'Algorithmique', 'DEUG Psycho');
--INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES (4, 18, 205, 'f', 'Algorithmique', 'DEUG Psycho');


--insert NULL in underlying table:INSERT INTO EtudiantLicence (ine, nom, prenom) VALUES (etudiant_ine_sq.nextval, 'Tutu', 'Tata');

