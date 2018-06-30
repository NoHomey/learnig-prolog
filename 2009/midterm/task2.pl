% Задача 2. спец. „Компютърни науки“ 4.11.2009г.

% Да се дефинира на пролог предикат
% p(X, Y, K), който по даден списък от двуелементни списъци
% от естествени числа K генерира в X и Y всички
% двойки от естествени числа, за които е изпълнено поне
% едно от следните три условия:
% 1) [X − 1, Y + 100] е елементна K;
% 2) съществуват елементи [X1, Y1] и [X2, Y2] на K,
% такива че X = X1 * X2^2 и Y = Y1 + 2 * Y2 или
% 3) [X * Y, X^2 + Y] е елемент на K.

% Забележка:
% В програмите не трябва да се използват вградени предикати,
% освен евентуално =, is, not, <, >, =<, >=.
% При преудовлетворяване те не трябва да дават грешни отговори,
% нито да се зациклят. Не може да се използват без дефиниция предикати,
% които са правени на упражненията.

concat([], L, L).
concat([H|T], L, [H|R]) :- concat(T, L, R).

map2(_, _, [], []).
map2(X1, Y1, [[X2, Y2]|T], [[X, Y]|R]) :- X is X1 * X2 * X2, Y is Y1 + 2 * Y2, map2(X1, Y1, T, R).

divisors(_, 0, []).
divisors(N, D, [D|T]) :- D > 0, 0 is N mod D, M is D - 1, divisors(N, M, T).
divisors(N, D, L) :- D > 0, not(0 is N mod D), M is D - 1, divisors(N, M, L).

solutions(_, _, [], []).
solutions(XK, YK, [Y|T], [[X, Y]|R]) :- X is XK div Y, YK is X * X + Y, solutions(XK, YK, T, R).
solutions(XK, YK, [Y|T], L) :- X is XK div Y, not(YK is X * X + Y), solutions(XK, YK, T, L).

map3(XK, YK, R) :- divisors(XK, XK, D), solutions(XK, YK, D, R).

mapK([], []).
mapK([[XK, YK]| T], [[X1, Y1] | R]) :- X1 is XK + 1, Y1 is YK - 100, map2(XK, YK, T, L2),
                                        map3(XK, YK, L3), concat(L3, L2, L),
                                        mapK(T, TL), concat(L, TL, R).

%listMember([H], H).
%listMember([H|_], H).
%listMember([H|T], M) :- not(H = M), listMember(T, M).

listMember(L, X) :- concat(_, [X|_], L).

p(X, Y, K) :- mapK(K, L), print(L), listMember(L, [X, Y]).