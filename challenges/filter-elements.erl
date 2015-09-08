-module(solution).
-export([main/0]).

main() ->
    {ok, [T]} = io:fread("", "~u"),
    lists:foreach(fun(_) ->
        {ok, [_, K]} = io:fread("", "~u ~u"),
        A = string:tokens(string:strip(io:get_line(""), right, $\n), " "),
        find_repeat(A, K)
    end, lists:seq(1, T)).

find_repeat(A, K) ->
    Dict = count(A, dict:new()),
    R = case lists:filter(fun(Num) -> dict:fetch(Num, Dict) >= K end, A) of
        [] -> ["-1"];
        Remain ->
            lists:foldl(fun(Num, Keep) ->
                case lists:member(Num, Keep) of
                    true -> Keep;
                    false -> Keep ++ [Num]
                end
            end, [], Remain)
    end,
    io:fwrite("~s\n", [string:join(R, " ")]).

count([], Dict) -> Dict;
count(A, Dict) ->
    [H|T] = A,
    case dict:is_key(H, Dict) of
        true -> count(T, dict:store(H, 1 + dict:fetch(H, Dict), Dict));
        false -> count(T, dict:store(H, 1, Dict))
    end.