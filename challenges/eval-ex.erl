-module(solution).
-export([main/0]).

read_nums() -> read_nums([]).

read_nums(L) ->
    case io:fread("", "~f") of
        eof -> L;
        {ok, [Num]} -> read_nums(L ++ [Num])
    end.

main() ->
    _ = io:fread("", "~d"),
    L = read_nums(),
    [io:fwrite("~.4f~n", [Num]) || Num <- [exp(X) || X <- L]].

exp(Num) -> exp(Num, 1, 1).
    
exp(_, Sum, 10) -> Sum;
exp(X, Sum, N) ->
    Seq = lists:seq(1, N),
    Deno = lists:foldr(fun(I, Res) -> I*Res end, 1, Seq),
    exp(X, Sum+math:pow(X, N)/Deno, N+1).
