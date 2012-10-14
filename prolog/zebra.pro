/*
maison(C, N, Nt, B, A).
C = Couleur ;
N = Nom ;
Nt= Nationalite ;
B = Boisson ;
A = Animal ;
*/

maisons([
maison(_, _, _, _, _),
maison(_, _, _, _, _),
maison(_, _, _, _, _),
maison(_, _, _, _, _),
maison(_, _, _, _, _)
]).

element(X, [X|_]).
element(X, [_|T]) :- element(X, T).

voisin(X, Y, [X, Y | _]).
voisin(X, Y, [Y, X | _]).
voisin(X, Y, [_ | T]) :- voisin(X, Y, T).

/* Y a droite de X */
a_droite(X, Y, [X, Y | _]).
a_droite(X, Y, [_ | T]) :- a_droite(X, Y, T).

len([], 0).
len([_ | L], N) :- len(L, M), N is M + 1.

millieu(X, Y) :- millieu(X, Y, 0).
millieu(X, [X], _).
millieu(X, [X | L], N) :- len(L, M), N is M, !.
millieu(X, [_ | T], N) :- M is N + 1, millieu(X, T, M).

premiere(X, [X|_]).

zebre(X) :-
	maisons(X),
	voisin(maison(_, jean, _, _, _), maison(_, _, _, _, chat), X),
	voisin(maison(_, jean, _, _, _), maison(_, _, _, eau, _), X),
	a_droite(maison(blanche, _, _, _, _), maison(verte, _, _, _, _), X),
	millieu(maison(_, _, _, lait, _), X),
	voisin(maison(_, paul, _, _, _), maison(_, _, _, _, cheval), X),
	voisin(maison(_, _, norvegien, _, _), maison(bleue, _, _, _, _), X),
	premiere(maison(_, _, norvegien, _, _), X),
	element(maison(rouge, _, anglais, _, _), X),
	element(maison(_, _, suedois, _, chien), X),
	element(maison(verte, _, _, cafe, _), X),
	element(maison(_, _, danois, the, _), X),
	element(maison(_, pierre, _, _, oiseau), X),
	element(maison(jaune, paul, _, _, _), X),
	element(maison(_, jacques, _, biere, _), X),
	element(maison(_, hans, allemand, _, _), X),
	element(maison(_, _, _, _, zebre), X).

