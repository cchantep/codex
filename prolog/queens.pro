long([], 0).
long([_|R], L) :- long(R, LL), L is LL + 1.

hord(_, [], 0).
hord(X, [T|R], C) :- hord(X, R, CC), C is CC + 1,
	B is T - C, A is T + C,
	X =\= B, X =\= A.

lc([1,2,3,4,5,6,7,8]).

/* place(LR, LC) :
LR = Liste Reines ;
LC = Liste Coups ;
*/
placer([], []).
placer([C|RR], [C|RC]) :- placer(RR, RC), hord(C, RR, _).
placer([C|RR], [_|RC]) :- placer(RR, RC), hord(C, RR, _).