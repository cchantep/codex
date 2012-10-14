-- vehicule_tbl --
SELECT immat, modele, annee_circu
FROM vehicule_tbl
WHERE no_secu='1710549123456';

SELECT immat, modele, annee_circu
FROM vehicule_tbl
WHERE no_secu='2740749345678';

SELECT vehicule_tbl.immat, vehicule_tbl.modele, vehicule_tbl.annee_circu, vehicule_tbl.no_secu,
  client_tbl.nom, client_tbl.prenom
FROM vehicule_tbl 
NATURAL JOIN client_tbl;

SELECT vehicule_tbl.annee_circu
FROM vehicule_tbl 
NATURAL JOIN client_tbl
WHERE client_tbl.nom='Rudoux';

-- client_tbl --
SELECT no_secu
FROM client_tbl
WHERE nom='Rudoux';

-- sinistre_tbl --
SELECT no_secu 
FROM sinistre_tbl
WHERE montant IS NULL;

SELECT client_tbl.nom, client_tbl.prenom
FROM sinistre_tbl
NATURAL JOIN client_tbl
WHERE sinistre_tbl.no_sinistre BETWEEN 200110 AND 200201;