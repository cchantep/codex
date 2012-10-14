SELECT nom_matiere FROM note_tbl 
WHERE ine = (SELECT ine FROM etudiant_tbl WHERE nom='Rambo');

SELECT COUNT(*) FROM etudiant_tbl WHERE nom_cursus='Licence';

SELECT COUNT(DISTINCT nom_matiere) FROM note_tbl;

SELECT ine, nom, prenom, nom_cursus FROM etudiant_tbl ORDER BY nom, prenom;

SELECT nom, note
FROM etudiant_tbl 
NATURAL JOIN note_tbl
WHERE nom_matiere='BD'
ORDER BY note DESC;

SELECT AVG(note_tbl.note) AS moyenne_systeme_licence 
FROM note_tbl
NATURAL JOIN etudiant_tbl
WHERE note_tbl.nom_matiere='Systeme'
  AND etudiant_tbl.nom_cursus='Licence';

SELECT nom FROM etudiant_tbl
WHERE ine IN
(SELECT DISTINCT ine FROM note_tbl
WHERE note > 10);

---
SELECT nom
FROM (SELECT etudiant_tbl.nom, MIN(note) AS note_min
FROM etudiant_tbl
NATURAL JOIN note_tbl
GROUP BY etudiant_tbl.ine, etudiant_tbl.nom) AS subs
WHERE subs.note_min >= 10;

SELECT nom
FROM etudiant_tbl
WHERE NOT EXISTS 
(SELECT ine FROM note_tbl 
WHERE note < 10 AND note_tbl.ine=etudiant_tbl.ine);
---

SELECT note, ine, nom_matiere, nom
FROM note_tbl
NATURAL JOIN etudiant_tbl
WHERE note = (SELECT MAX(note)
FROM note_tbl);

SELECT nom, prenom
FROM etudiant_tbl
NATURAL JOIN note_tbl
WHERE nom_matiere='BD'
  AND nom_cursus='Licence'
  AND note >
(SELECT AVG(note) FROM note_tbl
NATURAL JOIN etudiant_tbl
WHERE nom_matiere='BD'
  AND etudiant_tbl.nom_cursus='Licence');


SELECT nom, prenom
FROM etudiant_tbl
NATURAL JOIN (SELECT DISTINCT ine FROM note_tbl
WHERE note < 10) AS subs
NATURAL JOIN note_tbl
WHERE note_tbl.nom_matiere='BD'
  AND note_tbl.note >= 10;

SELECT nom_matiere, nom_cursus
FROM matiere_tbl
WHERE (nom_matiere, nom_cursus) NOT IN
(SELECT nom_matiere, nom_cursus
FROM note_view 
WHERE note < 10);

SELECT nom_matiere, nom_cursus
FROM (SELECT COUNT(*) AS c, nom_matiere, nom_cursus FROM note_view
WHERE note >= 10
GROUP BY nom_matiere, nom_cursus) AS subs
WHERE subs.c >= 2;

