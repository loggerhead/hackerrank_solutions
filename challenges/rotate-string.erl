-module(solution).
-export([main/0]).

main() ->
    {ok, [T]} = io:fread("", "~u"),
    lists:foreach(fun(_) ->
        S = string:strip(io:get_line(""), right, $\n),
        N = length(S),
        lists:foldr(fun(_, R) ->
            R2 = rotate(R),
            io:fwrite("~s ", [R2]),
            R2
        end, S, lists:seq(1, N)),
        io:fwrite("~n") 
    end, lists:seq(1, T)).

rotate(S) -> 
    [H|T] = S,
    T ++ [H].
