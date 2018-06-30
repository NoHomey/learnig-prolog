% L = [X1, X2, ..., XN] is list of integers.
% L is special if :
% forall k : 1 <= K <= N / 2 is true that:
% X(2K) = X(X(K + 2)), if 1 <= K + 2 <= N and 1 <= X(K + 2) <= N
% X(2K) = 2XK + 2, else
% p(L) is true if L is special.

element(1, [H|_], H).
element(K, [_|T], E) :- K > 1, K1 is K - 1, element(K1, T, E).

check(1, 0, 1, [_]).
check(K, M, _, _) :- K is M + 1.
check(K, M, N, L) :- K2 is K + 2, K2 =< N, element(K2, L, X), 1 =< X, X =< N, element(X, L, Y),
                    T is 2 * K, element(T, L, Z), Z is Y, S is K + 1, check(S, M, N, L).
check(K, M, N, L) :- K2 is K * 2, element(K2, L, X), element(K, L, Y), X is 2 * Y + 2,
                    S is K + 1, check(S, M, N, L).

listLength([], 0).
listLength([_|T], N) :- listLength(T, L), N is L + 1.

p(L) :- listLength(L, N), R is N mod 2, K is N - R, M is K div 2, check(1, M, N, L).