-- sinistre_tbl --
DELETE FROM sinistre_tbl WHERE no_sinistre=200202;
--SELECT * FROM sinistre_tbl;
DELETE FROM sinistre_tbl;
--SELECT * FROM sinistre_tbl;

-- client_tbl --
DELETE FROM client_tbl WHERE nom LIKE '%o%';
--SELECT * FROM client_tbl;

-- all --
DROP TABLE vehicule_tbl;
DROP TABLE sinistre_tbl;
DROP TABLE client_tbl;

--SHOW TABLES