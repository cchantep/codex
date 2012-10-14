INSERT INTO logiciel_tbl(nom_logiciel) VALUES ('Postgres');
INSERT INTO logiciel_tbl(nom_logiciel) VALUES ('Emacs');
INSERT INTO logiciel_tbl(nom_logiciel) VALUES ('JDK');

INSERT INTO salle_tbl(no_salle, nb_place, machine) VALUES (205, 3, false);
INSERT INTO salle_tbl(no_salle, nb_place, machine) VALUES (217, 2, true);
INSERT INTO salle_tbl(no_salle, nb_place, machine) VALUES (101, 1, true);

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
	VALUES ('Mardi', 11, 205, true, 'BD', 'Licence');
INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES ('Mercredi', 10, 217, true, 'BD', 'Licence');
INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES ('Mercredi', 11, 217, true, 'BD', 'Licence');
INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES ('Lundi', 14, 205, false, 'Objets', 'Licence');
INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES ('Lundi', 15, 205, false, 'Objets', 'Licence');
INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
	VALUES ('Mardi', 10, 205, false, 'Logique', 'Maitrise');
--deja reservee(l26):INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES ('Mardi', 11, 205, false, 'Logique', 'Maitrise');

-- cursus et matiere no existante rompt fk
--INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES ('Jeudi', 14, 205, false, 'Algorithmique', 'DEUG Psycho');
--INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES ('Jeudi', 15, 205, false, 'Algorithmique', 'DEUG Psycho');
--INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES ('Jeudi', 16, 205, false, 'Algorithmique', 'DEUG Psycho');
--INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES ('Jeudi', 17, 205, false, 'Algorithmique', 'DEUG Psycho');
--INSERT INTO edt_tbl(jour, heure_debut, no_salle, tp, nom_matiere, nom_cursus)
--	VALUES ('Jeudi', 18, 205, false, 'Algorithmique', 'DEUG Psycho');

-- Modification et suppressions

BEGIN;
UPDATE cursus_tbl SET nom_cursus='Licence math' WHERE nom_cursus='Licence';

DELETE FROM cursus_tbl WHERE nom_cursus='Licence';

DELETE FROM salle_tbl
WHERE NOT EXISTS
(SELECT no_salle FROM edt_tbl 
WHERE edt_tbl.no_salle=salle_tbl.no_salle);

DELETE FROM matiere_tbl
WHERE NOT EXISTS
(SELECT NULL FROM edt_tbl
WHERE edt_tbl.nom_cursus=matiere_tbl.nom_cursus
  AND edt_tbl.nom_matiere=matiere_tbl.nom_matiere);

DELETE FROM edt_tbl
WHERE (nom_matiere, nom_cursus) IN
(SELECT nom_matiere, nom_cursus
FROM logiciel_matiere_tp_tbl
WHERE nom_logiciel='Postgres');

