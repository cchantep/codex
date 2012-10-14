-- client_tbl --
INSERT INTO client_tbl(no_secu, nom, prenom) VALUES ('1710549123456', 'Rudoux', 'Patrick');
INSERT INTO client_tbl(no_secu, nom, prenom) VALUES ('1670649234567', 'Lenoir', 'Herve');
INSERT INTO client_tbl(no_secu, nom, prenom) VALUES ('2740749345678', 'Drabert', 'Severine');

-- vehicule_tbl --
INSERT INTO vehicule_tbl(immat, modele, annee_circu, no_secu) 
VALUES ('1234 TZ 49', 'Twingo', 2000, '1710549123456');

INSERT INTO vehicule_tbl(immat, modele, annee_circu, no_secu) 
VALUES ('2345 RA 49', 'R21', 1980, '1670649234567');

INSERT INTO vehicule_tbl(immat, modele, annee_circu, no_secu) 
VALUES ('3456 RZ 49', 'Super5', 1984, '1710549123456');

UPDATE vehicule_tbl SET immat='4321 TZ 49' WHERE immat='1234 TZ 49';
--SELECT * FROM vehicule_tbl;

UPDATE vehicule_tbl SET annee_circu=annee_circu+1 WHERE annee_circu > 1983;
--SELECT * FROM vehicule_tbl;

-- sinistre_tbl --
INSERT INTO sinistre_tbl(no_sinistre, no_secu, montant, responsabilite)
VALUES ('200201', '1670649234567', 1000, 0);

INSERT INTO sinistre_tbl(no_sinistre, no_secu, montant, responsabilite)
VALUES ('200202', '1710549123456', NULL, 50);

