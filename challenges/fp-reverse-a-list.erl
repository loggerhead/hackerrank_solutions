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
    reverse_print(L).

reverse_print([]) -> ok;
reverse_print(L) ->
    reverse_print(tl(L)),
    io:fwrite("~p~n", [hd(L)]).
