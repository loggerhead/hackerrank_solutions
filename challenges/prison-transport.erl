-module(solution).
-export([main/0]).

read_ints() ->
    {ok, Line} = file:read_line(standard_io),
    [binary_to_integer(X) || X <- binary:split(Line, binary:compile_pattern([<<" ">>, <<$\n>>]), [global]), X /= <<>>].

% timeout because `io:fread`, it is too slow, so change to `binary`
main() ->
    ok = io:setopts([binary]),
    [N] = read_ints(),
    [M] = read_ints(),
    Groups = lists:foldl(fun(_, Groups) ->
        [P, Q] = read_ints(),
        store_pair(P, Q, Groups)
    end, dict:new(), lists:seq(1, M)),
    Cost = calc_cost(N, union_groups(Groups)),
    io:fwrite("~b~n", [Cost]).

calc_cost(N, Groups) ->
    {Sum, Members} = lists:foldl(fun(K, {Sum, Members}) ->
        Group = dict:fetch(K, Groups),
        Length = sets:size(Group),
        Cost = roundup(math:sqrt(Length)),
        {Sum + Cost, Members + Length}
    end, {0, 0}, dict:fetch_keys(Groups)),
    Sum + N-Members.

union_groups(Groups) ->
    union_groups(Groups, dict:fetch_keys(Groups)).

union_groups(Groups, []) -> Groups;
union_groups(Groups, [Key|Keys]) ->
    case dict:find(Key, Groups) of
        {ok, Group} ->
            {Group2, Groups2} = union_group(Group, sets:to_list(Group), Groups),
            union_groups(dict:store(Key, Group2, Groups2), Keys);
        error -> union_groups(Groups, Keys)
    end.

union_group(Group, [], Groups) -> {Group, Groups};
union_group(Group, [Key|Keys], Groups) ->
    case dict:find(Key, Groups) of
        {ok, G} -> union_group(sets:union(Group, G), Keys ++ sets:to_list(G), dict:erase(Key, Groups));
        error -> union_group(Group, Keys, Groups)
    end.

store_pair(P, Q, Groups) ->
    Group1 = case dict:find(P, Groups) of
        {ok, G1} -> sets:add_element(Q, G1);
        error -> sets:add_element(Q, sets:new())
    end,
    Group2 = case dict:find(Q, Groups) of
        {ok, G2} -> sets:add_element(P, G2);
        error -> sets:add_element(P, sets:new())
    end,
    dict:store(P, Group1, dict:store(Q, Group2, Groups)).

roundup(Num) ->
    Down = trunc(Num),
    if
        Down == Num -> Down;
        Down /= Num -> Down+1
    end.