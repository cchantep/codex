-- (1) ---

SELECT jour, 
  heure_debut,
  heure_debut+1 AS heure_fin,
  nom_matiere,
  no_salle,
  tp
FROM edt_tbl
ORDER BY jour ASC, heure_debut ASC;

-- (2) ---

SELECT TO_CHAR(AVG(note), '99.99') AS moyenne, 
  nom_cursus, 
  nom_matiere
FROM note_view
GROUP BY nom_cursus, nom_matiere;

-- (3) ---

SELECT TO_CHAR(AVG(note), '99.99') AS moyenne, 
  nom_matiere
FROM note_view
WHERE nom_cursus = 'Licence'
GROUP BY nom_matiere;

-- (4) ---

SELECT nom_cursus
FROM (
SELECT COUNT(ine) AS nb_etudiant, nom_cursus
FROM etudiant_tbl
GROUP BY nom_cursus
) AS etudiant_sel
WHERE nb_etudiant >= 2;

-- (5) ---

SELECT no_salle, nb_utilisation
FROM (
SELECT no_salle, COUNT(no_salle) AS nb_utilisation
FROM edt_tbl
GROUP BY no_salle
) AS utilisation_sel
ORDER BY nb_utilisation;

-- (6) ---

SELECT ine
FROM note_view
GROUP BY ine
HAVING AVG(note) > 10;

-- (7) ---

SELECT nom, prenom
FROM etudiant_tbl
WHERE nom_cursus 
IN (SELECT nom_cursus
FROM cursus_tbl WHERE nom_cursus 
NOT IN (SELECT nom_cursus FROM edt_tbl WHERE no_salle = 217));

-- (8) ---

SELECT etudiant_tbl.nom,
  etudiant_tbl.prenom,
  AVG(note) AS moyenne
FROM note_view
NATURAL JOIN etudiant_tbl
WHERE nom_cursus='Licence'
GROUP BY nom, prenom;

-- (9) ---

SELECT no_salle
FROM salle_tbl
WHERE salle_tbl.machine
  AND no_salle IN

SELECT no_salle FROM salle_tbl
WHERE NOT EXISTS
(SELECT nom_logiciel
FROM logiciel_matiere_tp_tbl
WHERE nom_cursus='Maitrise'
  AND nom_matiere='BD'
  AND nom_logiciel NOT IN
(SELECT nom_logiciel FROM logiciel_salle_tbl
WHERE salle_tbl.no_salle=logiciel_salle_tbl.no_salle))
  AND nb_place >= 
  (SELECT COUNT(ine) FROM etudiant_tbl
   WHERE nom_cursus='Matiere');
