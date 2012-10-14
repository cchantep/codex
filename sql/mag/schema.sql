-- magazine_tbl

CREATE TABLE magazine_tbl (
	nom_mag VARCHAR(25) NOT NULL,
	prix_vente FLOAT NOT NULL,
	CONSTRAINT magazine_pk PRIMARY KEY(nom_mag)
);

-- client_tbl

CREATE TABLE client_tbl (
	no_client INTEGER NOT NULL AUTO_INCREMENT,
	nom_client VARCHAR(25) NOT NULL,
	ville_client VARCHAR(25) NOT NULL,
	CONSTRAINT client_pk PRIMARY KEY(no_client)
);

-- adhesion_tbl

CREATE TABLE adhesion_tbl (
	no_client INTEGER NOT NULL,
	nom_mag VARCHAR(25) NOT NULL,
	no_mag_echeance INTEGER NOT NULL,
	CONSTRAINT adhesion_pk PRIMARY KEY(no_client,nom_mag),
	CONSTRAINT adhesion_client_fk FOREIGN KEY(no_client) 
	REFERENCES client_tbl(no_client),
	CONSTRAINT adhesion_mag_fk FOREIGN KEY(nom_mag) 
	REFERENCES magazine_tbl(nom_mag)
);

-- numero_mag_tbl

CREATE TABLE numero_mag_tbl (
	nom_mag VARCHAR(25) NOT NULL,
	no_mag INTEGER NOT NULL,
	nombre_invendu INTEGER NOT NULL,
	CONSTRAINT numero_mag_pk PRIMARY KEY(nom_mag,no_mag),
	CONSTRAINT numero_mag_nom_mag_fk FOREIGN KEY(nom_mag)
	REFERENCES magazine_tbl(nom_mag)
);

-- commande_tbl

CREATE TABLE commande_tbl (
	nom_mag VARCHAR(25) NOT NULL,
	no_mag INTEGER NOT NULL,
	no_client INTEGER NOT NULL,
	CONSTRAINT commande_pk PRIMARY KEY(nom_mag,no_mag,no_client),
	CONSTRAINT numero_fk FOREIGN KEY(nom_mag,no_mag) 
	REFERENCES numero_mag_tbl(nom_mag,no_mag)
);

-- grants --
GRANT SELECT ON magazine_tbl TO jousse;
GRANT SELECT ON adhesion_tbl TO jousse;--WITH GRANT OPTION
GRANT UPDATE(no_mag_echeance) ON adhesion_tbl TO jousse;

GRANT SELECT ON magazine_tbl TO damota;
GRANT SELECT ON adhesion_tbl TO damota;--WITH GRANT OPTION
GRANT UPDATE(no_mag_echeance) ON adhesion_tbl TO damota;

