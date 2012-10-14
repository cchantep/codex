---( 1 )---
SELECT nom_prod, COUNT(no_test) AS nb_test
FROM test_produit_tbl
GROUP BY nom_prod
ORDER BY nb_test DESC;

---( 2 )---
SELECT no_test, commentaire
FROM comment_test_prod_tbl
WHERE no_test IN (SELECT no_test FROM test_produit_tbl 
WHERE nom_empl='Arthur');

---( 3 )---
SELECT nom_prod
FROM produit_tbl
WHERE nom_prod NOT IN
(SELECT nom_prod FROM produit_tbl
WHERE EXISTS 
(SELECT NULL FROM test_produit_tbl WHERE
produit_tbl.nom_prod = test_produit_tbl.nom_prod));

---( 4 )---
SELECT no_test, nom_prod
FROM test_produit_tbl
NATURAL JOIN test_tbl
WHERE test_produit_tbl.nom_empl <> test_tbl.nom_empl_resp;

---( 5 )---
SELECT nom_prod 
FROM produit_tbl
WHERE NOT EXISTS (
SELECT NULL FROM test_tbl
WHERE no_test NOT IN 
(SELECT no_test FROM test_produit_tbl
WHERE test_tbl.no_test = test_produit_tbl.no_test
  AND produit_tbl.nom_prod = test_produit_tbl.nom_prod));

---( 6 )---

SELECT nom_marque, produit_tbl.nom_prod  
FROM (SELECT test_produit_tbl.nom_prod
FROM test_produit_tbl
NATURAL JOIN produit_tbl
GROUP BY test_produit_tbl.nom_prod
HAVING COUNT(no_test) >= 2) AS subs_sel
NATURAL JOIN produit_tbl
NATURAL JOIN marque_tbl
INTERSECT
SELECT nom_marque, nom_prod
FROM produit_tbl
WHERE nom_prod 
NOT IN 
(SELECT nom_prod FROM produit_tbl
WHERE EXISTS 
(SELECT NULL FROM comment_test_prod_tbl
WHERE produit_tbl.nom_prod = comment_test_prod_tbl.nom_prod));

---( 7 )---

SELECT test_tbl.no_test, 
  test_tbl.nom_test,
  test_produit_tbl.nom_prod,
  test_produit_tbl.note AS meilleur_note
FROM test_produit_tbl
NATURAL JOIN test_tbl
WHERE (no_test, note) IN
(SELECT no_test, MAX(note) AS meilleur_resultat
FROM test_produit_tbl
GROUP BY no_test);

---( 8 )---

SELECT no_test,
  nom_prod,
  test_produit_tbl.nom_empl AS empl_operateur,
  correspondant_marque_tbl.nom_empl AS correspondant
FROM test_produit_tbl
NATURAL JOIN produit_tbl
JOIN correspondant_marque_tbl
  ON produit_tbl.nom_marque=correspondant_marque_tbl.nom_marque
WHERE test_produit_tbl.nom_empl <> correspondant_marque_tbl.nom_empl;

---( 9 )---

SELECT nom_prod, 
  no_test,
  test_tbl.nom_test
FROM test_produit_tbl
NATURAL JOIN test_tbl
WHERE ((note * 100) / note_max) = (SELECT MAX(note_ratio)
FROM (SELECT ((note * 100) / note_max) AS note_ratio
FROM test_tbl
NATURAL JOIN test_produit_tbl) AS sub_sel);
