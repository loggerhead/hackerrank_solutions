-module(solution).
-export([main/0]).

main() ->
    {ok, [T]} = io:fread("", "~u"),
    lists:foreach(fun(_) ->
        Line = string:strip(io:get_line(""), right, $\n),
        Dict = lists:foldl(fun(Ch, Dict) -> dict:store(Ch, 0, Dict) end, dict:new(), "RGYB"),
        case check(Line, Dict) of
            true -> io:fwrite("True~n");
            false -> io:fwrite("False~n")
        end
    end, lists:seq(1, T)).

check([], Dict) -> [0, 0] == diff(Dict);
check(Line, Dict) ->
    [H|T] = Line,
    [RG, YB] = diff(Dict),
    case RG =< 1 andalso YB =< 1 of
        true -> check(T, dict:store(H, dict:fetch(H, Dict) + 1, Dict));
        false -> false
    end.

diff(Dict) ->
    [
        abs(dict:fetch($R, Dict) - dict:fetch($G, Dict)),
        abs(dict:fetch($Y, Dict) - dict:fetch($B, Dict))
    ].