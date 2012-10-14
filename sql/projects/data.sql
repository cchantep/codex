-- # Inserts

-- Table: membre_tbl
INSERT INTO membre_tbl(no_superieur, prenom_membre, nom_membre) VALUES (NULL, 'Serge', 'Karamazov');
INSERT INTO membre_tbl(no_superieur, prenom_membre, nom_membre) VALUES (1, 'Odile', 'Deray');
INSERT INTO membre_tbl(no_superieur, prenom_membre, nom_membre) VALUES (2, 'Gilles', 'Gilet');
INSERT INTO membre_tbl(no_superieur, prenom_membre, nom_membre) VALUES (1, 'Simon', 'Jeremi');
INSERT INTO membre_tbl(no_superieur, prenom_membre, nom_membre) VALUES (2, 'Andre', 'Lamar');

-- Table: projet_tbl
INSERT INTO projet_tbl(nom_projet, priorite, no_membre, date_echeance) VALUES ('PRJ1', 5, 2, '2006-10-14');
INSERT INTO projet_tbl(nom_projet, priorite, no_membre, date_echeance) VALUES ('PRJ2', 7, 5, '2007-04-22');

-- Table: participeprojet_tbl
INSERT INTO participeprojet_tbl(nom_projet, no_membre) VALUES ('PRJ1', 1);
INSERT INTO participeprojet_tbl(nom_projet, no_membre) VALUES ('PRJ1', 3);
INSERT INTO participeprojet_tbl(nom_projet, no_membre) VALUES ('PRJ1', 4);
INSERT INTO participeprojet_tbl(nom_projet, no_membre) VALUES ('PRJ1', 5);

-- # Updates

-- membre_tbl
UPDATE membre_tbl SET salaire=10000 - 1000 * no_membre;
UPDATE membre_tbl SET salaire=salaire+100 ORDER BY salaire ASC LIMIT 1;

-- projet_tbl
UPDATE projet_tbl SET priorite=priorite * 1000;
