-- Membre(no_membre, no_superieur, nom_membre, prenom_membre)
CREATE TABLE membre_tbl(
  no_membre INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  no_superieur INTEGER,
  nom_membre VARCHAR(25) NOT NULL,
  prenom_membre VARCHAR(25) NOT NULL,
  CONSTRAINT superieur_fk FOREIGN KEY(no_superieur) REFERENCES membre_tbl(no_membre)
);

ALTER TABLE membre_tbl ADD COLUMN salaire NUMERIC(8, 2) NOT NULL;

-- ParticipeProjet(nom_projet, no_membre)
CREATE TABLE participeprojet_tbl(
  nom_projet VARCHAR(25) NOT NULL,
  no_membre INTEGER NOT NULL,
  CONSTRAINT participe_pk PRIMARY KEY(nom_projet,no_membre),
  CONSTRAINT projet_fk FOREIGN KEY(nom_projet) REFERENCES projet_tbl(nom_projet),
  CONSTRAINT membre_fk FOREIGN KEY(no_membre) REFERENCES membre_tbl(no_membre)
); 
  

-- Projet(nom_projet, priorite, date_echeance, no_membre)
CREATE TABLE projet_tbl(
  nom_projet VARCHAR(25) NOT NULL PRIMARY KEY,
  priorite INTEGER NOT NULL,
  date_echeance DATE NOT NULL,
  no_membre INTEGER NOT NULL,
  CONSTRAINT projet_membre_fk FOREIGN KEY(no_membre) REFERENCES membre_tbl(no_membre),
  CONSTRAINT projet_priorite_chk CHECK(priorite >= 0 AND priorite <= 10)
  -- BUG:INSERT INTO projet_tbl(nom_projet, priorite, date_echeance, no_membre) VALUES ('XXX', -1, '2005-03-08', 9);
);

ALTER TABLE projet_tbl ADD CONSTRAINT projet_priorite_chk CHECK(priorite >= 0 AND priorite <= 1000);
