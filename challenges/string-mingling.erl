-module(solution).
-export([main/0]).

main() ->
    P = string:strip(io:get_line(""), right, $\n),
    Q = string:strip(io:get_line(""), right, $\n),
    R = lists:flatten([[A, B] || {A, B} <- lists:zip(P, Q)]),
    io:fwrite("~s~n", [R]).
