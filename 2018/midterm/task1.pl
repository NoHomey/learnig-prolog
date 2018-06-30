min([H], H).
min([H|T], H) :- min(T, M), H =< M.
min([H|T], M) :- min(T, M), H > M.

max([H], H).
max([H|T], H) :- max(T, M), H >= M.
max([H|T], M) :- max(T, M), H < M.

mins_and_max([], [], []).
mins_and_max([H|T], [Min|Mins], [Max|Maxs]) :- min(H, Min), max(H, Max), mins_and_max(T, Mins, Maxs).

balance(L, B) :- mins_and_max(L, Mins, Maxs), min(Maxs, Min), max(Mins, Max), B is Max - Min.

listMember([H], H).
listMember([H|_], H).
listMember([H|T], M) :- not(H = M), listMember(T, M).

p(L) :- balance(L, B), not((listMember(L, X), not(listMember(X, B)))).