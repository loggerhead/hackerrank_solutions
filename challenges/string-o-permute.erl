-module(solution).
-export([main/0]).

main() ->
    {ok, [T]} = io:fread("", "~d"),
    Strs = [swap_str(string:strip(io:get_line(""), both, $\n)) || _ <- lists:seq(1,T)],
    [io:fwrite("~s~n", [S]) || S <- Strs].

swap_str([]) -> [];
swap_str(S) ->
    [A,B|T] = S,
    [B,A|swap_str(T)].
