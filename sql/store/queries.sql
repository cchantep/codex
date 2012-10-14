--( 1 )--
SELECT nom_config, COUNT(num_piece) AS nb_piece
FROM piece_config_tbl GROUP BY nom_config ORDER BY nb_piece DESC;

--( 2 )--
SELECT SUM(nb_piece) AS nb_piece_intel
FROM stock_tbl
WHERE num_piece 
  IN (SELECT num_piece FROM piece_tbl WHERE nom_marque='Intel');

--( 3 )--
SELECT nom_config 
FROM configuration_tbl
WHERE nom_config NOT IN
(SELECT nom_config
FROM piece_config_tbl
WHERE NOT EXISTS
(SELECT num_piece
FROM piece_tbl WHERE nom_marque='Intel'
  AND piece_config_tbl.num_piece=piece_tbl.num_piece)
);

--( 4 )--
SELECT nom_config,
  SUM(piece_config_tbl.nb_piece*prix_unitaire) AS prix_piece
FROM piece_config_tbl
JOIN stock_tbl ON piece_config_tbl.num_piece=stock_tbl.num_piece
GROUP BY nom_config;

--( 5 )--
SELECT prix_sel.nom_config,
  piece_config_tbl.num_piece,
  prix_sel.plus_chere
FROM
(SELECT nom_config, MAX(prix_unitaire) AS plus_chere
FROM piece_config_tbl
JOIN stock_tbl ON piece_config_tbl.num_piece=stock_tbl.num_piece
GROUP BY nom_config) AS prix_sel
JOIN piece_config_tbl ON prix_sel.nom_config=piece_config_tbl.nom_config
JOIN stock_tbl ON stock_tbl.num_piece=piece_config_tbl.num_piece
AND stock_tbl.prix_unitaire=plus_chere ORDER BY prix_sel.nom_config;

--( 6 )--
SELECT nom_piece
FROM piece_tbl
WHERE NOT EXISTS
(SELECT NULL FROM configuration_tbl
WHERE nom_config NOT IN
(SELECT nom_config FROM piece_config_tbl
WHERE piece_config_tbl.num_piece=piece_tbl.num_piece));

--( 7 )--
SELECT nom_config, nom_tech FROM config_tech_tbl
NATURAL JOIN technicien_tbl WHERE (config_tech_tbl.nom_config, technicien_tbl.cout_h)
IN (SELECT nom_config, MIN(cout_h) AS cout_h
FROM config_tech_tbl NATURAL JOIN technicien_tbl GROUP BY nom_config);

--( 8 )--
SELECT nom_config FROM piece_config_tbl
JOIN stock_tbl ON piece_config_tbl.num_piece=stock_tbl.num_piece
WHERE piece_config_tbl.nb_piece > stock_tbl.nb_piece;
