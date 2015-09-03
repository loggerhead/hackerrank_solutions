-module(solution).
-export([main/0]).
-define(R, 63).
-define(C, 100).
-define(H, 16).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    print_y(N).

print_y(N) ->
    {_, L} = create_reverse_y(N),
    L2 = lists:duplicate(?R - length(L), lists:duplicate(?C, $_)) ++ lists:reverse(L),
    io:fwrite("~s~n", [string:join(L2, "\n")]).

create_reverse_y(H, W) ->
    [string:centre("1", W, $_) || _ <- lists:seq(1, H)] ++
    [string:centre("1" ++ lists:duplicate(2*I-1, $_) ++ "1", W, $_) || I <- lists:seq(1, H)].

create_reverse_y(1) ->
    {?H, create_reverse_y(?H, ?C)};
create_reverse_y(N) ->
    {PrevH, Trees} = create_reverse_y(N-1),
    CrntH = PrevH div 2,
    YNums = ?H div CrntH,
    Lines = lists:map(fun(Line) ->
            string:centre(lists:flatten(lists:duplicate(YNums, Line)), ?C, $_)
        end, create_reverse_y(CrntH, PrevH*2)),
    {CrntH, Trees ++ Lines}.