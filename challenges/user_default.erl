-module(user_default).
-compile(export_all).
-define(INPUT, "input").

d() ->
    compile_and_run(fun() ->
        Output = os:cmd("erl -noshell -eval 'solution:main(),init:stop()' < " ++ ?INPUT),
        io:fwrite("~s", [Output])
    end).

t() -> compile_and_run(fun solution:main/0).

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
        _:_ -> file:write_file(?INPUT, reinput())
    end.

reinput() ->
    S = read_util("EOF"),
    catch ets:new(stdin, [set, public, named_table]),
    ets:insert(stdin, {data, S}),
    S.

read_util(Stop) ->
    Line = io:get_line(""),
    Line2 = string:strip(Line, right, $\n),
    if
        Line2 == Stop -> "";
        Line2 /= Stop -> Line ++ read_util(Stop)
    end.