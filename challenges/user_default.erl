-module(user_default).
-compile(export_all).
-define(INPUT, "input.txt").

d() ->
    compile_and_run(fun() ->
        Expre = ["{_, Secs1, Micro1} = now()",
                 "solution:main()",
                 "{_, Secs2, Micro2} = now()",
                 "io:fwrite(\"~nUsed: ~f s~n\", [Secs2-Secs1 + (Micro2-Micro1)/1000000])",
                 "init:stop()"],
        Output = os:cmd("erl -noshell -eval '" ++ string:join(Expre, ",") ++ "' < " ++ ?INPUT),
        io:fwrite("~s", [Output])
    end).

t() -> 
    {_, Secs1, Micro1} = now(),
    compile_and_run(fun solution:main/0),
    {_, Secs2, Micro2} = now(),
    io:fwrite("~nUsed: ~f s~n", [Secs2-Secs1 + (Micro2-Micro1)/1000000]).

compile_and_run(F) ->
    Module = solution,
    code:purge(Module),
    case compile:file(Module) of
        {ok, _} ->
            case code:load_file(Module) of
                {module, _} -> F();
                _ELSE -> 'load failed'
            end;
        _ELSE -> 'compile failed'
    end.

input() ->
    try ets:lookup(stdin, data) of
        [{data, S}] -> S
    catch
        _:_ -> reinput()
    end.

reinput() ->
    S = read_util("EOF"),
    catch ets:new(stdin, [set, public, named_table]),
    ets:insert(stdin, {data, S}),
    file:write_file(?INPUT, S),
    S.

read_util(Stop) ->
    Line = io:get_line(""),
    Line2 = re:replace(Line, "(^\\s+)|(\\s+$)", "", [global,{return,list}]),
    if
        Line2 == Stop -> "";
        Line2 /= Stop -> Line2 ++ "\n" ++ read_util(Stop)
    end.
