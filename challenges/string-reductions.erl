-module(solution).
-export([main/0]).

main() ->
    S = io:get_line(""),
    io:fwrite("~s", [unique(S)]).

unique(S) ->
    unique(S, sets:new()).

unique([], _) -> [];
unique(S, Set) ->
    [H|T] = S,
    case sets:is_element(H, Set) of
        true -> unique(T, Set);
        false -> [H] ++ unique(T, sets:add_element(H, Set))
    end.
