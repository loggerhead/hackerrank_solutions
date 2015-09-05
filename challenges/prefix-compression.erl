-module(solution).
-export([main/0]).

main() ->
    X = string:strip(io:get_line(""), right, $\n),
    Y = string:strip(io:get_line(""), right, $\n),
    {P, X2, Y2} = find_prefix(X, Y),
    io:fwrite("~p ~s~n", [length(P), P]),
    io:fwrite("~p ~s~n", [length(X2), X2]),
    io:fwrite("~p ~s~n", [length(Y2), Y2]).

find_prefix(X, Y) when X == []; Y == [] -> {[], X, Y};
find_prefix(X, Y) ->
    [Ch1|X2] = X,
    [Ch2|Y2] = Y,
    if 
        Ch1 == Ch2 -> 
            {P, X3, Y3} = find_prefix(X2, Y2),
            {[Ch1] ++ P, X3, Y3};
        Ch1 /= Ch2 -> 
            {[], X, Y}
    end.
