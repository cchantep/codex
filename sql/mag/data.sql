-- data --
-- magazine_tbl --
INSERT INTO magazine_tbl (nom_mag, prix_vente) VALUES ('BD Hebdo', 2);
INSERT INTO magazine_tbl (nom_mag, prix_vente) VALUES ('Oraclemag', 4);

-- numero_mag_tbl --
INSERT INTO numero_mag_tbl(nom_mag, no_mag, nombre_invendu) VALUES ('BD Hebdo', 60, 10);
INSERT INTO numero_mag_tbl(nom_mag, no_mag, nombre_invendu) VALUES ('BD Hebdo', 61, 3);
INSERT INTO numero_mag_tbl(nom_mag, no_mag, nombre_invendu) VALUES ('Oraclemag', 22, 2);

-- client_tbl --
INSERT INTO client_tbl(no_client, nom_client, ville_client) VALUES (5, 'Jean Nemar', 'Angers');
INSERT INTO client_tbl(no_client, nom_client, ville_client) VALUES (8, 'Paul Isse', 'Nantes');
INSERT INTO client_tbl(no_client, nom_client, ville_client) VALUES (10, 'Jean Bon', 'Angers');

-- adhesion_tbl --
INSERT INTO adhesion_tbl(no_client, nom_mag, no_mag_echeance) VALUES (5, 'Oraclemag', 27);
INSERT INTO adhesion_tbl(no_client, nom_mag, no_mag_echeance) VALUES (5, 'BD Hebdo', 4);
INSERT INTO adhesion_tbl(no_client, nom_mag, no_mag_echeance) VALUES (8, 'Oraclemag', 30);
INSERT INTO adhesion_tbl(no_client, nom_mag, no_mag_echeance) VALUES (8, 'BD Hebdo', 78);

-- commande_tbl --
INSERT INTO commande_tbl(nom_mag, no_mag, no_client) VALUES ('BD Hebdo', 60, 8);
INSERT INTO commande_tbl(nom_mag, no_mag, no_client) VALUES ('BD Hebdo', 60, 10);
INSERT INTO commande_tbl(nom_mag, no_mag, no_client) VALUES ('BD Hebdo', 61, 10);
