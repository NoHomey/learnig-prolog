filterList([], [], _).
filterList([E|T], R, E) :- filterList(T, R, E).
filterList([H|T], [H|R], E) :- not(H = E), filterList(T, R, E).

listMember([H], H).
listMember([H|_], H).
listMember([H|T], M) :- not(H = M), listMember(T, M).

prod([], 1).
prod([_|T], N) :- prod(T, N).
prod([H|T], N) :- not(0 is N mod H), prod(T, N).
prod([H|T], N) :- 0 is N mod H, M is N div H, prod(T, M).
prod([H|T], N) :- 0 is N mod H, M is N div H, prod([H|T], M).

p(L, 0) :- listMember(L, 0).
p(L, N) :- N > 0, filterList(L, P, 1), prod(P, N).