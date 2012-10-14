-- @author Cedric Chantepie
-- @database PostgreSQL

-- Schema --

-- marque
CREATE TABLE marque_tbl (
	nom_marque VARCHAR(125) NOT NULL
);

-- piece
CREATE TABLE piece_tbl (
	num_piece INT4 NOT NULL,
	nom_piece VARCHAR(125) NOT NULL,
	nom_marque VARCHAR(125) NOT NULL
);

CREATE SEQUENCE num_piece_seq INCREMENT BY 1 START WITH 1;

-- stock
CREATE TABLE stock_tbl (
	num_piece INT4 NOT NULL,
	nb_piece INT4 NOT NULL,
	prix_unitaire INT4 NOT NULL
);

-- technicien
CREATE TABLE technicien_tbl (
	nom_tech TEXT NOT NULL,
	cout_h INT4 NOT NULL
);

-- configuration
CREATE TABLE configuration_tbl (
	nom_config VARCHAR(125) NOT NULL,
	prix_vente INT4 NOT NULL,
	nom_concepteur TEXT NOT NULL
);

-- piece de configuration
CREATE TABLE piece_config_tbl (
        nom_config VARCHAR(125) NOT NULL,
        num_piece INT4 NOT NULL,
        nb_piece INT4 NOT NULL
);

-- client
CREATE TABLE client_tbl (
	nom_client TEXT NOT NULL
);

-- commande de config
CREATE TABLE commande_config_tbl (
	num_cmd_cfg INT4 NOT NULL,
	nom_client TEXT NOT NULL,
	nom_config VARCHAR(125) NOT NULL,
	etat VARCHAR(25) NOT NULL,
	nom_tech TEXT NOT NULL
);

CREATE SEQUENCE num_cmd_cfg_seq INCREMENT BY 1 START WITH 1;

-- config d'1 techicien
CREATE TABLE config_tech_tbl (
	nom_config VARCHAR(125) NOT NULL,
	nom_tech TEXT NOT NULL
);
