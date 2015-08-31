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
    io:fwrite("~p~n", [count(L)]).

count(L) -> count(0, L).

count(N, []) -> N;
count(N, L) -> count(N+1, tl(L)).


