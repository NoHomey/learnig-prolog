listLength([], 0).
listLength([_|T], N) :- listLength(T, M), N is M + 1.

split([], [], [], 0).
split([H|T], [H|L], R, N) :- N > 0, mod(N, 2) =:= 1, N1 is N - 1, split(T, L, R, N1).
split([H|T], L, [H|R], N) :- N > 1, mod(N, 2) =:= 0, N1 is N - 1, split(T, L, R, N1).

split(List, L, R) :- listLength(List, N), split(List, L, R, N).

merge([], R, R).
merge(L, [], L).
merge([HL|L], [HR|R], [HR|T]) :- HR < HL, merge([HL|L], R, T).
merge([HL|L], [HR|R], [HL|T]) :- HR >= HL, merge(L, [HR|R], T).

mergeSort([], []).
mergeSort([H], [H]).
mergeSort([A, B], [B, A]) :- B < A.
mergeSort([A, B], [A, B]) :- B >= A.
mergeSort(List, Result) :- split(List, L, R),
    mergeSort(L, LS), mergeSort(R, RS), merge(LS, RS, Result).
