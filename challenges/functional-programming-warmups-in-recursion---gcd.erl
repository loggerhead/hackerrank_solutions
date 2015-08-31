-module(solution).
-export([main/0]).

main() ->
    {ok, [X, Y]} = io:fread("", "~d ~d"),
    io:fwrite("~p~n", [gcd(X, Y)]).

gcd(X, Y) ->
    if 
        X =< 1 -> 1;
        X > Y -> gcd(X-Y, Y);
        X == Y -> X;
        X < Y -> gcd(Y-X, X)
    end.
