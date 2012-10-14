INSERT INTO marque_tbl(nom_marque) VALUES ('Nexole');
INSERT INTO marque_tbl(nom_marque) VALUES ('Palpe');

INSERT INTO employe_tbl(nom_empl) VALUES ('Arthur');
INSERT INTO employe_tbl(nom_empl) VALUES ('Bill');

INSERT INTO produit_tbl(nom_marque, nom_prod) VALUES ('Nexole', 'PS300');
INSERT INTO produit_tbl(nom_marque, nom_prod) VALUES ('Nexole', 'PS500');

INSERT INTO produit_tbl(nom_marque, nom_prod) VALUES ('Palpe', 'Mac');
INSERT INTO produit_tbl(nom_marque, nom_prod) VALUES ('Palpe', 'Palpe II');

INSERT INTO correspondant_marque_tbl(nom_marque, nom_empl)
	VALUES ('Nexole', 'Arthur');

INSERT INTO correspondant_marque_tbl(nom_marque, nom_empl)
	VALUES ('Nexole', 'Bill');

INSERT INTO correspondant_marque_tbl(nom_marque, nom_empl)
	VALUES ('Palpe', 'Arthur');

INSERT INTO test_tbl (no_test, nom_test, nom_empl_resp, note_max)
	VALUES (NEXTVAL('test_no_seq'), 'Solidite', 'Arthur', 10);

INSERT INTO test_produit_tbl(no_test, nom_prod, nom_empl, note)
	VALUES (CURRVAL('test_no_seq'), 'PS300', 'Arthur', 9);

INSERT INTO test_produit_tbl(no_test, nom_prod, nom_empl, note)
	VALUES (CURRVAL('test_no_seq'), 'PS500', 'Arthur', 7);

INSERT INTO test_tbl (no_test, nom_test, nom_empl_resp, note_max)
	VALUES (NEXTVAL('test_no_seq'), 'Rapidite', 'Arthur', 1000);

INSERT INTO test_produit_tbl(no_test, nom_prod, nom_empl, note)
	VALUES (CURRVAL('test_no_seq'), 'PS300', 'Arthur', 200);

INSERT INTO test_produit_tbl(no_test, nom_prod, nom_empl, note)
	VALUES (CURRVAL('test_no_seq'), 'PS500', 'Bill', 400);

INSERT INTO comment_test_prod_tbl(no_test, nom_prod, nom_empl, commentaire)
	VALUES (CURRVAL('test_no_seq'), 'PS300', 'Bill', 'test a refaire');

INSERT INTO test_tbl (no_test, nom_test, nom_empl_resp, note_max)
	VALUES (NEXTVAL('test_no_seq'), 'Evolutivite', 'Bill', 5);

INSERT INTO test_produit_tbl(no_test, nom_prod, nom_empl, note)
	VALUES (CURRVAL('test_no_seq'), 'Mac', 'Bill', 4);

INSERT INTO test_produit_tbl(no_test, nom_prod, nom_empl, note)
	VALUES (CURRVAL('test_no_seq'), 'PS300', 'Bill', 2);

---

UPDATE test_produit_tbl
SET note = (note / 2)
WHERE nom_prod IN
(SELECT nom_prod
FROM produit_tbl
WHERE nom_marque='Nexole');