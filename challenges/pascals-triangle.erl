-module(solution).
-export([main/0]).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    print_pascal(N).

print_pascal(1) -> io:fwrite("1~n"), [1];
print_pascal(N) ->
    Up = print_pascal(N-1),
    {Row1, Last} = lists:mapfoldr(fun(Crnt, Prev) -> {Prev+Crnt, Crnt} end, 0, Up),
    Row2 = lists:reverse(Row1) ++ [Last],
    io:fwrite("~s~n", [string:join([integer_to_list(X) || X <- Row2], " ")]),
    Row2.
