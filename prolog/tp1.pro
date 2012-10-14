/* 1. composition des menus */ 
/* les entrées */ 
entree(crudites). 
entree(terrine). 
entree(melon). 
 
/* les viandes (avec légumes associés) */ 
viande(steack). 
viande(poulet). 
viande(gigot). 
 
/* les poissons (avec légumes associés) */ 
poisson(bar). 
poisson(saumon). 
 
/* les desserts */ 
dessert(sorbet). 
dessert(creme). 
dessert(tarte). 
 
/* composition d'un menu simple : une entrée ET un plat ET un dessert */ 
menu_simple(E, P, D) :- entree(E), plat(P), dessert(D). 
 
/* le plat de résistance : viande OU poisson */ 
plat(P) :- viande(P). 
plat(P) :- poisson(P). 

/* 2. Une base de fait familiale */
mere(marie_de_medicis, gaston_d_orleans) .  
mere(marie_de_medicis, louis_XIII) .
mere(marguerite_d_autriche, anne_d_autriche) .
mere(marguerite_d_autriche, philippe_IV) . 
mere(anne_d_autriche, louis_XIV) .
mere(anne_d_autriche, philippe_I_d_orleans) .
mere(jeanne_d_albret,henri_IV) .
pere(henri_IV, gaston_d_orleans) .
pere(henri_IV, louis_XIII) .
pere(philippe_III, anne_d_autriche) .
pere(philippe_III, philippe_IV) . 
pere(louis_XIII, louis_XIV) .
pere(louis_XIII, philippe_I_d_orleans) .
pere(louis_XIV, duc_d_anjou).
pere(antoire_de_bourbon, henri_IV).

/* X est parent de Y */
parent(X, Y) :- pere(X, Y).
parent(X, Y) :- mere(X, Y).

/* X est l'enfant de Y */
enfant(X, Y) :- parent(Y, X).

/* X est l'ancetre de Y */
ancetre(X, Y) :- parent(X, Y).
ancetre(X, Y) :- ancetre(X, Z), parent(Z, Y).

/* X est l'ancetre de Y */
ancetre2(X, Y) :- enfant(Y, X).
ancetre2(X, Y) :- ancetre2(X, Z), enfant(Y, Z).

/* 3. Connecteurs */
not(1, 0).
not(0, 1).

and(X, Y, 1) :- X is 1, Y is 1, !.
and(_, _, 0).

nand(X, Y, Z) :- and(X, Y, R), not(R, Z).

xor(X, Y, 1) :- X is 1, Y is 0, !.
xor(X, Y, 1) :- X is 0, Y is 1, !.
xor(_, _, 0).

circuit(X, Y, R) :- not(X, R1), nand(X, Y, R2), xor(R1, R2, R3), not(R3, R).

