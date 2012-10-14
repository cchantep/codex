CREATE TABLE marque_tbl (
	nom_marque VARCHAR(25) NOT NULL
);

CREATE TABLE produit_tbl (
	nom_prod VARCHAR(25) NOT NULL,
	nom_marque VARCHAR(25) NOT NULL
);

CREATE TABLE employe_tbl (
	nom_empl VARCHAR(25) NOT NULL
);

CREATE TABLE test_tbl (
	no_test INTEGER NOT NULL,
	nom_test VARCHAR(125) NOT NULL,
	nom_empl_resp VARCHAR(25) NOT NULL,
	note_max INTEGER NOT NULL
);

CREATE SEQUENCE test_no_seq INCREMENT BY 1 START WITH 1;

CREATE TABLE test_produit_tbl (
	no_test INTEGER NOT NULL,
	nom_prod VARCHAR(25) NOT NULL,
	nom_empl VARCHAR(25) NOT NULL,
	note INTEGER NOT NULL
);

CREATE UNIQUE INDEX test_produit_empl_uidx ON test_produit_tbl (no_test, nom_prod, nom_empl);
	
CREATE TABLE comment_test_prod_tbl (
	no_test INTEGER NOT NULL,
	nom_prod VARCHAR(25) NOT NULL,
	nom_empl VARCHAR(25) NOT NULL,
	commentaire TEXT NOT NULL
);

CREATE TABLE correspondant_marque_tbl (
	nom_empl VARCHAR(25) NOT NULL,
	nom_marque VARCHAR(25) NOT NULL
);

CREATE VIEW test_consult_view
AS SELECT no_test, nom_empl, note FROM test_produit_tbl
WHERE no_test=1 OR no_test=2;

GRANT SELECT ON test_consult_view TO consult;

--- Constraints

----
-- table: marque_tbl
----

ALTER TABLE marque_tbl ADD CONSTRAINT marque_pk PRIMARY KEY(nom_marque);

----
-- table: produit_tbl
----

ALTER TABLE produit_tbl ADD CONSTRAINT produit_pk
	PRIMARY KEY(nom_prod);

ALTER TABLE produit_tbl ADD CONSTRAINT produit_marque_fk
	FOREIGN KEY(nom_marque) REFERENCES marque_tbl(nom_marque);

----
-- table: employe_tbl
----
ALTER TABLE employe_tbl ADD CONSTRAINT employe_pk PRIMARY KEY(nom_empl);

----
-- table: test_tbl
----
ALTER TABLE test_tbl ADD CONSTRAINT test_pk PRIMARY KEY(no_test);

ALTER TABLE test_tbl ADD CONSTRAINT test_resp_fk 
	FOREIGN KEY(nom_empl_resp) REFERENCES employe_tbl(nom_empl);

ALTER TABLE test_tbl ADD CONSTRAINT test_max_note_chk CHECK(note_max >= 0);

----
-- table: test_produit_tbl
----
ALTER TABLE test_produit_tbl ADD CONSTRAINT test_produit_pk 
	PRIMARY KEY(no_test, nom_prod);

ALTER TABLE test_produit_tbl ADD CONSTRAINT test_produit_fk
	FOREIGN KEY(nom_prod) REFERENCES produit_tbl(nom_prod);

ALTER TABLE test_produit_tbl ADD CONSTRAINT produit_test_fk 
	FOREIGN KEY(no_test) REFERENCES test_tbl(no_test);

ALTER TABLE test_produit_tbl ADD CONSTRAINT test_produit_empl_fk
	FOREIGN KEY(nom_empl) REFERENCES employe_tbl(nom_empl);

----
-- table: comment_test_prod_tbl
----

ALTER TABLE comment_test_prod_tbl ADD CONSTRAINT comment_test_prod_pk
	PRIMARY KEY(no_test, nom_prod, nom_empl);

ALTER TABLE comment_test_prod_tbl ADD CONSTRAINT comment_test_fk
	FOREIGN KEY(no_test) REFERENCES test_tbl(no_test);

ALTER TABLE comment_test_prod_tbl ADD CONSTRAINT comment_test_prod_fk
	FOREIGN KEY(nom_prod) REFERENCES produit_tbl(nom_prod);

ALTER TABLE comment_test_prod_tbl ADD CONSTRAINT comment_test_empl_fk
	FOREIGN KEY(nom_empl) REFERENCES employe_tbl(nom_empl);

----
-- table: marque_tbl
----

ALTER TABLE correspondant_marque_tbl ADD CONSTRAINT correspondant_marque_pk
	PRIMARY KEY(nom_empl, nom_marque);

ALTER TABLE correspondant_marque_tbl ADD CONSTRAINT correspondant_marque_fk
	FOREIGN KEY(nom_marque) REFERENCES marque_tbl(nom_marque);

ALTER TABLE correspondant_marque_tbl ADD CONSTRAINT marque_correspondant_fk
	FOREIGN KEY(nom_empl) REFERENCES employe_tbl(nom_empl);



