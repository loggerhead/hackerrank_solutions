-module(solution).
-export([main/0]).

main() ->
    {ok, [N|_]} = io:fread("", "~u"),
     Grid = read_grid(N),
     M = (N+1) div 2,
     {X, Y} = search_princess(Grid),
     print_moves(M, X, Y).

read_grid(N) -> 
    read_grid([], N).
read_grid(Grid, 0) -> Grid;
read_grid(Grid, N) ->
    {ok, Line} = io:fread("", "~s"),
    read_grid(lists:append(Grid, Line), N-1).

search_princess(Grid) ->
    search_princess(Grid, 1).
search_princess([], _) -> {0, 0};
search_princess(Rows, Y) ->
    [Row|Remain] = Rows,
    case string:str(Row, "p") of
        0 -> search_princess(Remain, Y+1);
        X -> {X, Y}
    end.

print_moves(M, X, Y) ->
    print_moves(M-X, M-Y).
print_moves(Dx, Dy) ->
    if 
        Dy > 0 -> Msgy = "UP";
        Dy < 0 -> Msgy = "DOWN"
    end,
    if 
        Dx > 0 -> Msgx = "LEFT";
        Dx < 0 -> Msgx = "RIGHT"
    end,
    print_msgs(Msgy, Dy),
    print_msgs(Msgx, Dx).

print_msgs(Msg, N) ->
    lists:foreach(fun(_) -> io:fwrite("~s~n", [Msg]) end, lists:seq(1, abs(N))).