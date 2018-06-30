% generates all naturals as the seq 0, 1, 2, ...
nat(0).
nat(N):- nat(M), N is M + 1.

% generates all numbers A, A + 1, A + 2, ..., B 
between(A, B, A):- A =< B.
between(A, B, R):- A < B, A1 is A + 1, between(A1, B, R).

% generates all lists with K naturals that have sum S
genKS(1, S, [S]).
genKS(K, S, [Curr|Result]):- K > 1, K1 is K - 1, 
	between(0, S, Curr), S1 is S - Curr, genKS(K1, S1, Result).

% generate all seqs of naturals, by generating a natural N,
% which is split into 1 <= K <= N, and S = N - K, and than generates
% the next seq with K elements that have sum S.
genAll([]).
genAll(L):- nat(N), between(1, N, K), S is N - K, genKS(K, S, L).