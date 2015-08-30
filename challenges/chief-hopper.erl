-module(solution).
-export([main/0]).

read_numbers(N) ->
    Format = string:join(lists:map(fun(_) -> "~d" end, lists:seq(1, N)), " "),
    {ok, Nums} = io:fread("", Format),
    Nums.

main() ->
    {ok, [N]} = io:fread("", "~u"),
    Nums = read_numbers(N),
    RNums = lists:reverse(Nums),
    E = lists:foldl(fun(X, Sum) -> roundup((X+Sum)/2) end, 0, RNums),
    io:fwrite("~B~n", [roundup(max(E, hd(Nums)/2))]).

roundup(Num) ->
    Down = trunc(Num),
    if
        Down < Num -> Down + 1;
        true -> Down
    end.