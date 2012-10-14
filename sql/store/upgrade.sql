--( 1 )--
BEGIN;
DELETE FROM config_tech_tbl WHERE nom_tech 
IN (SELECT nom_tech FROM (SELECT nom_tech, COUNT(nom_config) AS nb_config 
FROM config_tech_tbl GROUP BY nom_tech) AS subsel WHERE subsel.nb_config = 1);
ROLLBACK;

--( 2 )--
UPDATE stock_tbl SET nb_piece=nb_piece+5
WHERE num_piece
IN (SELECT num_piece FROM piece_config_tbl
WHERE nom_config='SansMemoire');

--( 3 )--
CREATE VIEW stock_intel_view
AS SELECT stock_tbl.num_piece, nb_piece, prix_unitaire
FROM stock_tbl NATURAL JOIN piece_tbl
WHERE piece_tbl.nom_marque='Intel';

GRANT SELECT ON stock_intel_view TO util;
