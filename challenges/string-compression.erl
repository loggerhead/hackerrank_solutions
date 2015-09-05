-module(solution).
-export([main/0]).

main() ->
    S = string:strip(io:get_line(""), both, $\n),
    io:fwrite("~s~n", [compress(S)]).

compress(S) ->
    compress(S, none, 0).

compress([], Ch, Times) -> 
    if
        Times < 1 -> [];
        Times == 1 -> [Ch];
        Times > 1 -> [Ch|integer_to_list(Times)]
    end;
compress(S, Ch, Times) ->
    [H|T] = S,
    if 
        Ch == H -> compress(T, Ch, Times+1);
        Ch /= H -> compress([], Ch, Times) ++ compress(T, H, 1)
    end.
