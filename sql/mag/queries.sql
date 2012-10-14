--- membre_tbl ---
SELECT no_membre, nom_membre FROM membre_tbl
WHERE no_membre % 2 = 0;

SELECT nom_membre, 
  IF(salaire > 7000, 'Bien paye', 'Mal paye') 
FROM membre_tbl;

SELECT nom_membre,
  CASE WHEN salaire > 7000
  THEN 'Bien paye'
  ELSE 'Mal paye'
  END AS appreciation
FROM membre_tbl;

SELECT AVG(salaire) AS salaire_moyen FROM membre_tbl;

SELECT membre_tbl.no_membre, 
  COUNT(participeprojet_tbl.nom_projet) AS nombre_projet
FROM membre_tbl
NATURAL JOIN participeprojet_tbl
GROUP BY membre_tbl.no_membre;

SELECT participeprojet_tbl.nom_projet,
  MAX(membre_tbl.salaire)
FROM membre_tbl
NATURAL JOIN participeprojet_tbl
GROUP BY participeprojet_tbl.nom_projet;

SELECT membre_tbl.nom_membre, 
  COUNT(participeprojet_tbl.nom_projet) AS moncul
FROM membre_tbl
NATURAL JOIN participeprojet_tbl
GROUP BY membre_tbl.nom_membre;

SELECT membre_tbl.nom_membre, 
  COUNT(depend_tbl.no_membre)
FROM membre_tbl
JOIN membre_tbl depend_tbl
ON membre_tbl.no_membre = depend_tbl.no_superieur
GROUP BY membre_tbl.nom_membre;

SELECT membre_tbl.nom_membre, 
  COUNT(depend_tbl.no_membre)
FROM membre_tbl
LEFT JOIN membre_tbl depend_tbl
ON membre_tbl.no_membre = depend_tbl.no_superieur
GROUP BY membre_tbl.nom_membre;

-- 
SELECT COUNT(DISTINCT client_tbl.ville_client) AS nb_ville
FROM client_tbl
NATURAL JOIN commande_tbl
WHERE commande_tbl.nom_mag = 'BD Hebdo';

SELECT adhesion_tbl.nom_mag, COUNT(adhesion_tbl.no_client) AS nb_abo
FROM adhesion_tbl
GROUP BY adhesion_tbl.nom_mag
ORDER BY nb_abo DESC;

SELECT adhesion_tbl.no_client
FROM adhesion_tbl
NATURAL JOIN commande_tbl;

SELECT client_tbl.nom_client
FROM client_tbl
NATURAL JOIN commande_tbl
WHERE client_tbl.ville_client = 'Nantes'
GROUP BY client_tbl.nom_client
HAVING COUNT(commande_tbl.no_client) >= 2;

SELECT adhesion_tbl.no_client
FROM adhesion_tbl
LEFT JOIN commande_tbl
  ON adhesion_tbl.no_client=commande_tbl.no_client
WHERE commande_tbl.nom_mag IS NULL
GROUP BY adhesion_tbl.no_client;

SELECT SUM(numero_mag_tbl.nombre_invendu*magazine_tbl.prix_vente) 
  AS montant_invendu 
FROM numero_mag_tbl 
NATURAL JOIN magazine_tbl;

SELECT autre_client.nom_client
FROM client_tbl
NATURAL JOIN adhesion_tbl
JOIN adhesion_tbl autre_ad
  ON adhesion_tbl.nom_mag=autre_ad.nom_mag
JOIN client_tbl autre_client
  ON autre_ad.no_client=autre_client.no_client
  AND autre_client.ville_client=client_tbl.ville_client
WHERE client_tbl.nom_client='Jean Nemar'
  AND autre_client.nom_client <> 'Jean Nemar'
GROUP BY autre_client.nom_client;

SELECT commande_tbl.no_client, 
  COUNT(commande_tbl.nom_mag) AS nb_projet 
FROM commande_tbl 
GROUP BY commande_tbl.no_client 
ORDER BY nb_projet 
DESC LIMIT 1;
