-module(solution).
-export([main/0]).

main() ->
    {ok, [X]} = io:fread("", "~d"),
    io:fwrite("~p~n", [length(lists:seq(1, X))]).
