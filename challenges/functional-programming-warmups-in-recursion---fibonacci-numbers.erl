-module(solution).
-export([main/0]).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    io:fwrite("~p~n", [fib(N)]).

fib(1) -> 0;
fib(2) -> 1;
fib(N) -> fib(N-1) + fib(N-2).
