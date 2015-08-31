-module(solution).
-export([main/0]).

main() ->
    {ok, [A, B]} = io:fread("", "~d~d"),
    io:fwrite("~p~n", [A+B]).
