-module(solution).
-export([main/0]).

main() ->
    {ok, [N, K]} = io:fread("", "~s ~u"),
    Sum = lists:foldl(fun(Digit, Sum) -> Sum + Digit - $0 end, 0, N),
    io:fwrite("~b~n", [super_digit(Sum*K)]).

super_digit(Num) when Num div 10 == 0 -> Num;
super_digit(Num) ->
    Sum = lists:foldl(fun(Digit, Sum) -> Sum + Digit - $0 end, 0, integer_to_list(Num)),
    super_digit(Sum).