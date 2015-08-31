-module(solution).
-export([main/0]).

read_nums() -> read_nums([]).

read_nums(L) ->
    case io:fread("", "~d") of
        eof -> L;
        {ok, [Num]} -> read_nums(L ++ [Num])
    end.

main() ->
    {ok, [N]} = io:fread("", "~d"),
    L = read_nums(),
    lists:foreach(fun(X) -> io:fwrite("~p~n", [X]) end, repeat(N, L)).

repeat(N, L) ->
    lists:flatten([lists:duplicate(N, X) || X <- L]).
