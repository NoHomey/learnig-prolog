nat(0).
nat(N) :- nat(M), N is M + 1.

betweenAB(A, B, A) :- A =< B.
betweenAB(A, B, R) :- A < B, A1 is A + 1, betweenAB(A1, B, R).

genKS(1, S, [S]).
genKS(K, S, [C|R]) :- K > 1, betweenAB(0, S, C), T is S - C, K1 is K - 1, genKS(K1, T, R).

integer(0, 0).
integer(I, Z) :- I > 0, (Z is I; Z is -I).

dist(X, Y, Z, T, D) :- D is sqrt((X - Z)^2 + (Y - T)^2).

subcircle(X, Y, R, Z, T, S) :- dist(Z, T, X, Y, D), D + R =< S.

circles1(X, Y, R, Z, T, S) :- nat(N), genKS(3, N, [LZ, LT, S]), S > 0,
                            integer(LZ, Z), integer(LT, T), subcircle(X, Y, R, Z, T, S).

circles2(X, Y, R, Z, T, S) :- XLeft is X - R, XRight is X + R, YDown is Y - R, YUp is Y + R,
                            between(XLeft, XRight, Z), between(YDown, YUp, T), between(1, R, S),
                            subcircle(Z, T, S, X, Y, R).
                             