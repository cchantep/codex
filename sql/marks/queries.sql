--( 1 )--
SELECT DECODE (jour,1, 'Lund', 
               2, 'Ma', 
               3, 'Merc', 
               4, 'Jeud',                     
                    'Vend') AS jour_label,
  heure_debut,
  heure_debut+1 AS heure_fin,
  nom_matiere,
  no_salle,
  DECODE (tp, 't', 'TP', 
		'Cours') AS is_tp
FROM edt_tbl
WHERE nom_cursus='Licence'
ORDER BY jour ASC, heure_debut ASC;

--( 2 )--

SELECT COUNT(heure_debut)
FROM edt_tbl
WHERE nom_cursus='Licence'
  AND jour=3;

--( 3 )--

SELECT nom, prenom
FROM etudiant_tbl
WHERE nom_cursus='Licence'
UNION
SELECT nometu AS nom, 
  prenometu AS prenom
FROM jousse.etudiant
WHERE nomcursus='Licence';

--( 4 )--

--SELECT nom_cursus
--FROM (SELECT nom_cursus, 
--  COUNT(nom_matiere) AS nb_matiere
--FROM matiere_tbl
--GROUP BY nom_cursus) matiere_sel
--WHERE matiere_sel.nb_matiere > 2;

SELECT nom_cursus
FROM matiere_tbl
GROUP BY nom_cursus
HAVING COUNT(nom_matiere) > 2;

--( 5 )--

SELECT nom_cursus
FROM matiere_tbl
GROUP BY nom_cursus
HAVING COUNT(nom_matiere) > 3
UNION
SELECT nom_cursus
FROM edt_tbl
GROUP BY nom_cursus
HAVING COUNT(heure_debut) > 3;

--( 6 )--

SELECT nom FROM etudiant_tbl
WHERE ine IN (SELECT ine FROM NoteLicence
WHERE nom_matiere='BD' AND note > 10);

--( 7 )--

SELECT nom FROM etudiant_tbl
WHERE ine IN (SELECT ine FROM NoteLicence 
WHERE nom_matiere='Systeme' AND note > 10
AND EXISTS (SELECT NULL FROM NoteLicence sub_sel 
  WHERE note < 10 AND NoteLicence.ine=sub_sel.ine));

--( 8 )--

SELECT no_salle
FROM salle_tbl
WHERE nb_place >= (SELECT MAX(COUNT(ine)) AS max_etu
FROM etudiant_tbl
GROUP BY nom_cursus) AND machine='f';

--( 9 )--

SELECT no_salle
FROM salle_tbl
WHERE NOT EXISTS (
SELECT DISTINCT nom_logiciel
FROM logiciel_matiere_tp_tbl
WHERE nom_logiciel NOT IN (SELECT nom_logiciel
  FROM logiciel_salle_tbl
  WHERE logiciel_salle_tbl.no_salle=salle_tbl.no_salle))
INTERSECT
SELECT no_salle
FROM salle_tbl
WHERE nb_place >= (SELECT MAX(COUNT(ine)) AS max_etu
FROM etudiant_tbl
GROUP BY nom_cursus) AND machine='t';