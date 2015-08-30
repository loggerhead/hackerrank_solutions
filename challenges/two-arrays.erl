-module(solution).
-export([main/0]).

main() ->
    {ok, [T]} = io:fread("", "~u"),
    lists:foreach(fun(_) -> test_two_arrays() end, lists:seq(1, T)).

test_two_arrays() ->
    {ok, [N, K]} = io:fread("", "~u ~u"),
    Format = string:join(lists:map(fun(_) -> "~d" end, lists:seq(1, N)), " "),
    {ok, A} = io:fread("", Format),
    {ok, B} = io:fread("", Format),
    Sa = lists:sort(A),
    Sb = lists:sort(fun(X, Y) -> X > Y end, B),
    case lists:all(fun({X, Y}) -> X + Y >= K end, lists:zip(Sa, Sb)) of
        true -> io:fwrite("YES~n");
        false -> io:fwrite("NO~n")
    end.