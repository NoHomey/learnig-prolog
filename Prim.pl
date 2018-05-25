listLength([], 0).
listLength([_ | T], L) :- listLength(T, M), L is M + 1.

member([H | _], H).
member([H | T], X) :- not(H = X), member(T, X).

visited(Visited, V) :- listLength(Visited, L), listLength(V, L).

inCut(Visited, V1, V2) :- member(Visited, V1), not(member(Visited, V2)).

filterInCut(_, [], []).
filterInCut(Visited, [[V1, V2, W] | T], [[V1, V2, W] | R ]) :-
    inCut(Visited, V1, V2), filterInCut(Visited, T, R).
filterInCut(Visited, [[V1, V2, W] | T], [[V2, V1, W] | R ]) :-
        inCut(Visited, V2, V1), filterInCut(Visited, T, R).
filterInCut(Visited, [[V1, V2, _] | T], R) :-
    not(inCut(Visited, V1, V2)), not(inCut(Visited, V2, V1)), filterInCut(Visited, T, R).

minEdge([[V1, V2, W]], [V1, V2, W]).
minEdge([[V1, V2, W] | T], [V1, V2, W]) :- minEdge(T, [_, _, L]), W < L.
minEdge([[_, _, W] | T], [U1, U2, L]) :- minEdge(T, [U1, U2, L]), W >= L.

minEdge(Visited, E, Edge) :- filterInCut(Visited, E, F), minEdge(F, Edge).

mstPrim(Visited, V, _, []) :- visited(Visited, V).
mstPrim(Visited, V, E, [[V1, V2, W] | R]) :-
    not(visited(Visited, V)), minEdge(Visited, E, [V1, V2, W]),
    mstPrim([V2 | Visited], V, E, R).

mstPrim([[_], []], []).
mstPrim([[H|T], E], R) :- mstPrim([H], [H|T], E, R).
