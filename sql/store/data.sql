-- marque,piece et stock
INSERT INTO marque_tbl(nom_marque) VALUES ('Intel');
INSERT INTO marque_tbl(nom_marque) VALUES ('Kingston');

-- Intel
INSERT INTO piece_tbl(num_piece, nom_marque, nom_piece)
VALUES (NEXTVAL('num_piece_seq'), 'Intel', 'Celeron');

INSERT INTO stock_tbl(num_piece, prix_unitaire, nb_piece)
VALUES (CURRVAL('num_piece_seq'), 70, 1);

INSERT INTO piece_tbl(num_piece, nom_marque, nom_piece)
VALUES (NEXTVAL('num_piece_seq'), 'Intel', 'Pentium');

INSERT INTO stock_tbl(num_piece, prix_unitaire, nb_piece)
VALUES (CURRVAL('num_piece_seq'), 200, 2);

INSERT INTO piece_tbl(num_piece, nom_marque, nom_piece)
VALUES (NEXTVAL('num_piece_seq'), 'Intel', 'CM865');

INSERT INTO stock_tbl(num_piece, prix_unitaire, nb_piece)
VALUES (CURRVAL('num_piece_seq'), 100, 1);

-- Kingston
INSERT INTO piece_tbl(num_piece, nom_marque, nom_piece)
VALUES (NEXTVAL('num_piece_seq'), 'Kingston', '512Mo');

INSERT INTO stock_tbl(num_piece, prix_unitaire, nb_piece)
VALUES (CURRVAL('num_piece_seq'), 200, 3);

-- configurations, technicien concepteur
INSERT INTO technicien_tbl (nom_tech, cout_h)
VALUES ('Alan', 90);

INSERT INTO technicien_tbl (nom_tech, cout_h)
VALUES ('Bill', 70);

-- sans mem
INSERT INTO configuration_tbl(nom_config, prix_vente, nom_concepteur)
VALUES ('SansMemoire', 500, 'Alan');

INSERT INTO piece_config_tbl(nom_config, num_piece, nb_piece) VALUES ('SansMemoire', 1, 1);
INSERT INTO piece_config_tbl(nom_config, num_piece, nb_piece) VALUES ('SansMemoire', 3, 1);

INSERT INTO config_tech_tbl(nom_config, nom_tech)
VALUES ('SansMemoire', 'Alan');

INSERT INTO config_tech_tbl(nom_config, nom_tech)
VALUES ('SansMemoire', 'Bill');

-- maxi mem
INSERT INTO configuration_tbl(nom_config, prix_vente, nom_concepteur)
VALUES ('MaxiMemoire', 1500, 'Alan');

INSERT INTO piece_config_tbl(nom_config, num_piece, nb_piece) VALUES ('MaxiMemoire', 2, 1);
INSERT INTO piece_config_tbl(nom_config, num_piece, nb_piece) VALUES ('MaxiMemoire', 3, 1);
INSERT INTO piece_config_tbl(nom_config, num_piece, nb_piece) VALUES ('MaxiMemoire', 4, 4);

INSERT INTO config_tech_tbl(nom_config, nom_tech)
VALUES ('MaxiMemoire', 'Alan');

-- commandes et client
INSERT INTO client_tbl(nom_client) VALUES ('Dupont');

INSERT INTO commande_config_tbl(num_cmd_cfg, nom_client, nom_config, etat, nom_tech)
VALUES (NEXTVAL('num_cmd_cfg_seq'), 'Dupont', 'SansMemoire', 'EN_ATTENTE', 'Alan');
