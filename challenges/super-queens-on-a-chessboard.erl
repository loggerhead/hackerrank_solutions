-module(solution).
-export([main/0]).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    super_queens(N).

super_queens(N) ->
    Is = lists:seq(1, N),
    io:fwrite("~b~n", [count([Is || _ <- Is], N)]).

count([], 0) -> 1;
count([], _) -> 0;
count(Grid, N) ->
    [First|Lines] = Grid,
    case First of
        [] -> 0;
        _ELSE ->
            lists:foldl(fun(C, Sum) ->
                Grid2 = lists:map(fun(R) ->
                    Row = lists:nth(R, Lines),
                    case R of
                        1 -> Row -- [C, C-1, C+1, C-2, C+2];
                        2 -> Row -- [C, C-1, C+1, C-2, C+2];
                        _ -> Row -- [C, C+R, C-R]
                    end
                end, lists:seq(1, length(Lines))),
                Sum + count(Grid2, N-1)
            end, 0, First)
    end.