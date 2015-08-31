-module(solution).
-export([main/0]).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    lists:foreach(fun(_) -> io:fwrite("Hello World~n") end, lists:seq(1,N)).
