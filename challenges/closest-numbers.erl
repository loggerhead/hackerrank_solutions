% Last testcase aborted...Maybe is too slow
-module(solution).
-export([main/0]).

read_numbers(N) ->
    Format = string:join(lists:map(fun(_) -> "~d" end, lists:seq(1, N)), " "),
    {ok, Nums} = io:fread("", Format),
    Nums.

main() ->
    {ok, [N]} = io:fread("", "~u"),
    Nums = read_numbers(N),
    Pairs = find_min_pairs(lists:sort(Nums)),
    print_pairs(Pairs).

find_min_pairs(Nums) ->
    [N1|T] = Nums,
    N2 = hd(T),
    find_min_pairs(T, [{N1, N2}], N2-N1).

find_min_pairs([_], Res, _) -> Res;
find_min_pairs(Nums, Res, Min) ->
    [N1|T] = Nums,
    N2 = hd(T),
    Diff = N2-N1,
    if 
        Diff < Min -> find_min_pairs(T, [{N1, N2}], N2-N1);
        Diff == Min -> find_min_pairs(T, lists:append(Res, [{N1, N2}]), Min);
        Diff > Min -> find_min_pairs(T, Res, Min)
    end.

print_pairs(Pairs) ->
    Print_pair = fun({N1,N2}) -> io_lib:format("~B ~B", [N1, N2]) end,
    Res = string:join(lists:map(Print_pair, Pairs), " "),
    io:fwrite("~s~n", [Res]).