-----
-- Table: client_tbl
-----
CREATE TABLE client_tbl (
	no_secu CHAR(13) NOT NULL PRIMARY KEY,
	nom VARCHAR(125) NOT NULL,
	prenom VARCHAR(125) NOT NULL
);

-----
-- Table: vehicule_tbl
-----
CREATE TABLE vehicule_tbl (
	immat VARCHAR(10) NOT NULL PRIMARY KEY,
	modele VARCHAR(25) NOT NULL,
	annee_circu INTEGER NOT NULL,
	no_secu CHAR(13) NOT NULL,
	CONSTRAINT no_secu_fk FOREIGN KEY(no_secu) REFERENCES client_tbl(no_secu)
);


-----
-- Table: sinistre_tbl
-----
CREATE TABLE sinistre_tbl (
	no_sinistre INTEGER NOT NULL PRIMARY KEY,
	no_secu CHAR(13) NOT NULL,
	montant REAL,
	responsabilite TINYINT NOT NULL,
	CONSTRAINT no_secu_fk FOREIGN KEY(no_secu) REFERENCES client_tbl(no_secu)
);
