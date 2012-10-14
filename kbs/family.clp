(deftemplate personne
  (slot id (type INTEGER) (default ?NONE))
  (slot nom (type STRING) (default ?NONE))
  (slot sexe (allowed-symbols M F) (default ?NONE)))

(deffacts la-famille
  (personne (id 1) (nom "Eugénie") (sexe F))
  (personne (id 2) (nom "Albert") (sexe M))
  (personne (id 3) (nom "Martine") (sexe F))
  (personne (id 4) (nom "Christiane") (sexe F))
  (personne (id 5) (nom "Daniel") (sexe M))
  (personne (id 6) (nom "Herve") (sexe M))
  (personne (id 7) (nom "Laurent") (sexe M))
  (personne (id 8) (nom "Nicolas") (sexe M))
  (personne (id 9) (nom "Philippe") (sexe M))
  (personne (id 10) (nom "Éric") (sexe M))
  (personne (id 11) (nom "Stéphanie") (sexe F))
  (personne (id 12) (nom "Thierry") (sexe M))
  (personne (id 13) (nom "Sylvain") (sexe M))
  (parent-de 1 3) ; signifie 1 est parent de 3
  (parent-de 2 3)
  (parent-de 1 4)
  (parent-de 2 4)
  (parent-de 1 5)
  (parent-de 2 5)
  (parent-de 3 6)
  (parent-de 3 7)
  (parent-de 3 8)
  (parent-de 4 11)
  (parent-de 4 12)
  (parent-de 4 13)
  (parent-de 5 9)
  (parent-de 5 10))

(deffacts relations
  (grand-parent M grand-pere)
  (grand-parent F grand-mere)
  (parent M pere)
  (parent F mere)
  (oncle-tante M oncle)
  (oncle-tante F tante)
  (frere-soeur M frere)
  (frere-soeur F soeur)
  (cousin-cousine M cousin)
  (cousin-cousine F cousine))

(deffacts articles
  (article M le)
  (article F la))

(defrule parent-1
  (personne (id ?parent) (sexe ?sexe) (nom ?nom-parent))
  (personne (id ?enfant) (nom ?nom-enfant))
  (parent ?sexe ?rel)
  (article ?sexe ?article)
  ?f <- (parent-de ?parent ?enfant)
  =>
  (printout t ?nom-parent " est " ?article " " ?rel " de " ?nom-enfant crlf)
  (assert (rel ?rel ?parent ?enfant))
  (retract ?f))

(defrule frere-soeur-1
  (personne (id ?p1) (sexe ?sexe) (nom ?nom1))
  (personne (id ?p2&~?p1) (nom ?nom2))
  (rel pere ?pere ?p1)
  (rel mere ?mere ?p1)
  (rel pere ?pere ?p2)
  (rel mere ?mere ?p2)
  (frere-soeur ?sexe ?rel)
  (article ?sexe ?article)
  =>
  (printout t ?nom1 " est " ?article " " ?rel " de " ?nom2 crlf)
  (assert (rel ?rel ?p1 ?p2)))

(defrule grand-parent-1
  (parent M ?parent-m)
  (parent F ?parent-f)
  (personne (id ?grand-parent) (sexe ?sexe) (nom ?gp-nom))
  (personne (id ?petit-enfant) (nom ?pe-nom))
  (rel ?r1&?parent-m|?parent-f ?grand-parent ?parent)
  (rel ?r2&?parent-m|?parent-f ?parent ?petit-enfant)
  (grand-parent ?sexe ?rel)
  (article ?sexe ?article)
  =>
  (printout t ?gp-nom " est " ?article " " ?rel " de " ?pe-nom crlf)
  (assert (rel ?rel ?grand-parent ?petit-enfant)))
  
(defrule oncle-tante-1
  (parent M ?parent-m)
  (parent F ?parent-f)
  (frere-soeur M ?frere-soeur-m)
  (frere-soeur F ?frere-soeur-f)
  (personne (id ?oncle-tante) (sexe ?sexe) (nom ?ot-nom))
  (personne (id ?neveu) (nom ?neveu-nom))
  (rel ?r1&?parent-m|?parent-f ?parent ?neveu)
  (rel ?r2&?frere-soeur-m|?frere-soeur-f ?parent ?oncle-tante)
  (oncle-tante ?sexe ?rel)
  (article ?sexe ?article)
  =>
  (printout t ?ot-nom " est " ?article " " ?rel 
	    " de " ?neveu-nom crlf)
  (assert (rel ?rel ?oncle-tante ?neveu)))
  

(defrule cousin-cousine-1
  (parent M ?pere)
  (parent F ?mere)
  (frere-soeur M ?frere)
  (frere-soeur F ?soeur)
  (personne (id ?id1) (sexe ?sexe) (nom ?nom1))
  (personne (id ?id2&~?id1) (nom ?nom2))
  (rel ?r1&?pere|?mere ?parent1 ?id1)
  (rel ?r2&?pere|?mere ?parent2 ?id2)
  (rel ?r3&?frere|?soeur ?parent1 ?parent2)
  (cousin-cousine ?sexe ?rel)
  (article ?sexe ?article)
  =>
  (printout t ?nom1 " est " ?article " " ?rel 
	    " de " ?nom2 crlf))
