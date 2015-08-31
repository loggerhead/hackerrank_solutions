-module(solution).
-export([main/0]).

read_nums() -> read_nums([]).

read_nums(L) ->
    case io:fread("", "~d") of
        eof -> L;
        {ok, [Num]} -> read_nums(L ++ [Num])
    end.

main() ->
    {ok, [X]} = io:fread("", "~d"),
    L = read_nums(),
    lists:foreach(fun(N) -> io:fwrite("~p~n", [N]) end, [N || N <- L, N < X]).
