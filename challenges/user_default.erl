-module(user_default).
-compile(export_all).
-define(RED, <<"31">>).
-define(GREEN, <<"32">>).
-define(YELLOW, <<"33">>).
-define(ESC, <<"\e[">>).
-define(RST, <<"0">>).
-define(END, <<"m">>).

-define(FILTER_MODULES, [erl_eval, init]).
-define(INPUT, "input.txt").

d() -> d(solution).
d(M) ->
    compile_and_run(fun() ->
        Expre = ["Secs1 = user_default:seconds()",
                 atom_to_list(M) ++ ":main()",
                 "Secs2 = user_default:seconds()",
                 "io:fwrite(\"~nUsed: ~f s~n\", [Secs2-Secs1])",
                 "init:stop()"],
        Output = os:cmd("erl -noshell -eval '" ++ string:join(Expre, ",") ++ "' < " ++ ?INPUT),
        case string:str(Output, "erl_crash.dump") of
            0 -> io:fwrite(Output), ok;
            _ -> print_error(Output), error
        end
    end).

t() -> t(solution).
t(M) ->
    Secs1 = seconds(),
    compile_and_run(fun M:main/0),
    Secs2 = seconds(),
    io:fwrite("~nUsed: ~f s~n", [Secs2-Secs1]).

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

seconds() ->
    {Mega, Sec, Micro} = os:timestamp(),
    (Mega*1000000 + Sec) + Micro/1000000.

string_to_atom(S) ->
    {ok, Tokens, _} = erl_scan:string(S ++ "."),
    {ok, AbsForm} = erl_parse:parse_exprs(Tokens),
    {value, Atom, _} = erl_eval:exprs(AbsForm, erl_eval:new_bindings()),
    Atom.

color_string(S, Color) -> [<<?ESC/binary, Color/binary, ?END/binary>>, S, <<?ESC/binary, ?RST/binary, ?END/binary>>].

red_string(S) -> color_string(S, ?RED).

yellow_string(S) -> color_string(S, ?YELLOW).

green_string(S) -> color_string(S, ?GREEN).

tuple2string(Tuple) when not is_tuple(Tuple) -> io_lib:fwrite("~p", [Tuple]);
tuple2string(Tuple) ->
    lists:foldl(fun(Part, S) ->
        S ++ io_lib:fwrite(" ~p", [Part])
    end, "", tuple_to_list(Tuple)).

print_error_reason(Reason) ->
    Prefix = "** error: ",
    Suffix = case is_tuple(Reason) of
        true -> tuple2string(Reason);
        false -> io_lib:fwrite("~p", [Reason])
    end,
    Suffix2 = re:replace(Suffix, ",", ", ", [global, {return, list}]),
    io:fwrite(red_string(Prefix ++ Suffix2) ++ "\n").

print_involved_functions(Functions) ->
    Functions2 = lists:filter(fun({M, _, _, _}) -> not lists:member(M, ?FILTER_MODULES) end, Functions),
    lists:foreach(fun({M, F, Args, FileInfo}) ->
        MFA = io_lib:fwrite("~p:~p", [M, F]) ++
            case is_integer(Args) of
                true -> io_lib:fwrite("/~b", [Args]);
                false ->
                    Fmt = string:join(lists:duplicate(length(Args), "~p"), ","),
                    io_lib:fwrite("(" ++ Fmt ++ ")", Args)
            end,
        Info = case FileInfo of
            [{file, FileName}, {line, LineNum}] ->
                FileName2 = green_string(FileName),
                LineNum2 = green_string(integer_to_list(LineNum)),
                io_lib:fwrite(" (~s, line ~s)", [FileName2, LineNum2]);
            _ -> ""
        end,
        io:fwrite("       in call from " ++ yellow_string(MFA) ++ Info ++ "\n")
    end, Functions2).

print_error(S) ->
    [Errstr|_] = string:tokens(S, "\r\n"),
    {_, {Reason, Functions}} = string_to_atom(Errstr),
    print_error_reason(Reason),
    print_involved_functions(Functions).
