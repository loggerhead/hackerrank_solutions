-module(solution).
-export([main/0]).

read_nums() -> read_nums([]).

read_nums(L) ->
    case io:fread("", "~d") of
        eof -> L;
        {ok, [Num]} -> read_nums(L ++ [Num])
    end.

main() ->
    L = read_nums(),
    [io:fwrite("~p~n", [lists:nth(I, L)]) || I <- lists:seq(2, length(L), 2)].
