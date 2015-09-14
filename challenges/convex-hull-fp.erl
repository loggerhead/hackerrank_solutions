% Graham
-module(solution).
-export([main/0]).

read_ints() ->
    {ok, Line} = file:read_line(standard_io),
    [binary_to_integer(X) || X <- binary:split(Line, binary:compile_pattern([<<" ">>, <<$\n>>]), [global]), X /= <<>>].

main() ->
    ok = io:setopts([binary]),
    [N] = read_ints(),
    Points = lists:map(fun(_) ->
        [X, Y] = read_ints(),
        {X, Y}
    end, lists:seq(1, N)),
    convex(sort_by_angle(Points, find_min(Points))).

convex([P0, P1|Points]) ->
    Hull = find_hull([P1, P0], Points),
    {_, Sum} = lists:foldl(fun(Pi, {Pj, Sum}) ->
        {Pi, Sum + distance(Pi, Pj)}
    end, {lists:last(Hull), 0}, Hull),
    io:fwrite("~.1f~n", [Sum]).

find_hull(Hull, []) -> Hull;
find_hull([P1], [P3|Points]) -> find_hull([P3, P1], Points);
find_hull([P2, P1|Hull], [P3|Points]) ->
    A12 = calc_angle(P1, P2),
    A13 = calc_angle(P1, P3),
    if
        A13 =< A12 -> find_hull([P1|Hull], [P3|Points]);
        A13 > A12 -> find_hull([P3, P2, P1|Hull], Points)
    end.

sort_by_angle(Points, P0) ->
    lists:sort(fun(P1, P2) ->
        A01 = calc_angle(P0, P1),
        A02 = calc_angle(P0, P2),
        if
            A01 <  A02 -> true;
            A01 == A02 -> distance(P0, P1) < distance(P0, P2);
            A01 >  A02 -> false
        end
    end, Points).

calc_angle({X0, Y0}, {X1, Y1}) ->
    Dx = X1 - X0,
    Dy = Y1 - Y0,
    if
        Dx >= 0, Dy == 0 -> 0.0;
        Dx >  0, Dy >  0 -> math:atan(Dy/Dx);
        Dx == 0, Dy >  0 -> math:pi()/2;
        Dx <  0, Dy >  0 -> math:pi() - abs(math:atan(Dy/Dx));
        Dx <  0, Dy == 0 -> math:pi();
        Dx <  0, Dy <  0 -> math:pi() + abs(math:atan(Dy/Dx));
        Dx == 0, Dy <  0 -> math:pi()*1.5;
        Dx >  0, Dy <  0 -> math:pi()*2 - abs(math:atan(Dy/Dx))
    end.

distance({X0, Y0}, {X1, Y1}) -> math:sqrt((X1-X0)*(X1-X0) + (Y1-Y0)*(Y1-Y0)).

find_min([P0|Points]) -> find_min(Points, P0).

find_min([], P0) -> P0;
find_min([P = {X, Y}|Points], P0 = {X0, Y0}) ->
    if
        Y < Y0 -> find_min(Points, P);
        Y == Y0 ->
            case X < X0 of
                true -> find_min(Points, P);
                false -> find_min(Points, P0)
            end;
        Y > Y0 -> find_min(Points, P0)
    end.
