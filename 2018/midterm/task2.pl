numToBoolVec(0, 0, []).
numToBoolVec(L, N, [C|R]) :- L > 0, L1 is L - 1, C is N mod 2, M is N div 2, numToBoolVec(L1, M, R).

recAllBoolVecs(L, 0, [Zero]) :- numToBoolVec(L, 0, Zero).
recAllBoolVecs(L, N, [Vec|Rest]) :- N > 0, N1 is N - 1, numToBoolVec(L, N, Vec), recAllBoolVecs(L, N1, Rest).

allBoolVecs(L, Vecs) :- N is (2 ^ L) - 1, recAllBoolVecs(L, N, Vecs).

subset([], []).
subset([_|T], R) :- subset(T, R).
subset([H|T], [H|R]) :- subset(T, R).

p(N, X) :- allBoolVecs(N, All), subset(All, X), not(X = []).