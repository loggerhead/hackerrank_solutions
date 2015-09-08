-module(solution).
-export([main/0]).

main() ->
    {ok, [X]} = io:fread("", "~d"),
    {ok, [N]} = io:fread("", "~d"),
    io:fwrite("~b~n", [count(X, N)]).

count(X, N) ->
    count(X, N, []).

count(X, _, _) when X < 0 -> 0;
count(0, _, _) -> 1;
count(X, N, Viewed) ->
    Max = trunc(math:pow(X, 1/N)),
    {Res, _} = lists:foldl(fun(I, {Res, Viewed2}) ->
        Diff = trunc(math:pow(I, N)),
        Viewed3 = Viewed2 ++ [I],
        {Res + count(X-Diff, N, Viewed3), Viewed3}
    end, {0, Viewed}, lists:seq(Max, 1, -1) -- Viewed),
    Res.