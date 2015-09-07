-module(solution).
-export([main/0]).

main() ->
    Grid = [string:strip(io:get_line(""), both, $\n) || _ <- lists:seq(1, 10)],
    Words = string:tokens(string:strip(io:get_line(""), both, $\n), ";"),
    io:fwrite("~s~n", [string:join(fillin(Grid, lists:sort(Words)), "\n")]).

fillin(Grid, Words) ->
    try fillin(get_points(Grid), Words, dict:new()) of
        _ -> ["error"]
    catch
        _:Dict ->
            Len = length(Grid),
            lists:map(fun(Y) ->
                lists:map(fun(X) ->
                    try dict:fetch({X, Y}, Dict) of
                        Ch -> Ch
                    catch
                        _:_ -> $+
                    end
                end, lists:seq(1, Len))
            end, lists:seq(1, Len))
    end.

fillin([], [], Dict) -> throw(Dict);
fillin(Points, Words, Dict) ->
    [Word|Words2] = Words,
    lists:foldl(fun(Span, {Ps, D}) ->
        if
            length(Span) == length(Word) ->
                case save(Span, Word, Dict) of
                    false -> {Ps, D};
                    Dict2 ->
                        fillin(lists:delete(Span, Ps), Words2, Dict2),
                        {Ps, D}
                end;
            length(Span) /= length(Word) -> {Ps, D}
        end
    end, {Points, Dict}, Points).

save([], [], Dict) -> Dict;
save(Span, Word, Dict) ->
    [Point|Span2] = Span,
    [Ch|Word2] = Word,
    try dict:fetch(Point, Dict) of
        Ch2 ->
            if
                Ch == Ch2 -> save(Span2, Word2, Dict);
                Ch /= Ch2 -> false
            end
    catch
        _:_ -> save(Span2, Word2, dict:store(Point, Ch, Dict))
    end.

get_indexs(Line) ->
    {Indexs, Span} = lists:foldl(fun(I, {Spans, Span}) ->
        case lists:nth(I, Line) of
            $- -> {Spans, Span ++ [I]};
            _  -> {Spans ++ [Span], []}
        end
    end, {[], []}, lists:seq(1, length(Line))),
    Indexs ++ [Span].

get_points(Grid) ->
    Points = lists:foldl(fun(I, Points) ->
        XSpans = lists:filtermap(fun(Span) ->
            if
                length(Span) > 1 -> {true, [{X, I} || X <- Span]};
                true -> false
            end
        end, get_indexs(lists:nth(I, Grid))),
        YSpans = lists:filtermap(fun(Span) ->
            if
                length(Span) > 1 -> {true, [{I, Y} || Y <- Span]};
                true -> false
            end
        end, get_indexs([lists:nth(I, Row) || Row <- Grid])),
        Points ++ XSpans ++ YSpans
    end, [], lists:seq(1, length(Grid))),
    lists:delete([], lists:usort(Points)).