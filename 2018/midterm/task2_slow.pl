mulList(M, L, [M|L]).

mulLists(_, [], []).
mulLists(M, [H|T], [MH|MT]) :- mulList(M, H, MH), mulLists(M, T, MT).

mulListsWithList([], _, []).
mulListsWithList([H|T], Ls, [HLs|RLs]) :- mulListsWithList(T, Ls, RLs), mulLists(H, Ls, HLs).

concat([], L, L).
concat([H|T], L, [H|R]) :- concat(T, L, R).

concatLists([], []).
concatLists([HL|TL], R) :- concatLists(TL, TR), concat(HL, TR, R).

setToSingletons([], []).
setToSingletons([H|T], [[H]|R]) :- setToSingletons(T, R).

setsProd([], []).
setsProd([H], R) :- setToSingletons(H, R).
setsProd([H|T], R) :- setsProd(T, P),  mulListsWithList(H, P, HP), concatLists(HP, R).

copy(0, _, []).
copy(N, E, [E|T]) :- N > 0, N1 is N - 1, copy(N1, E, T).

allBoolVecs(N, Vecs) :- copy(N, [0, 1], Cords), setsProd(Cords, Vecs).

subset([], []).
subset([_|T], R) :- subset(T, R).
subset([H|T], [H|R]) :- subset(T, R). 

p(N, X) :- allBoolVecs(N, Vecs), subset(Vecs, X), not(X = []).