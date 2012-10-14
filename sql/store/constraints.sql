-- marque
ALTER TABLE marque_tbl ADD CONSTRAINT marque_pk
	PRIMARY KEY(nom_marque);

-- piece
ALTER TABLE piece_tbl ADD CONSTRAINT piece_pk
	PRIMARY KEY(num_piece);

ALTER TABLE piece_tbl ADD CONSTRAINT piece_marque_fk
	FOREIGN KEY(nom_marque) REFERENCES marque_tbl(nom_marque);

-- stock
ALTER TABLE stock_tbl ADD CONSTRAINT stock_pk
	PRIMARY KEY(num_piece);

ALTER TABLE stock_tbl ADD CONSTRAINT stock_piece_fk
	FOREIGN KEY(num_piece) REFERENCES piece_tbl(num_piece);

ALTER TABLE stock_tbl ADD CONSTRAINT prix_piece_chk
	CHECK(prix_unitaire > 0);

-- technicien
ALTER TABLE technicien_tbl ADD CONSTRAINT tech_pk PRIMARY KEY(nom_tech);

ALTER TABLE technicien_tbl ADD CONSTRAINT tech_couth_chk CHECK(cout_h > 0);

-- configuration
ALTER TABLE configuration_tbl ADD CONSTRAINT configuration_pk
	PRIMARY KEY(nom_config);

ALTER TABLE configuration_tbl ADD CONSTRAINT prix_vente_chk
	CHECK(prix_vente > 0);

ALTER TABLE configuration_tbl ADD CONSTRAINT config_concept_fk
	FOREIGN KEY(nom_concepteur) REFERENCES technicien_tbl(nom_tech);

-- piece config
ALTER TABLE piece_config_tbl ADD CONSTRAINT piece_config_pk 
	PRIMARY KEY(nom_config, num_piece);

ALTER TABLE piece_config_tbl ADD CONSTRAINT piece_config_fk
	FOREIGN KEY(nom_config) REFERENCES configuration_tbl(nom_config);

ALTER TABLE piece_config_tbl ADD CONSTRAINT config_piece_fk 
	FOREIGN KEY(num_piece) REFERENCES piece_tbl(num_piece);

ALTER TABLE piece_config_tbl ADD CONSTRAINT config_nb_piece_chk
	CHECK(nb_piece > 0);

-- client
ALTER TABLE client_tbl ADD CONSTRAINT client_pk PRIMARY KEY(nom_client);

-- commande de config
ALTER TABLE commande_config_tbl ADD CONSTRAINT cmd_cfg_pk PRIMARY KEY(num_cmd_cfg);

ALTER TABLE commande_config_tbl ADD CONSTRAINT cmd_cfg_client_fk 
	FOREIGN KEY(nom_client) REFERENCES client_tbl(nom_client);

ALTER TABLE commande_config_tbl ADD CONSTRAINT cmd_config_fk
	FOREIGN KEY(nom_config) REFERENCES configuration_tbl(nom_config);

ALTER TABLE commande_config_tbl ADD CONSTRAINT cmd_cfg_etat_chk
	CHECK(etat = 'EN_ATTENTE' OR etat = 'PRETE' OR etat = 'TERMINEE');

ALTER TABLE commande_config_tbl ADD CONSTRAINT cmd_cfg_tech_fk
	FOREIGN KEY(nom_tech) REFERENCES technicien_tbl(nom_tech);

-- config d'1 technicien
ALTER TABLE config_tech_tbl ADD CONSTRAINT config_tech_pk
	PRIMARY KEY(nom_config, nom_tech);

ALTER TABLE config_tech_tbl ADD CONSTRAINT tech_config_fk
	FOREIGN KEY(nom_config) REFERENCES configuration_tbl(nom_config);

ALTER TABLE config_tech_tbl ADD CONSTRAINT config_tech_fk 
	FOREIGN KEY(nom_tech) REFERENCES technicien_tbl(nom_tech);

