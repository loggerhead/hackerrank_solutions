-module(solution).
-export([main/0]).
-define(PRECISION, 0.001).

main() ->
    As = [list_to_integer(S) || S <- string:tokens(io:get_line(""), " \n")],
    Bs = [list_to_integer(S) || S <- string:tokens(io:get_line(""), " \n")],
    [L, R] = [list_to_integer(S) || S <- string:tokens(io:get_line(""), " \n")],
    io:fwrite("~.1f~n~.1f~n", calc(As, Bs, L, R)).

f(As, Bs, X) -> 
    lists:foldr(fun({A, B}, Sum) -> A*math:pow(X, B) + Sum end, 0, lists:zip(As, Bs)).

calc(_, _, L, R) when L >= R -> [0, 0];
calc(As, Bs, L, R) ->
    Y = f(As, Bs, L),
    [Area, Volume] = calc(As, Bs, L+?PRECISION, R),
    [Y*?PRECISION + Area, math:pi()*Y*Y*?PRECISION + Volume].
