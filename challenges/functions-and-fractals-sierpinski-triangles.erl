-module(solution).
-export([main/0]).
-define(R, 32).
-define(C, 63).

main() ->
    {ok, [N]} = io:fread("", "~u"),
    print_sierpinski_triangle(N).

print_sierpinski_triangle(N) ->
    {_, Triangles} = create(N),
    io:fwrite("~s", [lists:flatten(Triangles)]).

create(0) ->
    {?R, [[string:centre(lists:duplicate(2*I-1, $1), ?C, $_) ++ "\n" || I <- lists:seq(1,?R)]]};
create(N) ->
    {PrevH, Triangles} = create(N-1),
    H = PrevH div 2,
    Ts = lists:map(fun(Triangle) ->
            {Up, Down} = lists:split(H, Triangle),
            down_minus_1(Up, Down)
        end,
        Triangles),
    {H, lists:append([[A,B] || {A,B} <- Ts])}.

down_minus_1(Up, Down) ->
    RDown = lists:reverse(Down),
    Lines = lists:map(fun({Line1, Line2}) -> xor_1(Line1, Line2) end, lists:zip(Up, RDown)),
    {_, RDown2} = lists:unzip(Lines),
    {Up, lists:reverse(RDown2)}.

xor_1(Line1, Line2) ->
    Lines = lists:zip(Line1, Line2),
    Lines2 = lists:map(fun({C1, C2}) ->
            C = if
                C1 == C2 andalso C2 == $1 -> $_;
                true -> C2
            end,
            {C1, C}
        end, Lines),
    lists:unzip(Lines2).