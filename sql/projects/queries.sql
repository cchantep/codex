-- membre_tbl
SELECT nom_membre, prenom_membre FROM membre_tbl WHERE no_superieur IS NULL;

SELECT membre_tbl.no_membre FROM membre_tbl 
NATURAL JOIN participeprojet_tbl 
JOIN projet_tbl ON projet_tbl.date_echeance > '2007-01-01' 
  AND participeprojet_tbl.nom_projet=projet_tbl.nom_projet
UNION
SELECT no_membre FROM projet_tbl
WHERE date_echeance > '2007-01-01';

SELECT membre_tbl.prenom_membre, membre_tbl.nom_membre
FROM membre_tbl
NATURAL JOIN participeprojet_tbl
JOIN projet_tbl ON projet_tbl.nom_projet='PRJ2'
  AND participeprojet_tbl.nom_projet=projet_tbl.nom_projet
UNION
SELECT membre_tbl.prenom_membre, membre_tbl.nom_membre
FROM membre_tbl
JOIN projet_tbl ON projet_tbl.nom_projet='PRJ2'
  AND membre_tbl.no_membre=projet_tbl.no_membre;

SELECT no_superieur FROM membre_tbl WHERE no_membre=3;

SELECT superieur_tbl.nom_membre, superieur_tbl.prenom_membre 
FROM membre_tbl 
JOIN membre_tbl superieur_tbl 
  ON membre_tbl.no_superieur=superieur_tbl.no_membre
WHERE membre_tbl.no_membre=3;

SELECT superieur_tbl.nom_membre, superieur_tbl.prenom_membre 
FROM membre_tbl 
JOIN membre_tbl superieur_tbl 
  ON membre_tbl.no_superieur=superieur_tbl.no_membre
WHERE membre_tbl.nom_membre='Jeremi'
  AND membre_tbl.prenom_membre='Simon';

CREATE VIEW not_prjtwo_member_view 
AS (SELECT membre_tbl.prenom_membre,
  membre_tbl.nom_membre
FROM membre_tbl
LEFT JOIN participeprojet_tbl
ON membre_tbl.no_membre=participeprojet_tbl.no_membre
  AND participeprojet_tbl.nom_projet ='PRJ2'
WHERE participeprojet_tbl.nom_projet IS NULL);

SELECT membre_tbl.nom_membre 
FROM membre_tbl
JOIN membre_tbl AS superieur_tbl
  ON membre_tbl.no_superieur=superieur_tbl.no_membre
WHERE superieur_tbl.nom_membre='Karamazov' 
  AND superieur_tbl.prenom_membre='Serge';

SELECT membre_tbl.nom_membre, membre_tbl.prenom_membre,
  superieur_tbl.nom_membre, superieur_tbl.prenom_membre 
FROM membre_tbl 
LEFT JOIN membre_tbl superieur_tbl 
  ON membre_tbl.no_superieur=superieur_tbl.no_membre
ORDER BY membre_tbl.nom_membre;

SELECT membre_tbl.nom_membre 
FROM membre_tbl
JOIN membre_tbl AS sup_tbl
  ON membre_tbl.no_superieur=sup_tbl.no_membre
JOIN membre_tbl AS superieur_tbl
  ON sup_tbl.no_superieur=superieur_tbl.no_membre
WHERE superieur_tbl.nom_membre='Karamazov' 
  AND superieur_tbl.prenom_membre='Serge';

DELETE FROM projet_tbl
ORDER BY date_echeance DESC
LIMIT 1;
