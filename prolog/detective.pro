/* alibi(X, Y, Z) : X a un alibi pour Y donn� par Z */
alibi(luc, mardi, bernard).
alibi(paul, mardi, bernard).
alibi(louis, mardi, luc).
alibi(alain, jeudi, luc).

douteux(alain). 

/* se_venger(X, Y) : X d�sire se venger de Y */
se_venger(paul, jean). 
se_venger(luc, jean).

/* heritier(X, Y) : X est l'h�ritier de Y */
heritier(bernard, jean).
heritier(jean, louis).

/* dette(X, Y) : X doit de l'argent � Y */
dette(louis, jean).
dette(luc, jean).

/* temoin(X, Y) : X a vu Y commettre un crime */
temoin(X, Y). 

/* arme(X) : X poss�de une arme */
arme(luc).
arme(louis).
arme(alain).

/* suspect(X) : X est un suspect */
suspect(luc).
suspect(paul).
suspect(alain).
suspect(bernard).
suspect(louis).

/* X a un alibi valable pour Y */
alibi_valable(X, Y) :- not(douteux(X)), alibi(X, Y, _).

/* X a inter�t pour tuer Y */
interet(X, Y) :- heritier(X, Y).
interet(X, Y) :- dette(X, Y).
interet(X, Y) :- temoin(X, Y).

/* X desire tue Y */
desire_tuer(X, Y) :- interet(X, Y).
desire_tuer(X, Y) :- se_venger(X, Y).

/* X est l'assassin de Y en Z */
assassin(X, Y, Z) :- suspect(X), arme(X), 
  not(alibi_valable(X, Z)), 
  desire_tuer(X, Y).
