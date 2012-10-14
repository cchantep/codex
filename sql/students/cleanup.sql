BEGIN;

DELETE FROM etudiant_tbl 
WHERE ine IN
(SELECT ine FROM note_tbl
WHERE note_tbl.nom_matiere = 'Logique'
  AND note_tbl.note < 10);
